/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Carbon;

#import "PHKeyTranslator.h"

@implementation PHKeyTranslator

static NSDictionary *PHUnicodeCharacterToString;

#pragma mark - Initialise

+ (void) initialize {

    PHUnicodeCharacterToString = @{ @(13): @"return",
                                    @(27): @"escape",
                                    @(32): @"space",

                                    /* Characters from NSText */

                                    @(NSTabCharacter): @"tab",
                                    @(NSEnterCharacter): @"enter",
                                    @(NSDeleteCharacter): @"delete",

                                    /* Function Keys from NSEvent */

                                    @(NSUpArrowFunctionKey): @"up",
                                    @(NSDownArrowFunctionKey): @"down",
                                    @(NSLeftArrowFunctionKey): @"left",
                                    @(NSRightArrowFunctionKey): @"right",
                                    @(NSF1FunctionKey): @"f1",
                                    @(NSF2FunctionKey): @"f2",
                                    @(NSF3FunctionKey): @"f3",
                                    @(NSF4FunctionKey): @"f4",
                                    @(NSF5FunctionKey): @"f5",
                                    @(NSF6FunctionKey): @"f6",
                                    @(NSF7FunctionKey): @"f7",
                                    @(NSF8FunctionKey): @"f8",
                                    @(NSF9FunctionKey): @"f9",
                                    @(NSF10FunctionKey): @"f10",
                                    @(NSF11FunctionKey): @"f11",
                                    @(NSF12FunctionKey): @"f12",
                                    @(NSF13FunctionKey): @"f13",
                                    @(NSF14FunctionKey): @"f14",
                                    @(NSF15FunctionKey): @"f15",
                                    @(NSF16FunctionKey): @"f16",
                                    @(NSF17FunctionKey): @"f17",
                                    @(NSF18FunctionKey): @"f18",
                                    @(NSF19FunctionKey): @"f19",
                                    @(NSDeleteFunctionKey): @"forwardDelete",
                                    @(NSHomeFunctionKey): @"home",
                                    @(NSEndFunctionKey): @"end",
                                    @(NSPageUpFunctionKey): @"pageUp",
                                    @(NSPageDownFunctionKey): @"pageDown",
                                    @(NSClearLineFunctionKey): @"clear",
                                    @(NSHelpFunctionKey): @"help" };
}

#pragma mark - Translate

+ (NSString *) characterForKeyCode:(unsigned short)keyCode {

    id currentKeyboard = CFBridgingRelease(TISCopyCurrentKeyboardInputSource());
    CFDataRef layoutData = TISGetInputSourceProperty((__bridge TISInputSourceRef) currentKeyboard,
                                                     kTISPropertyUnicodeKeyLayoutData);
    UCKeyboardLayout * const keyboardLayout = (UCKeyboardLayout * const) CFDataGetBytePtr(layoutData);

    UInt32 deadKeyState = 0;
    UniCharCount maxStringLength = 4;
    UniCharCount actualStringLength;
    UniChar unicodeString[maxStringLength];

    OSStatus error = UCKeyTranslate(keyboardLayout,
                                    keyCode,
                                    kUCKeyActionDisplay,
                                    0,
                                    LMGetKbdType(),
                                    kUCKeyTranslateNoDeadKeysBit,
                                    &deadKeyState,
                                    maxStringLength,
                                    &actualStringLength,
                                    unicodeString);
    if (error != noErr) {
        NSLog(@"Error: Could not translate key code %hu to a Unicode character using the keyboard layout. (%d)", keyCode, error);
        return nil;
    }

    return [NSString stringWithCharacters:unicodeString length:actualStringLength];
}

+ (NSString *) charactersForEvent:(NSEvent *)event {

    // No key character
    if (event.charactersIgnoringModifiers.length == 0) {
        return nil;
    }

    NSString *characters = PHUnicodeCharacterToString[@([event.charactersIgnoringModifiers characterAtIndex:0])];

    if (characters) {
        return characters;
    }

    return [self characterForKeyCode:event.keyCode];
}

@end
