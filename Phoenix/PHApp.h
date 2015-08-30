/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
@import JavaScriptCore;

#import "PHAXUIElement.h"
#import "PHIdentifiableJSExport.h"

@protocol PHAppJSExport <JSExport, PHIdentifiableJSExport>

#pragma mark - Apps

+ (NSArray *) runningApps;
+ (instancetype) launch:(NSString *)appName;

#pragma mark - Properties

- (pid_t) processIdentifier;
- (NSString *) bundleIdentifier;
- (NSString *) name;
- (BOOL) isHidden;

#pragma mark - Windows

- (NSArray *) windows;
- (NSArray *) visibleWindows;

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
