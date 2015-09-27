/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHEventHandler.h"
#import "PHEventTranslator.h"

@interface PHEventHandler ()

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
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveNotification:)
                                                     name:self.notification
                                                   object:nil];
    }

    return self;
}

#pragma mark - Dealloc

- (void) dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self name:self.notification object:nil];
}

#pragma mark - Notification

- (void) didReceiveNotification:(NSNotification *)__unused notification {

    [self call];
}

@end
