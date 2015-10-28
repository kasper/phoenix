/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
@import JavaScriptCore;

#import "PHIdentifiableJSExport.h"
#import "PHWindow.h"

@protocol NSScreenJSExport <JSExport, PHIdentifiableJSExport>

#pragma mark - Screens

+ (NSScreen *) mainScreen;
+ (NSArray<NSScreen *> *) screens;

#pragma mark - Frame

- (NSRect) frameInRectangle;
- (NSRect) visibleFrameInRectangle;

#pragma mark - Screen

- (NSScreen *) next;
- (NSScreen *) previous;

#pragma mark - Windows

- (NSArray<PHWindow *> *) windows;
- (NSArray<PHWindow *> *) visibleWindows;

@end

@interface NSScreen (PHExtension) <NSScreenJSExport>

@end
