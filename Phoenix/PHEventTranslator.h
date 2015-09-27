/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface PHEventTranslator : NSObject

#pragma mark - Translate

+ (NSString *) notificationForString:(NSString *)string;

@end
