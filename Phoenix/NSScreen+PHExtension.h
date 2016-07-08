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

+ (instancetype) main;
+ (NSArray<NSScreen *> *) all;

#pragma mark - Properties

- (NSString *) identifier;

#pragma mark - Frame

- (NSRect) frameInRectangle;
- (NSRect) visibleFrameInRectangle;

#pragma mark - Spaces

- (NSArray<PHSpace *> *) spaces;

#pragma mark - Windows

- (NSArray<PHWindow *> *) windows:(NSDictionary<NSString *, id> *)optionals;

@end

@interface NSScreen (PHExtension) <NSScreenJSExport>

#pragma mark - Screens

+ (instancetype) screenForIdentifier:(NSString *)identifier;

@end
