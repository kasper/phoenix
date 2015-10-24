/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Carbon;

#import "PHKeyTranslator.h"

@implementation PHKeyTranslator

#pragma mark - Modifier

+ (NSNumber *) flagForModifier:(NSString *)modifier {

    static NSDictionary<NSString *, NSNumber *> *modifierToFlag;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        modifierToFlag = @{ @"cmd": @(cmdKey),
                            @"alt": @(optionKey),
                            @"ctrl": @(controlKey),
                            @"shift": @(shiftKey) };
    });

    return modifierToFlag[modifier];
}

#pragma mark - Local Key

+ (NSString *) characterForKeyCode:(unsigned short)keyCode {

    id currentKeyboard = CFBridgingRelease(TISCopyCurrentKeyboardInputSource());

    // Unicode layout
    CFDataRef layoutData = TISGetInputSourceProperty((__bridge TISInputSourceRef) currentKeyboard,
                                                     kTISPropertyUnicodeKeyLayoutData);
    // Non-unicode layout
    if (!layoutData) {
        currentKeyboard = CFBridgingRelease(TISCopyCurrentASCIICapableKeyboardInputSource());
        layoutData = TISGetInputSourceProperty((__bridge TISInputSourceRef) currentKeyboard,
                                               kTISPropertyUnicodeKeyLayoutData);
    }

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

+ (NSNumber *) keyCodeForLocalKey:(NSString *)key {

    static NSMutableDictionary<NSString *, NSNumber *> *localKeyToKeyCode;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        NSArray<NSNumber *> *localKeyCodes = @[ @(kVK_ANSI_A),
                                                @(kVK_ANSI_B),
                                                @(kVK_ANSI_C),
                                                @(kVK_ANSI_D),
                                                @(kVK_ANSI_E),
                                                @(kVK_ANSI_F),
                                                @(kVK_ANSI_G),
                                                @(kVK_ANSI_H),
                                                @(kVK_ANSI_I),
                                                @(kVK_ANSI_J),
                                                @(kVK_ANSI_K),
                                                @(kVK_ANSI_L),
                                                @(kVK_ANSI_M),
                                                @(kVK_ANSI_N),
                                                @(kVK_ANSI_O),
                                                @(kVK_ANSI_P),
                                                @(kVK_ANSI_Q),
                                                @(kVK_ANSI_R),
                                                @(kVK_ANSI_S),
                                                @(kVK_ANSI_T),
                                                @(kVK_ANSI_U),
                                                @(kVK_ANSI_V),
                                                @(kVK_ANSI_W),
                                                @(kVK_ANSI_X),
                                                @(kVK_ANSI_Y),
                                                @(kVK_ANSI_Z),
                                                @(kVK_ANSI_0),
                                                @(kVK_ANSI_1),
                                                @(kVK_ANSI_2),
                                                @(kVK_ANSI_3),
                                                @(kVK_ANSI_4),
                                                @(kVK_ANSI_5),
                                                @(kVK_ANSI_6),
                                                @(kVK_ANSI_7),
                                                @(kVK_ANSI_8),
                                                @(kVK_ANSI_9),
                                                @(kVK_ANSI_Equal),
                                                @(kVK_ANSI_Minus),
                                                @(kVK_ANSI_RightBracket),
                                                @(kVK_ANSI_LeftBracket),
                                                @(kVK_ANSI_Quote),
                                                @(kVK_ANSI_Semicolon),
                                                @(kVK_ANSI_Backslash),
                                                @(kVK_ANSI_Comma),
                                                @(kVK_ANSI_Slash),
                                                @(kVK_ANSI_Period),
                                                @(kVK_ANSI_Grave) ];

        localKeyToKeyCode = [NSMutableDictionary dictionary];

        // Resolve local keys
        for (NSNumber *keyCode in localKeyCodes) {
            NSString *resolvedKey = [self characterForKeyCode:keyCode.unsignedShortValue];
            localKeyToKeyCode[resolvedKey] = keyCode;
        }
    });

    return localKeyToKeyCode[key];
}

#pragma mark - Special Key

+ (NSNumber *) keyCodeForSpecialKey:(NSString *)key {

    static NSDictionary<NSString *, NSNumber *> *specialKeyToKeyCode;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        specialKeyToKeyCode = @{ /* Action Keys */

                                 @"return": @(kVK_Return),
                                 @"tab": @(kVK_Tab),
                                 @"space": @(kVK_Space),
                                 @"delete": @(kVK_Delete),
                                 @"escape": @(kVK_Escape),
                                 @"help": @(kVK_Help),
                                 @"home": @(kVK_Home),
                                 @"pageUp": @(kVK_PageUp),
                                 @"forwardDelete": @(kVK_ForwardDelete),
                                 @"end": @(kVK_End),
                                 @"pageDown": @(kVK_PageDown),
                                 @"left": @(kVK_LeftArrow),
                                 @"right": @(kVK_RightArrow),
                                 @"down": @(kVK_DownArrow),
                                 @"up": @(kVK_UpArrow),

                                 /* Function Keys */

                                 @"f1": @(kVK_F1),
                                 @"f2": @(kVK_F2),
                                 @"f3": @(kVK_F3),
                                 @"f4": @(kVK_F4),
                                 @"f5": @(kVK_F5),
                                 @"f6": @(kVK_F6),
                                 @"f7": @(kVK_F7),
                                 @"f8": @(kVK_F8),
                                 @"f9": @(kVK_F9),
                                 @"f10": @(kVK_F10),
                                 @"f11": @(kVK_F11),
                                 @"f12": @(kVK_F12),
                                 @"f13": @(kVK_F13),
                                 @"f14": @(kVK_F14),
                                 @"f15": @(kVK_F15),
                                 @"f16": @(kVK_F16),
                                 @"f17": @(kVK_F17),
                                 @"f18": @(kVK_F18),
                                 @"f19": @(kVK_F19),

                                 /* Keypad Keys */

                                 @"keypad.": @(kVK_ANSI_KeypadDecimal),
                                 @"keypad*": @(kVK_ANSI_KeypadMultiply),
                                 @"keypad+": @(kVK_ANSI_KeypadPlus),
                                 @"keypadClear": @(kVK_ANSI_KeypadClear),
                                 @"keypad/": @(kVK_ANSI_KeypadDivide),
                                 @"keypadEnter": @(kVK_ANSI_KeypadEnter),
                                 @"keypad-": @(kVK_ANSI_KeypadMinus),
                                 @"keypad=": @(kVK_ANSI_KeypadEquals),
                                 @"keypad0": @(kVK_ANSI_Keypad0),
                                 @"keypad1": @(kVK_ANSI_Keypad1),
                                 @"keypad2": @(kVK_ANSI_Keypad2),
                                 @"keypad3": @(kVK_ANSI_Keypad3),
                                 @"keypad4": @(kVK_ANSI_Keypad4),
                                 @"keypad5": @(kVK_ANSI_Keypad5),
                                 @"keypad6": @(kVK_ANSI_Keypad6),
                                 @"keypad7": @(kVK_ANSI_Keypad7),
                                 @"keypad8": @(kVK_ANSI_Keypad8),
                                 @"keypad9": @(kVK_ANSI_Keypad9) };
    });

    return specialKeyToKeyCode[key];
}

#pragma mark - Translate

+ (UInt32) modifierFlagsForModifiers:(NSArray<NSString *> *)modifiers {

    UInt32 flags = 0;

    for (NSString *modifier in modifiers) {

        NSNumber *flag = [self flagForModifier:modifier];

        if (flag) {
            flags |= flag.unsignedIntValue;
        }
    }

    return flags;
}

+ (UInt32) keyCodeForKey:(NSString *)key {

    // Local key
    NSNumber *keyCode = [self keyCodeForLocalKey:key];

    if (keyCode) {
        return keyCode.unsignedIntValue;
    }

    // Special key
    keyCode = [self keyCodeForSpecialKey:key];

    if (keyCode) {
        return keyCode.unsignedIntValue;
    }

    // Not supported
    return UINT32_MAX;
}

@end
