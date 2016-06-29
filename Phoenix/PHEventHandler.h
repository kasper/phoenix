/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

#import "PHHandler.h"
#import "PHIdentifiableJSExport.h"

@protocol PHEventHandlerJSExport <JSExport, PHIdentifiableJSExport>

#pragma mark Exported Properties

@property (readonly) NSString *name;

@end

@interface PHEventHandler : PHHandler <PHEventHandlerJSExport>

#pragma mark - Initialise

- (instancetype) initWithEvent:(NSString *)event callback:(JSValue *)callback NS_DESIGNATED_INITIALIZER;
+ (instancetype) withEvent:(NSString *)event callback:(JSValue *)callback;

@end
