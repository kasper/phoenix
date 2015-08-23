/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHApp.h"
#import "PHWindow.h"

@interface PHApp ()

@property NSRunningApplication *app;
@property AXUIElementRef element;

@end

@implementation PHApp

#pragma mark - Initialise

- (instancetype) initWithApp:(NSRunningApplication *)app {

    if (self = [super init]) {
        self.app = app;
        self.element = AXUIElementCreateApplication(app.processIdentifier);
    }

    return self;
}

#pragma mark - Dealloc

- (void) dealloc {

    CFRelease(self.element);
}

#pragma mark - Apps

+ (NSArray *) runningApps {

    NSMutableArray *apps = [NSMutableArray array];
    
    for (NSRunningApplication *runningApp in [NSWorkspace sharedWorkspace].runningApplications) {
        [apps addObject:[[PHApp alloc] initWithApp:runningApp]];
    }
    
    return apps;
}

+ (instancetype) launch:(NSString *)appName {

    NSWorkspace *sharedWorkspace = [NSWorkspace sharedWorkspace];
    NSString *appPath = [sharedWorkspace fullPathForApplication:appName];

    if (!appPath) {
        NSLog(@"Error: Could not find an app with the name %@.", appName);
        return nil;
    }

    NSError *error;
    NSRunningApplication *app = [sharedWorkspace launchApplicationAtURL:[NSURL fileURLWithPath:appPath]
                                                                options:NSWorkspaceLaunchWithoutActivation
                                                          configuration:nil
                                                                  error:&error];
    if (error) {
        NSLog(@"Error: Could not launch app %@. (%@)", appName, error);
        return nil;
    }

    return [[PHApp alloc] initWithApp:app];
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

- (BOOL) isHidden {

    return [self.app isHidden];
}

#pragma mark - Windows

- (NSArray *) windows {

    NSMutableArray *windows = [NSMutableArray array];
    NSArray *windowUIElements = [self getValuesForAttribute:NSAccessibilityWindowsAttribute fromIndex:0 count:100];

    for (id windowUIElement in windowUIElements) {
        [windows addObject:[[PHWindow alloc] initWithElement:(AXUIElementRef) windowUIElement]];
    }

    return windows;
}

- (NSArray *) visibleWindows {

    NSPredicate *visibility = [NSPredicate predicateWithBlock:^BOOL (PHWindow *window,
                                                                     __unused NSDictionary *bindings) {

        return ![[window app] isHidden] && [window isNormal] && ![window isMinimized];
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
