/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHEventConstants.h"
#import "PHGlobalEventMonitor.h"
#import "PHMouse.h"

@interface PHGlobalEventMonitor ()

@property NSMutableArray *monitors;

@end

@implementation PHGlobalEventMonitor

#pragma mark - Initialising

- (instancetype) init {

    if (self = [super init]) {
        self.monitors = [NSMutableArray array];
        [self setup];
    }

    return self;
}

+ (instancetype) monitor {

    return [[self alloc] init];
}

#pragma mark - Deallocing

- (void) dealloc {

    for (id monitor in self.monitors) {
        [NSEvent removeMonitor:monitor];
    }
}

#pragma mark - Masks

+ (NSArray<NSNumber *> *) masks {

    static NSArray<NSNumber *> *masks;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        masks = @[ @(NSMouseMovedMask),
                   @(NSLeftMouseUpMask),
                   @(NSRightMouseUpMask),
                   @(NSLeftMouseDraggedMask),
                   @(NSRightMouseDraggedMask) ];
    });

    return masks;
}

#pragma mark - Notifications

+ (NSDictionary<NSNumber *, NSString *> *) notifications {

    static NSDictionary<NSNumber *, NSString *> *notifications;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        notifications = @{ @(NSMouseMoved): PHMouseDidMoveNotification,
                           @(NSLeftMouseUp): PHMouseDidLeftClickNotification,
                           @(NSRightMouseUp): PHMouseDidRightClickNotification,
                           @(NSLeftMouseDragged): PHMouseDidLeftDragNotification,
                           @(NSRightMouseDragged): PHMouseDidRightDragNotification };
    });

    return notifications;
}

#pragma mark - Setting up

- (void) setup {

    NSDictionary<NSNumber *, NSString *> *notifications = [PHGlobalEventMonitor notifications];

    for (NSNumber *mask in [PHGlobalEventMonitor masks]) {

        // Add global monitor for event mask
        id monitor = [NSEvent addGlobalMonitorForEventsMatchingMask:mask.unsignedLongLongValue
                                                            handler:^(NSEvent *event) {

            NSString *notification = notifications[@(event.type)];
            NSMutableDictionary<NSString *, id> *userInfo = [NSMutableDictionary dictionary];

            // Event for mouse
            if ([notification hasPrefix:NSStringFromClass([PHMouse class])]) {
                CGPoint location = [PHMouse location];
                userInfo[PHGlobalEventMonitorMouseKey] = @{ @"x": @(location.x), @"y": @(location.y) };
            }

            [[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil userInfo:userInfo];
        }];

        [self.monitors addObject:monitor];
    }
}

@end
