/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "NSProcessInfo+PHExtension.h"

@implementation NSProcessInfo (PHExtension)

#pragma mark - Operating System

+ (BOOL) isOperatingSystemAtLeastElCapitan {

    NSOperatingSystemVersion elCapitan = { .majorVersion = 10, .minorVersion = 11, .patchVersion = 0 };
    return [[self processInfo] isOperatingSystemAtLeastVersion:elCapitan];
}

+ (BOOL) isOperatingSystemAtLeastBigSur {

    NSOperatingSystemVersion bigSur = { .majorVersion = 11, .minorVersion = 0, .patchVersion = 0 };
    return [[self processInfo] isOperatingSystemAtLeastVersion:bigSur];
}

@end
