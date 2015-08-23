/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

@interface PHAlertWindowController : NSWindowController

#pragma mark - Initialise

- (instancetype) initWithDelegate:(id<PHAlertDelegate>)delegate;

#pragma mark - Displaying

- (void) show:(NSString *)message duration:(NSTimeInterval)duration pushDownBy:(CGFloat)adjustment;

#pragma mark - Closing

- (void) fadeWindowOut;

@end
