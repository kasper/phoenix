/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface PHEventTranslator : NSObject

#pragma mark - Notification Center

+ (NSNotificationCenter *) notificationCenterForNotification:(NSString *)notification;

#pragma mark - Translate

+ (NSString *) notificationForString:(NSString *)string;

@end
