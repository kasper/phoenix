/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "NSProcessInfo+PHExtension.h"

@implementation NSProcessInfo (PHExtension)

#pragma mark - Operating System

+ (BOOL) isOperatingSystemAtLeastHighSierra {

    NSOperatingSystemVersion highSierra = { .majorVersion = 10, .minorVersion = 13, .patchVersion = 0 };
    return [[self processInfo] isOperatingSystemAtLeastVersion:highSierra];
}

+ (BOOL) isOperatingSystemAtLeastBigSur {

    NSOperatingSystemVersion bigSur = { .majorVersion = 11, .minorVersion = 0, .patchVersion = 0 };
    return [[self processInfo] isOperatingSystemAtLeastVersion:bigSur];
}

+ (BOOL) isOperatingSystemAtLeastMonterey {

    NSOperatingSystemVersion monterey = { .majorVersion = 12, .minorVersion = 0, .patchVersion = 0 };
    return [[self processInfo] isOperatingSystemAtLeastVersion:monterey];
}

@end
