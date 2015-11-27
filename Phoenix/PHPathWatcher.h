/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface PHPathWatcher : NSObject

#pragma mark - Initialise

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;

- (instancetype) initWithPaths:(NSArray<NSString *> *)paths handler:(void (^)())handler NS_DESIGNATED_INITIALIZER;
+ (instancetype) watcherFor:(NSArray<NSString *> *)paths handler:(void (^)())handler;

@end
