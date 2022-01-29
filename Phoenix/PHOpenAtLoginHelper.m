/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import ServiceManagement;

#import "PHOpenAtLoginHelper.h"

@implementation PHOpenAtLoginHelper

static NSString * const PHUserDefaultsOpenAtLoginKey = @"PHOpenAtLogin";

#if DEBUG
static NSString * const PHLauncherBundleIdentifier = @"org.khirviko.Phoenix.Launcher.debug";
#else
static NSString * const PHLauncherBundleIdentifier = @"org.khirviko.Phoenix.Launcher";
#endif

#pragma mark - Login Item

+ (BOOL) opensAtLogin {

    return [[NSUserDefaults standardUserDefaults] boolForKey:PHUserDefaultsOpenAtLoginKey];
}

+ (void) setOpensAtLogin:(BOOL)opensAtLogin {

    BOOL didSet = SMLoginItemSetEnabled((__bridge CFStringRef) PHLauncherBundleIdentifier, opensAtLogin);

    if (didSet) {
        [[NSUserDefaults standardUserDefaults] setBool:opensAtLogin forKey:PHUserDefaultsOpenAtLoginKey];
    }
}

@end
