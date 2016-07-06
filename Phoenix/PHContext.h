/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@protocol PHContextDelegate <NSObject>

#pragma mark - Loading

- (void) load;

#pragma mark - Storing

- (void) storeObject:(id)object forKey:(NSString *)key;
- (id) objectInStorageForKey:(NSString *)key;

@end

@interface PHContext : NSObject <PHContextDelegate>

#pragma mark - Initialising

+ (instancetype) new NS_UNAVAILABLE;
+ (instancetype) context;

@end
