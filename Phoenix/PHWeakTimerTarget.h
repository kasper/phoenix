/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface PHWeakTimerTarget : NSObject

#pragma mark - Initialising

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;

- (instancetype) initWithTarget:(id)target selector:(SEL)selector NS_DESIGNATED_INITIALIZER;
+ (instancetype) withTarget:(id)target selector:(SEL)selector;

#pragma mark - Timing

- (void) timerDidFireProxy:(NSTimer *)timer;

@end
