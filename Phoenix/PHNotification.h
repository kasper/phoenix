/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface PHNotification : NSObject

#pragma mark - Delivering

+ (void) deliver:(NSString *)message;

@end
