/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHAlerts.h"
#import "PHAlertWindowController.h"

@interface PHAlerts ()

@property NSMutableArray *alerts;

@end

@implementation PHAlerts

#pragma mark - Shared Alerts

+ (PHAlerts *) sharedAlerts {

    static PHAlerts *sharedAlerts;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        sharedAlerts = [[PHAlerts alloc] init];
        sharedAlerts.alerts = [NSMutableArray array];
    });

    return sharedAlerts;
}

#pragma mark - PHAlertDelegate

- (void) alertDidClose:(id)sender {

    [self.alerts removeObject:sender];
}

#pragma mark - Displaying

- (void) show:(NSString *)message duration:(NSTimeInterval)duration {

    NSScreen *currentScreen = [NSScreen mainScreen];
    CGFloat adjustment = currentScreen.frame.size.height / 1.5;

    // Push down to be the last alert
    if (self.alerts.count > 0) {
        PHAlertWindowController *lastAlert = self.alerts.lastObject;
        adjustment = lastAlert.window.frame.origin.y - 3.0;
    }

    // End of screen, move to top
    if (adjustment <= 0) {
        adjustment = NSMaxY(currentScreen.visibleFrame);
    }

    PHAlertWindowController *alert = [[PHAlertWindowController alloc] initWithDelegate:self];
    [alert show:message duration:duration pushDownBy:adjustment];

    [self.alerts addObject:alert];
}

- (void) show:(NSString *)message {

    [self show:message duration:PHAlertsDefaultDuration];
}

#pragma mark - Closing

- (void) closeAlerts {

    [[self.alerts reverseObjectEnumerator].allObjects makeObjectsPerformSelector:@selector(fadeWindowOut)];
}

@end
