/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

static NSInteger const NSTaskErrorCode = -1;
static NSString * const NSTaskErrorDomain = @"NSTaskErrorDomain";

@interface NSTask (PHExtension)

#pragma mark - Environment

+ (NSString *) searchPath;

#pragma mark - Launching

+ (NSString *) outputFromLaunchedTaskWithEnvironment:(NSDictionary<NSString *, NSString *> *)environment
                                           arguments:(NSArray<NSString *> *)arguments
                                               error:(NSError **)error;

@end
