/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
@import JavaScriptCore;

@class PHSpace;
@class PHWindow;

#import "PHIdentifiableJSExport.h"
#import "PHIterableJSExport.h"

@protocol NSScreenJSExport <JSExport, PHIdentifiableJSExport, PHIterableJSExport>

#pragma mark - Exported Screens

+ (instancetype) mainScreen;
+ (NSArray<NSScreen *> *) screens;

#pragma mark - Properties

- (NSString *) identifier;

#pragma mark - Frame

- (NSRect) frameInRectangle;
- (NSRect) visibleFrameInRectangle;

#pragma mark - Spaces

- (NSArray<PHSpace *> *) spaces;

#pragma mark - Windows

- (NSArray<PHWindow *> *) windows;
- (NSArray<PHWindow *> *) visibleWindows;

@end

@interface NSScreen (PHExtension) <NSScreenJSExport>

#pragma mark - Screens

+ (instancetype) screenForIdentifier:(NSString *)identifier;

@end
