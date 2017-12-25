/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHOpenAtLoginHelper.h"
#import "PHPreferences.h"

@interface PHPreferences ()

@property NSMutableDictionary<NSString *, id> *preferences;

@end

@implementation PHPreferences

static NSString * const PHPreferencesDaemonKey = @"daemon";
static NSString * const PHPreferencesOpenAtLoginKey = @"openAtLogin";

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

- (void) add:(NSDictionary<NSString *, id> *)preferences {

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

@end
