/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHApp.h"
#import "PHAXObserver.h"
#import "PHEventHandler.h"
#import "PHEventTranslator.h"
#import "PHWindow.h"

@interface PHEventHandler ()

@property (weak) NSNotificationCenter *notificationCenter;
@property (copy) NSString *name;
@property (copy) NSString *notification;

@end

@implementation PHEventHandler

#pragma mark - Initialise

- (instancetype) initWithEvent:(NSString *)event callback:(JSValue *)callback {

    if (self = [super init]) {

        self.name = event;
        self.notification = [PHEventTranslator notificationForEvent:event];

        [self manageCallback:callback];

        // Event not supported
        if (!self.notification) {
            NSLog(@"Warning: Event “%@” not supported.", event);
            return nil;
        }

        // Observe notification
        self.notificationCenter = [PHEventTranslator notificationCenterForNotification:self.notification];

        [self.notificationCenter addObserver:self
                                    selector:@selector(didReceiveNotification:)
                                        name:self.notification
                                      object:nil];
    }

    return self;
}

+ (instancetype) withEvent:(NSString *)event callback:(JSValue *)callback {

    return [[PHEventHandler alloc] initWithEvent:event callback:callback];
}

#pragma mark - Dealloc

- (void) dealloc {

    [self.notificationCenter removeObserver:self name:self.notification object:nil];
}

#pragma mark - Notification

- (void) didReceiveNotification:(NSNotification *)notification {

    /* Notification for app */

    NSRunningApplication *runningApp = notification.userInfo[NSWorkspaceApplicationKey];

    if (runningApp) {
        PHApp *app = [[PHApp alloc] initWithApp:runningApp];
        [self callWithArguments:@[ app ]];
        return;
    }

    /* Notification for window */

    PHWindow *window = notification.userInfo[PHAXObserverWindowKey];

    if (window) {
        [self callWithArguments:@[ window ]];
        return;
    }

    [self call];
}

@end
