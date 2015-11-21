/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@protocol PHPreprocessor <NSObject>

#pragma mark - Preprocessing

+ (NSString *) process:(NSString *)script atPath:(NSString *)path error:(NSError **)error;

@end
