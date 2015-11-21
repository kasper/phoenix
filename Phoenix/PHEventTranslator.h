/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface PHEventTranslator : NSObject

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;

#pragma mark - Notification Center

+ (NSNotificationCenter *) notificationCenterForNotification:(NSString *)notification;

#pragma mark - Notification

+ (NSString *) notificationForEvent:(NSString *)event;

@end
