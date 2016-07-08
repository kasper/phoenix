/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
@import JavaScriptCore;

@class PHApp;
@class PHSpace;
@class PHWindow;

#import "PHAXUIElement.h"
#import "PHIdentifiableJSExport.h"

@protocol PHWindowJSExport <JSExport, PHIdentifiableJSExport>

#pragma mark - Windows

+ (instancetype) focused;
+ (NSArray<PHWindow *> *) windows;
+ (NSArray<PHWindow *> *) visibleWindows;
+ (NSArray<PHWindow *> *) visibleWindowsInOrder;

- (NSArray<PHWindow *> *) otherWindowsOnSameScreen;
- (NSArray<PHWindow *> *) otherWindowsOnAllScreens;

#pragma mark - Exported Properties

- (NSString *) title;
- (BOOL) isMain;
- (BOOL) isNormal;
- (BOOL) isFullScreen;
- (BOOL) isMinimized;
- (BOOL) isVisible;
- (PHApp *) app;
- (NSScreen *) screen;
- (NSArray<PHSpace *> *) spaces;

#pragma mark - Position and Size

- (CGPoint) topLeft;
- (CGSize) size;
- (CGRect) frame;
- (BOOL) setTopLeft:(CGPoint)point;
- (BOOL) setSize:(CGSize)size;
- (BOOL) setFrame:(CGRect)frame;
- (BOOL) setFullScreen:(BOOL)value;
- (BOOL) maximize;
- (BOOL) minimize;
- (BOOL) unminimize;

#pragma mark - Alignment

- (NSArray<PHWindow *> *) windowsToWest;
- (NSArray<PHWindow *> *) windowsToEast;
- (NSArray<PHWindow *> *) windowsToNorth;
- (NSArray<PHWindow *> *) windowsToSouth;

#pragma mark - Focusing

- (BOOL) focus;
- (BOOL) focusClosestWindowInWest;
- (BOOL) focusClosestWindowInEast;
- (BOOL) focusClosestWindowInNorth;
- (BOOL) focusClosestWindowInSouth;

@end

@interface PHWindow : PHAXUIElement <PHWindowJSExport>

#pragma mark - Properties

- (CGWindowID) identifier;

@end
