/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

@interface PHAppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate>

#pragma mark - IBAction

- (IBAction) reloadContext:(id)sender;
- (IBAction) showAboutPanel:(id)sender;
- (IBAction) toggleOpenAtLogin:(NSMenuItem *)sender;

@end
