/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

@interface PHHandler : NSObject

+ (instancetype) new NS_UNAVAILABLE;

#pragma mark - Callback

- (void) manageCallback:(JSValue *)callback;

#pragma mark - Call

- (void) callWithArguments:(NSArray *)arguments;

@end
