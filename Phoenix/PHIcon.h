/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
@import JavaScriptCore;

#import "PHAXUIElement.h"
#import "PHIdentifiableJSExport.h"

@protocol PHIconJSExport <JSExport, PHIdentifiableJSExport>

#pragma mark - Properties
+ (NSImage *) getFromFile:(NSString *)path;
+ (NSImage *) getFromFile:(NSString *)path withWidth:(int)width;
+ (NSImage *) getFromFile:(NSString *)path withHeight:(int) height;
+ (NSImage *) set:(NSImage*)anImage Width:(int)newWidth AndHeight:(int)newHeight;

@end

@interface PHIcon : PHAXUIElement <PHIconJSExport>

#pragma mark - Initialising

@end
