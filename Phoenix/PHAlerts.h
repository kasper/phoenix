/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

static NSTimeInterval const PHAlertsDefaultDuration = 2.0;

@protocol PHAlertDelegate <NSObject>

- (void) alertDidClose:(id)sender;

@end

@interface PHAlerts : NSObject <PHAlertDelegate>

#pragma mark - Shared Alerts

+ (PHAlerts *) sharedAlerts;

#pragma mark - Displaying

- (void) show:(NSString *)message duration:(NSTimeInterval)duration;
- (void) show:(NSString *)message;

#pragma mark - Closing

- (void) closeAlerts;

@end
