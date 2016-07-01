/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

#import "PHHandler.h"
#import "PHIdentifiableJSExport.h"

@protocol PHTaskHandlerJSExport <JSExport, PHIdentifiableJSExport>

#pragma mark Exported Properties

@property (readonly) int status;
@property (readonly) NSString *output;
@property (readonly) NSString *error;

#pragma mark Constructor

- (instancetype) initWithPath:(NSString *)path arguments:(NSArray<NSString *> *)arguments callback:(JSValue *)callback;

@end

@interface PHTaskHandler : PHHandler <PHTaskHandlerJSExport>

#pragma mark - Initialise

- (instancetype) initWithPath:(NSString *)path
                   arguments:(NSArray<NSString *> *)arguments
                    callback:(JSValue *)callback NS_DESIGNATED_INITIALIZER;

@end
