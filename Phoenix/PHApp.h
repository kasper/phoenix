/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
@import JavaScriptCore;

@class PHApp;
@class PHWindow;

#import "PHAXUIElement.h"
#import "PHIdentifiableJSExport.h"

static NSString * const PHAppFocusOptionKey = @"focus";

@protocol PHAppJSExport <JSExport, PHIdentifiableJSExport>

#pragma mark - Apps

+ (instancetype) get:(NSString *)appName;
JSExportAs(launch, + (instancetype) launch:(NSString *)appName withOptionals:(NSDictionary<NSString *, id> *)optionals);
+ (instancetype) focused;
+ (NSArray<PHApp *> *) all;

#pragma mark - Properties

- (pid_t) processIdentifier;
- (NSString *) bundleIdentifier;
- (NSString *) name;
- (NSImage *) icon;
- (BOOL) isActive;
- (BOOL) isHidden;
- (BOOL) isTerminated;

#pragma mark - Exported Windows

- (PHWindow *) mainWindow;
- (NSArray<PHWindow *> *) windows:(NSDictionary<NSString *, id> *)optionals;

#pragma mark - Actions

- (BOOL) activate;
- (BOOL) focus;
- (BOOL) show;
- (BOOL) hide;
- (BOOL) terminate:(NSDictionary<NSString *, id> *)optionals;

@end

@interface PHApp : PHAXUIElement <PHAppJSExport>

#pragma mark - Initialising

- (instancetype) initWithApp:(NSRunningApplication *)app;

#pragma mark - Windows

- (NSArray<PHWindow *> *) windows;

@end
