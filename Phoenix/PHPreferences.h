/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

typedef NSString * PHPreferencesPreferenceKey;

static NSString * const PHPreferencesDidChangeNotification = @"PHPreferencesDidChangeNotification";
static PHPreferencesPreferenceKey const PHPreferencesDaemonKey = @"daemon";
static PHPreferencesPreferenceKey const PHPreferencesOpenAtLoginKey = @"openAtLogin";
static PHPreferencesPreferenceKey const PHPreferencesZoomKey = @"zoom";
static PHPreferencesPreferenceKey const PHPreferencesZoomEnabledKey = @"enabled";
static PHPreferencesPreferenceKey const PHPreferencesZoomModifierKey = @"modifier";
static PHPreferencesPreferenceKey const PHPreferencesZoomInverseModifierActionKey = @"inverseModifierAction";
static PHPreferencesPreferenceKey const PHPreferencesZoomBringToFrontKey = @"bringToFront";
static PHPreferencesPreferenceKey const PHPreferencesZoomActivateAfterRezieKey = @"activateAfterResize";

@interface PHPreferences : NSObject

#pragma mark - Initialising

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;

#pragma mark - Shared Preferences

+ (instancetype) sharedPreferences;

#pragma mark - Preferences

- (void) add:(NSDictionary<PHPreferencesPreferenceKey, id> *)preferences;
- (void) reset;

- (BOOL) isDaemon;
- (BOOL) openAtLogin;

#pragma mark - Zoom Preferences

- (NSDictionary<NSString *, id> *) zoomPreferencse;
- (BOOL) zoomEnabled;
- (NSString *) zoomModifier;
- (BOOL) zoomInverseModifierAction;
- (BOOL) zoomBringToFront;
- (BOOL) zoomActivateAfterRezie;
@end
