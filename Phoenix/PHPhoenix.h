/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

@class PHEventHandler;
@class PHKeyHandler;
@class PHTimerHandler;

#import "PHContext.h"

@protocol PHPhoenixJSExport <JSExport>

#pragma mark - Actions

- (void) reload;

JSExportAs(bind, - (PHKeyHandler *) bindKey:(NSString *)key
                                  modifiers:(NSArray<NSString *> *)modifiers
                                   callback:(JSValue *)callback);

JSExportAs(on, - (PHEventHandler *) bindEvent:(NSString *)event callback:(JSValue *)callback);
JSExportAs(after, - (PHTimerHandler *) after:(NSTimeInterval)interval callback:(JSValue *)callback);
JSExportAs(every, - (PHTimerHandler *) every:(NSTimeInterval)interval callback:(JSValue *)callback);

- (void) set:(NSDictionary<NSString *, id> *)preferences;
- (void) log:(NSString *)message;
- (void) notify:(NSString *)message;

@end

@interface PHPhoenix : NSObject <PHPhoenixJSExport>

#pragma mark - Initialise

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;

- (instancetype) initWithDelegate:(id<PHContextDelegate>)delegate NS_DESIGNATED_INITIALIZER;

@end
