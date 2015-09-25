/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface PHKeyTranslator : NSObject

#pragma mark - Translate

+ (UInt32) modifierFlagsForModifiers:(NSArray<NSString *> *)modifiers;
+ (UInt32) keyCodeForString:(NSString *)string;

@end
