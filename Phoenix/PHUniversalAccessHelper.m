/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHUniversalAccessHelper.h"

@implementation PHUniversalAccessHelper

#pragma mark - Universal Access

+ (void) askPermissionIfNeeded {

    BOOL universalAccessEnabled = AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef) @{ (__bridge NSString *) kAXTrustedCheckOptionPrompt: @YES });

    if (universalAccessEnabled) {
        return;
    }

    // Ask for permission
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"Enable Accessibility";
    alert.informativeText = @"Find the dialog right behind this one to enable accessibility for Phoenix in System Preferences. Once complete, launch Phoenix again.";
    [alert runModal];

    [NSApp terminate:self];
}

@end
