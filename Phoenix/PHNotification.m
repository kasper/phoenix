/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHNotification.h"

@implementation PHNotification

#pragma mark - Delivering

+ (void) deliver:(NSString *)message {

    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.informativeText = message;

    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
}

@end
