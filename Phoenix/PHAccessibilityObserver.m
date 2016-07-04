/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHAccessibilityObserver.h"
#import "PHAXObserver.h"

@interface PHAccessibilityObserver ()

@property NSMutableDictionary<NSNumber *, PHAXObserver *> *observers;

@end

@implementation PHAccessibilityObserver

static NSString * const NSWorkspaceRunningApplicationsKeyPath = @"runningApplications";

#pragma mark - Initialising

- (instancetype) init {

    if (self = [super init]) {

        self.observers = [NSMutableDictionary dictionary];

        // Initialise observers for currently running applications
        [self observeApps:[NSWorkspace sharedWorkspace].runningApplications];

        // Observe changes in running applications
        [[NSWorkspace sharedWorkspace] addObserver:self
                                        forKeyPath:NSWorkspaceRunningApplicationsKeyPath
                                           options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                                           context:NULL];
    }
    
    return self;
}

+ (instancetype) observer {

    return [[self alloc] init];
}

#pragma mark - Deallocing

- (void) dealloc {

    [[NSWorkspace sharedWorkspace] removeObserver:self forKeyPath:NSWorkspaceRunningApplicationsKeyPath];
}

#pragma mark - Observing

- (void) observeApps:(NSArray<NSRunningApplication *> *)apps {

    for (NSRunningApplication *app in apps) {
        self.observers[@(app.processIdentifier)] = [[PHAXObserver alloc] initWithApp:app];
    }
}

- (void) removeApps:(NSArray<NSRunningApplication *> *)apps {

    for (NSRunningApplication *app in apps) {
        [self.observers removeObjectForKey:@(app.processIdentifier)];
    }
}

#pragma mark - KVO

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)__unused object
                         change:(NSDictionary<NSString *, id> *)change
                        context:(void *)__unused context {

    if ([keyPath isEqualToString:NSWorkspaceRunningApplicationsKeyPath]) {

        NSUInteger kind = [change[NSKeyValueChangeKindKey] unsignedIntegerValue];

        // Observe new apps
        if (kind == NSKeyValueChangeInsertion) {
            [self observeApps:change[NSKeyValueChangeNewKey]];
            return;
        }

        // Remove old apps
        if (kind == NSKeyValueChangeRemoval) {
            [self removeApps:change[NSKeyValueChangeOldKey]];
        }
    }
}

@end
