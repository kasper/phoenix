/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
@import JavaScriptCore;

#import "PHIdentifiableJSExport.h"

@protocol PHModalWindowControllerJSExport <JSExport, PHIdentifiableJSExport>

#pragma mark - Exported Properties

@property NSPoint origin;
@property NSTimeInterval duration;
@property NSTimeInterval animationDuration;
@property CGFloat weight;
@property (copy) NSString *appearance;
@property BOOL hasShadow;
@property NSImage *icon;
@property (copy) NSString *text;
@property (copy) NSString *font;
@property BOOL isInput;
@property (copy) NSString *inputPlaceholder;
@property JSValue *textDidChange;

// TODO: Deprecated and will be removed in later versions, use “text” instead
@property (copy) NSString *message;

#pragma mark - Constructing

- (instancetype) init;

#pragma mark - Appearance

JSExportAs(setTextColor, - (void) setTextColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha);

#pragma mark - Displaying

- (NSRect) frame;
- (void) show;
- (void) close;

@end

@interface PHModalWindowController : NSWindowController <PHModalWindowControllerJSExport>

+ (instancetype) new NS_UNAVAILABLE;

#pragma mark - Properties

@property NSPoint origin;
@property NSTimeInterval duration;
@property NSTimeInterval animationDuration;
@property CGFloat weight;
@property (copy) NSString *appearance;
@property BOOL hasShadow;
@property NSImage *icon;
@property (copy) NSString *text;
@property (copy) NSString *font;
@property BOOL isInput;
@property (copy) NSString *inputPlaceholder;
@property JSValue *textDidChange;

// TODO: Deprecated and will be removed in later versions, use “text” instead
@property (copy) NSString *message;

@end
