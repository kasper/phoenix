/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

@protocol PHMouseJSExport <JSExport>

#pragma mark - Mouse Position

+ (NSPoint) location;
+ (BOOL) moveTo:(NSPoint)point;

@end

@interface PHMouse : NSObject <PHMouseJSExport>

- (instancetype) init NS_UNAVAILABLE;

@end
