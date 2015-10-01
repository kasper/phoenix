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

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;

- (instancetype) initWithEvent:(NSString *)event NS_DESIGNATED_INITIALIZER;

@end
