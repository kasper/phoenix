/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHTimerHandler.h"
#import "PHWeakTimerTarget.h"

@interface PHTimerHandler ()

@property NSTimer *timer;

@end

@implementation PHTimerHandler

#pragma mark - Initialising

- (instancetype) initWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats callback:(JSValue *)callback {

    if (self = [super initWithCallback:callback]) {

        PHWeakTimerTarget *weakTarget = [PHWeakTimerTarget withTarget:self selector:@selector(timerDidFire)];

        self.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                      target:weakTarget
                                                    selector:@selector(timerDidFireProxy:)
                                                    userInfo:nil
                                                     repeats:repeats];
    }

    return self;
}

#pragma mark - Timing

- (void) timerDidFire {

    [self callWithArguments:@[ self ]];
}

- (void) stop {

    [self.timer invalidate];
}

@end
