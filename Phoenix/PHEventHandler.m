/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHApp.h"
#import "PHEventHandler.h"
#import "PHEventTranslator.h"

@interface PHEventHandler ()

@property (weak) NSNotificationCenter *notificationCenter;
@property NSString *name;
@property NSString *notification;

@end

@implementation PHEventHandler

#pragma mark - Initialise

- (instancetype) initWithEvent:(NSString *)event {

    if (self = [super init]) {

        self.name = event;
        self.notification = [PHEventTranslator notificationForString:event];

        // Event not supported
        if (!self.notification) {
            NSLog(@"Warning: Event %@ not supported.", event);
            return nil;
        }

        // Listen to notification
        self.notificationCenter = [PHEventTranslator notificationCenterForNotification:self.notification];

        [self.notificationCenter addObserver:self
                                    selector:@selector(didReceiveNotification:)
                                        name:self.notification
                                      object:nil];
    }

    return self;
}

#pragma mark - Dealloc

- (void) dealloc {

    [self.notificationCenter removeObserver:self name:self.notification object:nil];
}

#pragma mark - Notification

- (void) didReceiveNotification:(NSNotification *)notification {

    // Notification for app
    NSRunningApplication *runningApp = notification.userInfo[NSWorkspaceApplicationKey];

    if (runningApp) {
        PHApp *app = [[PHApp alloc] initWithApp:runningApp];
        [self callWithArguments:@[ app ]];
        return;
    }

    [self call];
}

@end
