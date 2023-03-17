/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHNotificationHelper.h"

@implementation PHNotificationHelper

#pragma mark - Delivering

+ (void)deliver:(NSString *)message withDelegate:(id<NSUserNotificationCenterDelegate>)delegate {
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    center.delegate = delegate;

    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.informativeText = message;
    notification.hasActionButton = NO;

    if (delegate) {
        notification.hasActionButton = YES;
    }

    [center deliverNotification:notification];
}

@end
