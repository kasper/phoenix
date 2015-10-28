/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
@import JavaScriptCore;

#import "PHIdentifiableJSExport.h"

@protocol NSScreenJSExport <JSExport, PHIdentifiableJSExport>

#pragma mark - Screens

+ (NSScreen *) mainScreen;
+ (NSArray<NSScreen *> *) screens;

#pragma mark - Frame

- (NSRect) visibleFrame;
- (NSRect) frameInRectangle;
- (NSRect) visibleFrameInRectangle;

#pragma mark - Screen

- (NSScreen *) next;
- (NSScreen *) previous;

@end

@interface NSScreen (PHExtension) <NSScreenJSExport>

@end
