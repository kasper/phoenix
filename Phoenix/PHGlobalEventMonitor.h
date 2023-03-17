/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

static NSString* const PHGlobalEventMonitorMouseKey = @"PHGlobalEventMonitorMouse";

@interface PHGlobalEventMonitor : NSObject

#pragma mark - Initialising

+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)monitor;

@end
