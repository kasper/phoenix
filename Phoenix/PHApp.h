/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
@import JavaScriptCore;

@class PHApp;
@class PHWindow;

#import "PHAXUIElement.h"
#import "PHIdentifiableJSExport.h"

@protocol PHAppJSExport <JSExport, PHIdentifiableJSExport>

#pragma mark - Apps

+ (instancetype) launch:(NSString *)appName;
+ (instancetype) focusedApp;
+ (NSArray<PHApp *> *) runningApps;

#pragma mark - Properties

- (pid_t) processIdentifier;
- (NSString *) bundleIdentifier;
- (NSString *) name;
- (BOOL) isActive;
- (BOOL) isHidden;
- (BOOL) isTerminated;

#pragma mark - Windows

- (PHWindow *) mainWindow;
- (NSArray<PHWindow *> *) windows;
- (NSArray<PHWindow *> *) visibleWindows;

#pragma mark - Actions

- (BOOL) activate;
- (BOOL) focus;
- (BOOL) show;
- (BOOL) hide;
- (BOOL) terminate;
- (BOOL) forceTerminate;

@end

@interface PHApp : PHAXUIElement <PHAppJSExport>

#pragma mark - Initialise

- (instancetype) initWithApp:(NSRunningApplication *)app;

@end
