/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

@interface PHKeyTranslator : NSObject

#pragma mark - Translate

+ (NSString *) charactersForEvent:(NSEvent *)event;

@end
