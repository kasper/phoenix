/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

static NSString * const PHPreferencesDidChangeNotification = @"PHPreferencesDidChangeNotification";

@interface PHPreferences : NSObject

#pragma mark - Initialise

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;

#pragma mark - Shared Preferences

+ (instancetype) sharedPreferences;

#pragma mark - Preferences

- (void) add:(NSDictionary<NSString *, id> *)preferences;
- (void) reset;

- (BOOL) isDaemon;

@end
