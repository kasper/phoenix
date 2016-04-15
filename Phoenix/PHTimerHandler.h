/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

#import "PHHandler.h"
#import "PHIdentifiableJSExport.h"

@protocol PHTimerHandlerJSExport <JSExport, PHIdentifiableJSExport>

#pragma mark Timing

- (void) stop;

@end

@interface PHTimerHandler : PHHandler <PHTimerHandlerJSExport>

#pragma mark - Initialise

- (instancetype) init NS_UNAVAILABLE;

- (instancetype) initWithInterval:(NSTimeInterval)interval
                          repeats:(BOOL)repeats
                         callback:(JSValue *)callback NS_DESIGNATED_INITIALIZER;

+ (instancetype) withInterval:(NSTimeInterval)interval repeats:(BOOL)repeats callback:(JSValue *)callback;

@end
