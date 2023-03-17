/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

#import "PHHandler.h"
#import "PHIdentifiableJSExport.h"

@protocol PHEventHandlerJSExport <JSExport, PHIdentifiableJSExport>

@property(readonly) NSString *name;

#pragma mark - Constructing

- (instancetype)initWithEvent:(NSString *)event callback:(JSValue *)callback;

#pragma mark - Binding

- (void)disable;

@end

@interface PHEventHandler : PHHandler <PHEventHandlerJSExport>

#pragma mark - Initialising

- (instancetype)initWithEvent:(NSString *)event callback:(JSValue *)callback NS_DESIGNATED_INITIALIZER;

@end
