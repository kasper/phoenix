/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface PHPathWatcher : NSObject

#pragma mark - Initialise

+ (PHPathWatcher *) watcherFor:(NSArray<NSString *> *)paths handler:(void (^)())handler;

@end
