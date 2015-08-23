/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
@import JavaScriptCore;

@class PHWindow;

#import "PHAXUIElement.h"

@protocol PHWindowJSExport <JSExport>

#pragma mark - Windows

+ (PHWindow *) focusedWindow;
+ (NSArray *) windows;
+ (NSArray *) visibleWindows;
+ (NSArray *) visibleWindowsInOrder;

- (NSArray *) otherWindowsOnSameScreen;
- (NSArray *) otherWindowsOnAllScreens;

#pragma mark - Properties

- (NSString *) title;
- (BOOL) isNormal;
- (BOOL) isMinimized;
- (PHApp *) app;
- (NSScreen *) screen;

#pragma mark - Position and Size

- (CGPoint) topLeft;
- (CGSize) size;
- (CGRect) frame;
- (BOOL) setTopLeft:(CGPoint)point;
- (BOOL) setSize:(CGSize)size;
- (BOOL) setFrame:(CGRect)frame;
- (BOOL) maximize;
- (BOOL) minimize;
- (BOOL) unminimize;

#pragma mark - Alignment

- (NSArray *) windowsToWest;
- (NSArray *) windowsToEast;
- (NSArray *) windowsToNorth;
- (NSArray *) windowsToSouth;

#pragma mark - Focusing

- (BOOL) focus;
- (BOOL) focusClosestWindowInWest;
- (BOOL) focusClosestWindowInEast;
- (BOOL) focusClosestWindowInNorth;
- (BOOL) focusClosestWindowInSouth;

@end

@interface PHWindow : PHAXUIElement <PHWindowJSExport>

#pragma mark - Initialise

- (instancetype) initWithElement:(AXUIElementRef)element NS_DESIGNATED_INITIALIZER;

@end
