/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHOpenAtLoginHelper.h"
#import "PHPreferences.h"

@interface PHPreferences ()

@property NSMutableDictionary<NSString *, id> *preferences;

@end

@implementation PHPreferences

#pragma mark - Initialising

- (instancetype) init {

    if (self = [super init]) {
        self.preferences = [NSMutableDictionary dictionary];
        [self load];
    }

    return self;
}

#pragma mark - Shared Preferences

+ (instancetype) sharedPreferences {

    static id sharedPreferences;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        sharedPreferences = [[self alloc] init];
    });

    return sharedPreferences;
}

#pragma mark - Preferences

- (void) preferencesDidChange {

    [[NSNotificationCenter defaultCenter] postNotificationName:PHPreferencesDidChangeNotification object:nil];
}

- (void) load {

    self.preferences[PHPreferencesOpenAtLoginKey] = @([PHOpenAtLoginHelper opensAtLogin]);
}

- (void) add:(NSDictionary<PHPreferencesPreferenceKey, id> *)preferences {

    [self.preferences addEntriesFromDictionary:preferences];
    [self preferencesDidChange];
}

- (void) reset {

    [self.preferences removeAllObjects];
    [self load];
    [self preferencesDidChange];
}

- (BOOL) isDaemon {

    return [self.preferences[PHPreferencesDaemonKey] boolValue];
}

- (BOOL) openAtLogin {

    return [self.preferences[PHPreferencesOpenAtLoginKey] boolValue];
}

#pragma mark - Zoom Preferences

- (NSDictionary<NSString *, id> *) zoomPreferencse {
    id zoomPreferences = self.preferences[PHPreferencesZoomKey];

    if (zoomPreferences != nil) {
        return zoomPreferences;
    } else {
        return [NSDictionary dictionary];
    }
}

- (BOOL) zoomEnabled {
    return [[self zoomPreferencse][PHPreferencesZoomEnabledKey] boolValue];
}

- (NSString *) zoomModifier {
    return [self zoomPreferencse][PHPreferencesZoomModifierKey];
}

- (BOOL) zoomInverseModifierAction {
    return [[self zoomPreferencse][PHPreferencesZoomInverseModifierActionKey] boolValue];
}

- (BOOL) zoomBringToFront {
     return [[self zoomPreferencse][PHPreferencesZoomBringToFrontKey] boolValue];
}

- (BOOL) zoomActivateAfterRezie {
     return [[self zoomPreferencse][PHPreferencesZoomActivateAfterRezieKey] boolValue];
}
@end
