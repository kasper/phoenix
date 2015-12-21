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

static FourCharCode const PHKeyHandlerSignature = 'FNIX';
static UInt32 PHKeyHandlerIdentifierSequence;

static NSString * const PHKeyHandlerIdentifier = @"PHKeyHandlerIdentifier";
static NSString * const PHKeyHandlerKeyDownNotification = @"PHKeyHandlerKeyDownNotification";

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
                                                          userInfo:@{ PHKeyHandlerIdentifier: @(identifier.id) }];
        return noErr;
    }
}

#pragma mark - Initialise

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

- (instancetype) initWithKey:(NSString *)key modifiers:(NSArray<NSString *> *)modifiers {

    if (self = [super init]) {

        self.key = (key.length == 1) ? key.lowercaseString : key;
        self.modifiers = [modifiers valueForKey:@"lowercaseString"];
        self.keyCode = [PHKeyTranslator keyCodeForKey:self.key];
        self.modifierFlags = [PHKeyTranslator modifierFlagsForModifiers:self.modifiers];

        // Key not supported
        if (self.keyCode == UINT32_MAX) {
            NSLog(@"Warning: Key “%@” not supported.", self.key);
            return nil;
        }

        self.identifier = PHKeyHandlerIdentifierSequence++;

        // Observe key down notification
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyDown:)
                                                     name:PHKeyHandlerKeyDownNotification
                                                   object:nil];
        [self enable];
    }

    return self;
}

+ (instancetype) withKey:(NSString *)key modifiers:(NSArray<NSString *> *)modifiers {

    return [[PHKeyHandler alloc] initWithKey:key modifiers:modifiers];
}

#pragma mark - Dealloc

- (void) dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self name:PHKeyHandlerKeyDownNotification object:nil];
    [self disable];
}

#pragma mark - Hash

+ (NSUInteger) hashForKey:(NSString *)key modifiers:(NSArray<NSString *> *)modifiers {

    NSUInteger hash = key.hash;

    for (NSString *modifier in modifiers) {
        hash += modifier.hash;
    }

    return hash;
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

#pragma mark - Notification

- (void) keyDown:(NSNotification *)notification {

    // This handler should handle this notification
    if (self.identifier == [notification.userInfo[PHKeyHandlerIdentifier] unsignedIntegerValue]) {
        [self call];
    }
}

@end
