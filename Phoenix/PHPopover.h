/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
#import "PHAXUIElement.h"

@interface PHPopover : NSObject <NSPopoverDelegate>

#pragma mark - Init

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initForElement:(PHAXUIElement *)element NS_DESIGNATED_INITIALIZER;

#pragma mark - Display

- (void) show;
- (void) close;
- (BOOL) isClosed;
- (BOOL) isForElement:(PHAXUIElement *)el;

@end
