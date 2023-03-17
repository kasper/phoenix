/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHAXUIElement.h"

static NSString *const PHAXObserverWindowKey = @"PHAXObserverWindow";

@interface PHAXObserver : PHAXUIElement

#pragma mark - Initialising

- (instancetype)initWithApp:(NSRunningApplication *)app;

@end
