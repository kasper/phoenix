/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHNotificationHelper.h"

@implementation PHNotificationHelper

#pragma mark - Delivering

+ (void) deliver:(NSString *)message {

    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.informativeText = message;
    notification.hasActionButton = NO;

    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
}

@end
