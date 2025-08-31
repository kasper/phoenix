/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import UserNotifications;

#import "PHNotificationHelper.h"

@implementation PHNotificationHelper

static NSString *const PHNotificationHelperIdentifier = @"org.khirviko.Phoenix";

#pragma mark - Delivering

+ (void)deliver:(NSString *)message categoryIdentifier:(NSString *)identifier {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.body = message;

    if (identifier) {
        content.categoryIdentifier = identifier;
    }

    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:PHNotificationHelperIdentifier
                                                                          content:content
                                                                          trigger:nil];
    [center addNotificationRequest:request
             withCompletionHandler:^(NSError *error) {
                 if (error) {
                     NSLog(@"Error: Could not deliver notification. (%@)", error);
                 }
             }];
}

@end
