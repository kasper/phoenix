/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHKeyHandler.h"

@interface PHKeyHandler ()

@property NSString *key;
@property NSArray *modifiers;
@property (copy) PHKeyHandlerBlock handler;

@end

@implementation PHKeyHandler

static NSDictionary *PHModifierStringToFlag;

#pragma mark - Initialise

+ (void) initialize {

    PHModifierStringToFlag = @{ @"cmd": @(NSCommandKeyMask),
                                @"alt": @(NSAlternateKeyMask),
                                @"ctrl": @(NSControlKeyMask),
                                @"shift": @(NSShiftKeyMask),
                                @"pad": @(NSNumericPadKeyMask) };
}

+ (PHKeyHandler *) withKey:(NSString *)key modifiers:(NSArray *)modifiers handler:(PHKeyHandlerBlock)handler {

    PHKeyHandler *keyHandler = [[PHKeyHandler alloc] init];

    keyHandler.key = key;
    keyHandler.modifiers = modifiers;
    keyHandler.enabled = YES;
    keyHandler.handler = handler;

    return keyHandler;
}

#pragma mark - Hash

+ (NSUInteger) hashForKey:(NSString *)key modifierFlags:(NSEventModifierFlags)flags {

    return key.hash + (flags & NSDeviceIndependentModifierFlagsMask);
}

#pragma mark - NSObject

- (NSUInteger) hash {

    NSUInteger flags = 0;

    for (NSString *modifier in [self.modifiers valueForKey:@"lowercaseString"]) {

        id flag = PHModifierStringToFlag[modifier];

        if (flag) {
            flags |= [flag intValue];
        }
    }

    return self.key.lowercaseString.hash + flags;
}

#pragma mark - Invoke

- (void) invoke {

    if (!self.enabled) {
        return;
    }

    self.handler();
}

@end
