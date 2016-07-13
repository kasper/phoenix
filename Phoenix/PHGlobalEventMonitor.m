/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHEventConstants.h"
#import "PHGlobalEventMonitor.h"

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
                   @(NSRightMouseUpMask) ];
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
                           @(NSRightMouseUp): PHMouseDidRightClickNotification };
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

            [[NSNotificationCenter defaultCenter] postNotificationName:notifications[@(event.type)] object:nil];
        }];

        [self.monitors addObject:monitor];
    }
}

@end
