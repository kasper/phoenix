/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface PHKeyTranslator : NSObject

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;

#pragma mark - Translating

+ (UInt32) modifierFlagsForModifiers:(NSArray<NSString *> *)modifiers;
+ (NSArray<NSString *> *) modifiersForModifierFlags:(UInt32)modifierFlags;
+ (UInt32) keyCodeForKey:(NSString *)key;

@end
