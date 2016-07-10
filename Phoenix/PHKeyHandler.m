/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Carbon;

#import "PHKeyHandler.h"
#import "PHKeyTranslator.h"

@interface PHKeyHandler ()

@property UInt32 identifier;
@property UInt32 keyCode;
@property UInt32 modifierFlags;
@property EventHotKeyRef reference;
@property BOOL enabled;

@property (copy) NSString *key;
@property (copy) NSArray<NSString *> *modifiers;

@end

@implementation PHKeyHandler

static UInt32 PHKeyHandlerIdentifierSequence;
static FourCharCode const PHKeyHandlerSignature = 'FNIX';

static NSString * const PHKeyHandlerIdentifierKey = @"PHKeyHandlerIdentifier";
static NSString * const PHKeyHandlerKeyDownNotification = @"PHKeyHandlerKeyDownNotification";
static NSString * const PHKeyHandlerWillEnableNotification = @"PHKeyHandlerWillEnableNotification";

#pragma mark - CarbonEventCallback

static OSStatus PHCarbonEventCallback(__unused EventHandlerCallRef handler,
                                      EventRef event,
                                      __unused void *data) {
    @autoreleasepool {

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
                                                          userInfo:@{ PHKeyHandlerIdentifierKey: @(identifier.id) }];
        return noErr;
    }
}

#pragma mark - Initialising

+ (void) initialize {

    if (self == [PHKeyHandler self]) {

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
}

- (instancetype) initWithKey:(NSString *)key modifiers:(NSArray<NSString *> *)modifiers callback:(JSValue *)callback {

    if (self = [super initWithCallback:callback]) {

        self.key = (key.length == 1) ? key.lowercaseString : key;
        self.modifiers = [modifiers valueForKey:@"lowercaseString"];
        self.keyCode = [PHKeyTranslator keyCodeForKey:self.key];
        self.modifierFlags = [PHKeyTranslator modifierFlagsForModifiers:self.modifiers];

        // Key not supported
        if (self.keyCode == UINT32_MAX) {
            NSLog(@"Warning: Key “%@” not supported.", self.key);
            return self;
        }

        self.identifier = PHKeyHandlerIdentifierSequence++;

        // Observe key enable event
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willEnable:)
                                                     name:PHKeyHandlerWillEnableNotification
                                                   object:nil];
        // Observe key down event
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyDown:)
                                                     name:PHKeyHandlerKeyDownNotification
                                                   object:nil];
        [self enable];
    }

    return self;
}

#pragma mark - Deallocing

- (void) dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self name:PHKeyHandlerWillEnableNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PHKeyHandlerKeyDownNotification object:nil];
    [self disable];
}

#pragma mark - Identifying

- (NSUInteger) hashForKeyCombination {

    NSUInteger hash = self.key.hash;

    for (NSString *modifier in self.modifiers) {
        hash += modifier.hash;
    }

    return hash;
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

    [[NSNotificationCenter defaultCenter] postNotificationName:PHKeyHandlerWillEnableNotification object:self];

    EventHotKeyID identifier = { .signature = PHKeyHandlerSignature, .id = self.identifier };
    OSStatus error = RegisterEventHotKey(self.keyCode,
                                         self.modifierFlags,
                                         identifier,
                                         GetEventDispatcherTarget(),
                                         kEventHotKeyExclusive,
                                         &_reference);
    if (error != noErr) {
        NSLog(@"Error: Could not register key %d (%d) with modifiers %d. (%d)", self.keyCode, identifier.id, self.modifierFlags, error);
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

#pragma mark - Notification Handling

- (void) willEnable:(NSNotification *)notification {

    // Yield for other key handler
    if ([self hashForKeyCombination] == [notification.object hashForKeyCombination]) {
        [self disable];
    }
}

- (void) keyDown:(NSNotification *)notification {

    // This handler should handle this notification
    if (self.identifier == [notification.userInfo[PHKeyHandlerIdentifierKey] unsignedIntegerValue]) {
        [self callWithArguments:@[ self ]];
    }
}

@end
