/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
@import JavaScriptCore;

@protocol PHModalWindowControllerJSExport <JSExport>

#pragma mark Exported Properties

@property NSPoint origin;
@property NSTimeInterval duration;
@property NSString *message;

#pragma mark - Initialise

- (instancetype) init;

#pragma mark - Displaying

- (NSRect) frame;
- (void) show;

#pragma mark - Closing

- (void) close;

@end

@interface PHModalWindowController : NSWindowController <PHModalWindowControllerJSExport>

#pragma mark Properties

@property NSPoint origin;
@property NSTimeInterval duration;
@property NSString *message;

@end
