/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

static NSString * const NSTaskErrorDomain = @"NSTaskErrorDomain";
static NSInteger const NSTaskErrorCode = -1;

@interface NSTask (PHExtension)

#pragma mark - Environment

+ (NSString *) userPath;

#pragma mark - Launching

+ (NSString *) outputFromLaunchedTaskWithLaunchPath:(NSString *)path
                                        environment:(NSDictionary<NSString *, NSString *> *)environment
                                          arguments:(NSArray<NSString *> *)arguments
                                              error:(NSError **)error;

@end
