/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Carbon;

#import "PHKeyHandler.h"
#import "PHKeyTranslator.h"

@interface PHKeyHandler ()

@property UInt32 identifier;
@property EventHotKeyRef reference;
@property BOOL enabled;

@property NSString *key;
@property NSArray *modifiers;

@end

@implementation PHKeyHandler

static FourCharCode const PHKeyHandlerSignature = 'FNIX';
static UInt32 PHKeyHandlerIdentifierSequence;

#pragma mark - Initialise

static OSStatus PHCarbonEventCallback(__unused EventHandlerCallRef handler,
                                      EventRef event,
                                      __unused void *callback) {
    EventHotKeyID identifier;
    OSStatus error = GetEventParameter(event,
                                       kEventParamDirectObject,
                                       typeEventHotKeyID,
                                       NULL,
                                       sizeof(identifier),
                                       NULL,
                                       &identifier);
    if (error != noErr) {
        NSLog(@"Error: Could not get key event identifier. (%d)", error);
        return error;
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:PHKeyHandlerKeyDownNotification
                                                        object:nil
                                                      userInfo:@{ PHKeyHandlerIdentifier: @(identifier.id) }];
    return noErr;
}

+ (void) initialize {

    EventTypeSpec keyDown = { .eventClass = kEventClassKeyboard, .eventKind = kEventHotKeyPressed };
    OSStatus error = InstallEventHandler(GetEventDispatcherTarget(),
                                         PHCarbonEventCallback,
                                         1,
                                         &keyDown,
                                         NULL,
                                         NULL);
    if (error != noErr) {
        NSLog(@"Error: Could not install key event handler. (%d)", error);
    }
}

+ (PHKeyHandler *) withKey:(NSString *)key modifiers:(NSArray *)modifiers handler:(PHKeyHandlerBlock)handler {

    PHKeyHandler *keyHandler = [[PHKeyHandler alloc] init];

    keyHandler.identifier = PHKeyHandlerIdentifierSequence++;
    keyHandler.key = key;
    keyHandler.modifiers = modifiers;
    keyHandler.handler = handler;

    [keyHandler enable];

    return keyHandler;
}

#pragma mark - Hash

+ (NSUInteger) hashForKey:(NSString *)key modifiers:(NSArray *)modifiers {

    return key.hash + [modifiers hash];
}

#pragma mark - Identifying

- (NSUInteger) hash {

    return [PHKeyHandler hashForKey:self.key modifiers:self.modifiers];
}

- (BOOL) isEqual:(id)object {

    return [object isKindOfClass:[PHKeyHandler class]] && [self hash] == [object hash];
}

#pragma mark - Binding

- (BOOL) isEnabled {

    return self.enabled;
}

- (BOOL) enable {

    // Already enabled
    if ([self isEnabled]) {
        return YES;
    }

    UInt32 keyCode = [PHKeyTranslator keyCodeForString:self.key];
    UInt32 modifierFlags = [PHKeyTranslator modifierFlagsForModifiers:self.modifiers];
    EventHotKeyID identifier = { .signature = PHKeyHandlerSignature, .id = self.identifier };

    OSStatus error = RegisterEventHotKey(keyCode,
                                         modifierFlags,
                                         identifier,
                                         GetEventDispatcherTarget(),
                                         kEventHotKeyExclusive,
                                         &_reference);
    if (error != noErr) {
        NSLog(@"Error: Could not register key %d (%d) with modifiers %d. (%d)", keyCode, identifier.id, modifierFlags, error);
        return NO;
    }

    self.enabled = YES;
    return YES;
}

- (BOOL) disable {

    // Not enabled
    if (![self isEnabled]) {
        return YES;
    }

    OSStatus error = UnregisterEventHotKey(self.reference);

    if (error != noErr) {
        NSLog(@"Error: Could not unregister key %d. (%d)", self.identifier, error);
        return NO;
    }

    self.reference = NULL;
    self.enabled = NO;

    return YES;
}

#pragma mark - Invoke

- (void) invoke {

    self.handler();
}

@end
