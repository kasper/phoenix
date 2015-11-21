/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHAXObserver.h"
#import "PHWindow.h"

@interface PHAXObserver ()

@property id element;

// AXObserverRef
@property id observer;

@end

@implementation PHAXObserver

#pragma mark - AXObserverCallback

static void PHAXObserverCallback(__unused AXObserverRef observer,
                                 AXUIElementRef element,
                                 CFStringRef notification,
                                 __unused void *data) {
    @autoreleasepool {

        PHWindow *window = [[PHWindow alloc] initWithElement:CFBridgingRelease(CFRetain(element))];

        [[NSNotificationCenter defaultCenter] postNotificationName:(__bridge NSString *) notification
                                                            object:nil
                                                          userInfo:@{ PHAXObserverWindowKey: window }];
    }
}

#pragma mark - Initialise

- (instancetype) initWithApp:(NSRunningApplication *)app {

    if (self = [super initWithElement:CFBridgingRelease(AXUIElementCreateApplication(app.processIdentifier))]) {

        AXObserverRef observer = NULL;
        AXError error = AXObserverCreate(app.processIdentifier, PHAXObserverCallback, &observer);

        if (error != kAXErrorSuccess) {
            NSLog(@"Error: Could not create accessibility observer for app %@. (%d)", app, error);
            return nil;
        }

        self.observer = CFBridgingRelease(observer);
        [self setup];
    }

    return self;
}

#pragma mark - Dealloc

- (void) dealloc {

    for (NSString *notification in [PHAXObserver notifications]) {
        [self removeNotification:notification];
    }
}

#pragma mark - Notifications

+ (NSArray<NSString *> *) notifications {

    static NSArray<NSString *> *notifications;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        notifications = @[ NSAccessibilityWindowCreatedNotification,
                           NSAccessibilityUIElementDestroyedNotification,
                           NSAccessibilityFocusedWindowChangedNotification,
                           NSAccessibilityWindowMovedNotification,
                           NSAccessibilityWindowResizedNotification,
                           NSAccessibilityWindowMiniaturizedNotification,
                           NSAccessibilityWindowDeminiaturizedNotification ];
    });

    return notifications;
}

#pragma mark - Observing

- (void) addNotification:(NSString *)notification {

    AXObserverAddNotification((__bridge AXObserverRef) self.observer,
                              (__bridge AXUIElementRef) self.element,
                              (__bridge CFStringRef) notification,
                              NULL);
}

- (void) removeNotification:(NSString *)notification {

    AXObserverRemoveNotification((__bridge AXObserverRef) self.observer,
                                 (__bridge AXUIElementRef) self.element,
                                 (__bridge CFStringRef) notification);
}

#pragma mark - Setup

- (void) setup {

    CFRunLoopAddSource(CFRunLoopGetCurrent(),
                       AXObserverGetRunLoopSource((__bridge AXObserverRef) self.observer),
                       kCFRunLoopDefaultMode);

    for (NSString *notification in [PHAXObserver notifications]) {
        [self addNotification:notification];
    }
}

@end
