/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface PHStorage : NSObject

#pragma mark - Initialising

+ (instancetype) new NS_UNAVAILABLE;
+ (instancetype) storage;

#pragma mark - Storing

- (void) setObject:(id)object forKey:(NSString *)key;
- (id) objectForKey:(NSString *)key;

@end
