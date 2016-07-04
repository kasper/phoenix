/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

@interface PHHandler : NSObject

#pragma mark - Initialising

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;

- (instancetype) initWithCallback:(JSValue *)callback;

#pragma mark - Calling

- (void) callWithArguments:(NSArray *)arguments;

@end
