/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHLauncherAppDelegate.h"

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        PHLauncherAppDelegate *delegate = [[PHLauncherAppDelegate alloc] init];
        [NSApplication sharedApplication].delegate = delegate;
        return NSApplicationMain(argc, argv);
    }
}
