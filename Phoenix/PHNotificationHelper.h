/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface PHNotificationHelper : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Delivering

+ (void)deliver:(NSString *)message withDelegate:(id<NSUserNotificationCenterDelegate>)delegate;

@end
