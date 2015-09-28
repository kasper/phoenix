/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

@interface PHHandler : NSObject

#pragma mark - Callback

- (void) manageCallback:(JSValue *)callback;

#pragma mark - Call

- (void) callWithArguments:(NSArray *)arguments;
- (void) call;

@end
