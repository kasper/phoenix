/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHLauncherAppDelegate.h"

@interface PHLauncherAppDelegate ()

@end

@implementation PHLauncherAppDelegate

#if DEBUG
static NSString *const PHMainBundleIdentifier = @"org.khirviko.Phoenix.debug";
#else
static NSString *const PHMainBundleIdentifier = @"org.khirviko.Phoenix";
#endif

#pragma mark - NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)__unused notification {
    BOOL isRunning = NO;
    NSWorkspace *sharedWorkspace = [NSWorkspace sharedWorkspace];

    for (NSRunningApplication *runningApp in sharedWorkspace.runningApplications) {
        if ([runningApp.bundleIdentifier isEqualToString:PHMainBundleIdentifier]) {
            isRunning = YES;
        }
    }

    if (!isRunning) {
        NSLog(@"Info: Launching Phoenix...");

        NSWorkspaceOpenConfiguration *configuration = [NSWorkspaceOpenConfiguration configuration];
        configuration.activates = NO;
        [sharedWorkspace
            openApplicationAtURL:[sharedWorkspace URLForApplicationWithBundleIdentifier:PHMainBundleIdentifier]
                   configuration:configuration
               completionHandler:^(__unused NSRunningApplication *app, NSError *error) {
                   if (error) {
                       NSLog(@"Error: Could not launch Phoenix. (%@)", error);
                   }
               }];
    }
}

@end
