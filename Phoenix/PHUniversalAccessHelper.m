/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHUniversalAccessHelper.h"

@implementation PHUniversalAccessHelper

#pragma mark - Universal Access

+ (BOOL)hasPermission {
    return AXIsProcessTrusted();
}

+ (BOOL)askPermissionIfNeeded {
    return AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef)
                                             @{(__bridge NSString *)kAXTrustedCheckOptionPrompt: @YES});
}

@end
