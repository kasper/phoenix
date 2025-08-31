/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHApp.h"
#import "NSProcessInfo+PHExtension.h"
#import "PHWindow.h"

@interface PHApp ()

@property id element;
@property NSRunningApplication *app;

@end

@implementation PHApp

static NSString *const PHAppForceOptionKey = @"force";

#pragma mark - Initialising

- (instancetype)initWithApp:(NSRunningApplication *)app {
    if (self = [super initWithElement:CFBridgingRelease(AXUIElementCreateApplication(app.processIdentifier))]) {
        self.app = app;
    }

    return self;
}

#pragma mark - Apps

+ (NSArray<NSString *> *)primaryAppPaths {
    static NSArray<NSString *> *appPaths;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appPaths = @[
            @"/Applications",
            @"/Applications/Utilities",
            @"/System/Applications",
            @"/System/Applications/Utilities",
            @"/System/Library/CoreServices",
            @"/System/Library/CoreServices/Applications",
            [@"~/Applications" stringByExpandingTildeInPath]
        ];
    });

    return appPaths;
}

+ (NSString *)findPathWithAppName:(NSString *)name {
    NSFileManager *manager = [NSFileManager defaultManager];

    for (NSString *searchPath in [self primaryAppPaths]) {
        NSString *candidatePath =
            [searchPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.app", name]];
        if ([manager fileExistsAtPath:candidatePath]) {
            return candidatePath;
        }
    }

    return nil;
}

+ (instancetype)get:(NSString *)appName {
    for (PHApp *app in [self all]) {
        if ([[app name] isEqualToString:appName]) {
            return app;
        }
    }

    return nil;
}

+ (void)launch:(NSString *)appName
    withOptionals:(NSDictionary<NSString *, id> *)optionals
         callback:(JSValue *)callback {
    NSString *appPath = [self findPathWithAppName:appName];

    if (!appPath) {
        NSLog(@"Error: Could not find an app with the name “%@”.", appName);
        if (!callback.isUndefined) {
            [callback callWithArguments:@[]];
        }
        return;
    }

    NSWorkspace *sharedWorkspace = [NSWorkspace sharedWorkspace];
    NSBundle *appBundle = [NSBundle bundleWithPath:appPath];
    NSURL *appUrl = [sharedWorkspace URLForApplicationWithBundleIdentifier:appBundle.bundleIdentifier];
    NSWorkspaceOpenConfiguration *configuration = [NSWorkspaceOpenConfiguration configuration];
    configuration.activates = NO;

    NSNumber *focusOption = optionals[PHAppFocusOptionKey];

    // Focus on launch
    if (focusOption && focusOption.boolValue) {
        configuration.activates = YES;
    }

    [sharedWorkspace openApplicationAtURL:appUrl
                            configuration:configuration
                        completionHandler:^(__unused NSRunningApplication *app, NSError *error) {
                            if (error) {
                                NSLog(@"Error: Could not launch app “%@”. (%@)", appName, error);
                                if (!callback.isUndefined) {
                                    [callback callWithArguments:@[]];
                                }
                                return;
                            }

                            if (!callback.isUndefined) {
                                [callback callWithArguments:@[[[self alloc] initWithApp:app]]];
                            }
                        }];
}

+ (instancetype)focused {
    return [[self alloc] initWithApp:[NSWorkspace sharedWorkspace].frontmostApplication];
}

+ (NSArray<PHApp *> *)all {
    NSMutableArray<PHApp *> *apps = [NSMutableArray array];

    for (NSRunningApplication *runningApp in [NSWorkspace sharedWorkspace].runningApplications) {
        [apps addObject:[[self alloc] initWithApp:runningApp]];
    }

    return apps;
}

#pragma mark - Properties

- (pid_t)processIdentifier {
    return self.app.processIdentifier;
}

- (NSString *)bundleIdentifier {
    return self.app.bundleIdentifier;
}

- (NSString *)name {
    return self.app.localizedName;
}

- (NSImage *)icon {
    return self.app.icon;
}

- (BOOL)isActive {
    return [self.app isActive];
}

- (BOOL)isHidden {
    return [self.app isHidden];
}

- (BOOL)isTerminated {
    return [self.app isTerminated];
}

#pragma mark - Windows

- (PHWindow *)mainWindow {
    id mainWindow = [self valueForAttribute:NSAccessibilityMainWindowAttribute];

    if (!mainWindow) {
        return nil;
    }

    return [[PHWindow alloc] initWithElement:mainWindow];
}

- (NSArray<PHWindow *> *)windows {
    NSMutableArray<PHWindow *> *windows = [NSMutableArray array];
    NSArray *windowUIElements = [self valuesForAttribute:NSAccessibilityWindowsAttribute fromIndex:0 count:100];

    for (id windowUIElement in windowUIElements) {
        [windows addObject:[[PHWindow alloc] initWithElement:windowUIElement]];
    }

    return windows;
}

- (NSArray<PHWindow *> *)windows:(NSDictionary<NSString *, id> *)optionals {
    NSNumber *visibilityOption = optionals[PHWindowVisibilityOptionKey];

    // Filter based on visibility
    if (visibilityOption) {
        return [[self windows] filteredArrayUsingPredicate:[PHWindow isVisible:visibilityOption.boolValue]];
    }

    return [self windows];
}

#pragma mark - Actions

- (BOOL)activate {
    return [self.app activateWithOptions:NSApplicationActivateAllWindows];
}

- (BOOL)focus {
    // FIX: Workaround for the buggy focus behaviour in Big Sur, see issue #266.
    // For reference see: https://stackoverflow.com/a/65464683/525411
    if ([NSProcessInfo isOperatingSystemAtLeastBigSur]) {
        if (!self.app || [self.app processIdentifier] == -1) {
            return false;
        }

        ProcessSerialNumber process;

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        OSStatus error = GetProcessForPID(self.app.processIdentifier, &process);
#pragma GCC diagnostic pop

        if (error != noErr) {
            return false;
        }

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        error = SetFrontProcessWithOptions(&process, kSetFrontProcessFrontWindowOnly);
#pragma GCC diagnostic pop

        return error == noErr;
    }

    return [self.app activateWithOptions:NSApplicationActivateIgnoringOtherApps];
}

- (BOOL)show {
    return [self.app unhide];
}

- (BOOL)hide {
    return [self.app hide];
}

- (BOOL)terminate:(NSDictionary<NSString *, id> *)optionals {
    NSNumber *forceOption = optionals[PHAppForceOptionKey];

    // Force terminate
    if (forceOption && forceOption.boolValue) {
        return [self.app forceTerminate];
    }

    return [self.app terminate];
}

@end
