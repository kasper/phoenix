/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface NSProcessInfo (PHExtension)

#pragma mark - Operating System

+ (BOOL)isOperatingSystemAtLeastBigSur;
+ (BOOL)isOperatingSystemAtLeastMonterey;

@end
