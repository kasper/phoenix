/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

@interface PHHandler : NSObject

#pragma mark - Callback

- (void) setCallback:(JSValue *)callback forContext:(JSContext *)context;

#pragma mark - Call

- (void) call;

@end
