/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHApp.h"
#import "PHWindow.h"

@interface PHApp ()

@property id element;
@property NSRunningApplication *app;

@end

@implementation PHApp

#pragma mark - Initialising

- (instancetype) initWithApp:(NSRunningApplication *)app {

    if (self = [super initWithElement:CFBridgingRelease(AXUIElementCreateApplication(app.processIdentifier))]) {
        self.app = app;
    }

    return self;
}

#pragma mark - Apps

+ (instancetype) get:(NSString *)appName {

    for (PHApp *app in [self runningApps]) {

        if ([[app name] isEqualToString:appName]) {
            return app;
        }
    }

    return nil;
}

+ (instancetype) launch:(NSString *)appName {

    NSWorkspace *sharedWorkspace = [NSWorkspace sharedWorkspace];
    NSString *appPath = [sharedWorkspace fullPathForApplication:appName];

    if (!appPath) {
        NSLog(@"Error: Could not find an app with the name “%@”.", appName);
        return nil;
    }

    NSError *error;
    NSRunningApplication *app = [sharedWorkspace launchApplicationAtURL:[NSURL fileURLWithPath:appPath]
                                                                options:NSWorkspaceLaunchWithoutActivation
                                                          configuration:@{}
                                                                  error:&error];
    if (error) {
        NSLog(@"Error: Could not launch app “%@”. (%@)", appName, error);
        return nil;
    }

    return [[self alloc] initWithApp:app];
}

+ (instancetype) focusedApp {

    return [[self alloc] initWithApp:[NSWorkspace sharedWorkspace].frontmostApplication];
}

+ (NSArray<PHApp *> *) runningApps {

    NSMutableArray<PHApp *> *apps = [NSMutableArray array];

    for (NSRunningApplication *runningApp in [NSWorkspace sharedWorkspace].runningApplications) {
        [apps addObject:[[self alloc] initWithApp:runningApp]];
    }

    return apps;
}

#pragma mark - Properties

- (pid_t) processIdentifier {

    return self.app.processIdentifier;
}

- (NSString *) bundleIdentifier {

    return self.app.bundleIdentifier;
}

- (NSString *) name {

    return self.app.localizedName;
}

- (BOOL) isActive {

    return [self.app isActive];
}

- (BOOL) isHidden {

    return [self.app isHidden];
}

- (BOOL) isTerminated {

    return [self.app isTerminated];
}

#pragma mark - Windows

- (PHWindow *) mainWindow {

    return [[PHWindow alloc] initWithElement:[self valueForAttribute:NSAccessibilityMainWindowAttribute]];
}

- (NSArray<PHWindow *> *) windows {

    NSMutableArray<PHWindow *> *windows = [NSMutableArray array];
    NSArray *windowUIElements = [self valuesForAttribute:NSAccessibilityWindowsAttribute fromIndex:0 count:100];

    for (id windowUIElement in windowUIElements) {
        [windows addObject:[[PHWindow alloc] initWithElement:windowUIElement]];
    }

    return windows;
}

- (NSArray<PHWindow *> *) visibleWindows {

    NSPredicate *visibility = [NSPredicate predicateWithBlock:^BOOL (PHWindow *window,
                                                                     __unused NSDictionary<NSString *, id> *bindings) {
        return [window isVisible];
    }];

    return [[self windows] filteredArrayUsingPredicate:visibility];
}

#pragma mark - Actions

- (BOOL) activate {

    return [self.app activateWithOptions:NSApplicationActivateAllWindows];
}

- (BOOL) focus {

    return [self.app activateWithOptions:NSApplicationActivateIgnoringOtherApps];
}

- (BOOL) show {

    return [self.app unhide];
}

- (BOOL) hide {

    return [self.app hide];
}

- (BOOL) terminate {

    return [self.app terminate];
}

- (BOOL) forceTerminate {

    return [self.app forceTerminate];
}

@end
