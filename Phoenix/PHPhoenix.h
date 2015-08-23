/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

@class PHKeyHandler;

@protocol PHPhoenixJSExport <JSExport>

#pragma mark - Actions

+ (void) reload;
JSExportAs(bind, + (PHKeyHandler *) bindKey:(NSString *)key modifiers:(NSArray *)modifiers callback:(JSValue *)callback);
+ (void) log:(NSString *)message;
JSExportAs(alert, + (void) alertWithMessage:(NSString *)message duration:(NSTimeInterval)duration);
+ (void) closeAlerts;
JSExportAs(runCommand, + (BOOL) runCommandInPath:(NSString *)path withArguments:(NSArray *)arguments);

@end

@interface PHPhoenix : NSObject <PHPhoenixJSExport>

@end
