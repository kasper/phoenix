/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHWeakTimerTarget.h"

@interface PHWeakTimerTarget ()

@property (weak) id target;
@property SEL selector;

@end

@implementation PHWeakTimerTarget

#pragma mark - Initialise

- (instancetype) initWithTarget:(id)target selector:(SEL)selector {

    if (self = [super init]) {
        self.target = target;
        self.selector = selector;
    }

    return self;
}

+ (instancetype) withTarget:(id)target selector:(SEL)selector {

    return [[self alloc] initWithTarget:target selector:selector];
}

#pragma mark - Timing

- (void) timerDidFireProxy:(NSTimer *)timer {

    // Target is still alive
    if (self.target) {

        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"

        [self.target performSelector:self.selector];

        #pragma clang diagnostic pop

        return;
    }

    [timer invalidate];
}

@end
