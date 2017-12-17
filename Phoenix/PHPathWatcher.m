/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHPathWatcher.h"

@interface PHPathWatcher ()

@property FSEventStreamRef stream;
@property (copy) NSArray<NSString *> *paths;
@property (copy) void (^handler)(void);

@end

@implementation PHPathWatcher

#pragma mark - FSEventStreamCallback

static void PHFSEventStreamCallback(__unused ConstFSEventStreamRef stream,
                                    void *callback,
                                    __unused size_t count,
                                    __unused void *paths,
                                    __unused FSEventStreamEventFlags const flags[],
                                    __unused FSEventStreamEventId const ids[]) {
    @autoreleasepool {

        PHPathWatcher *watcher = (__bridge PHPathWatcher *) callback;
        [watcher fileDidChange];
    }
}

#pragma mark - Initialising

- (instancetype) initWithPaths:(NSArray<NSString *> *)paths handler:(void (^)(void))handler {

    if (self = [super init]) {

        self.paths = paths;
        self.handler = handler;

        [self setup];
    }

    return self;
}

+ (instancetype) watcherFor:(NSArray<NSString *> *)paths handler:(void (^)(void))handler {

    return [[self alloc] initWithPaths:paths handler:handler];
}

#pragma mark - Deallocing

- (void) dealloc {

    FSEventStreamStop(self.stream);
    FSEventStreamInvalidate(self.stream);
    FSEventStreamRelease(self.stream);
}

#pragma mark - Setting up

- (void) setup {

    FSEventStreamContext context;

    context.version = 0;
    context.info = (__bridge void *) self;
    context.retain = NULL;
    context.release = NULL;
    context.copyDescription = NULL;

    self.stream = FSEventStreamCreate(NULL,
                                      PHFSEventStreamCallback,
                                      &context,
                                      (__bridge CFArrayRef) self.paths,
                                      kFSEventStreamEventIdSinceNow,
                                      1.0,
                                      kFSEventStreamCreateFlagWatchRoot |
                                      kFSEventStreamCreateFlagFileEvents);

    FSEventStreamScheduleWithRunLoop(self.stream, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    BOOL started = FSEventStreamStart(self.stream);

    if (!started) {
        NSLog(@"Error: Could not start event stream %@ for observing file changes.", self.stream);
    }
}

#pragma mark - Event Handling

- (void) fileDidChange {

    self.handler();
}

@end
