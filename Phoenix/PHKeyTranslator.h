/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

@interface PHKeyTranslator : NSObject

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;

#pragma mark - Translating

+ (UInt32) modifierFlagsForModifiers:(NSArray<NSString *> *)modifiers;
+ (NSArray<NSString *> *) modifiersForModifierFlags:(NSEventModifierFlags)modifierFlags;
+ (UInt32) keyCodeForKey:(NSString *)key;

@end
