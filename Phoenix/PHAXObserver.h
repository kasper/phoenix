/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

static NSString * const PHAXObserverWindowKey = @"PHAXObserverWindowKey";

@interface PHAXObserver : NSObject

#pragma mark - Initialise

- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initWithApp:(NSRunningApplication *)app NS_DESIGNATED_INITIALIZER;

@end
