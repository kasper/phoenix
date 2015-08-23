/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
@import JavaScriptCore;

@protocol NSScreenJSExport <JSExport>

#pragma mark - Frame

- (NSRect) frameInRectangle;
- (NSRect) visibleFrameInRectangle;

#pragma mark - Screen

- (NSScreen *) next;
- (NSScreen *) previous;

@end

@interface NSScreen (PHExtension) <NSScreenJSExport>

@end
