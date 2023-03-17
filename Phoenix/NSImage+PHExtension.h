/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
@import JavaScriptCore;

#import "PHIdentifiableJSExport.h"

@protocol NSImageJSExport <JSExport, PHIdentifiableJSExport>

#pragma mark - Constructing

+ (instancetype)fromFile:(NSString *)path;

@end

@interface NSImage (PHExtension) <NSImageJSExport>

#pragma mark - Initialising

+ (instancetype)fromFile:(NSString *)path;

@end
