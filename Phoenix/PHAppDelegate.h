/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
@import UserNotifications;

@interface PHAppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate>

+ (instancetype)new NS_UNAVAILABLE;

#pragma mark - IBAction

- (IBAction)reloadContext:(id)sender;
- (IBAction)editConfiguration:(id)sender;
- (IBAction)viewDocumentation:(id)sender;
- (IBAction)showAboutPanel:(id)sender;
- (IBAction)toggleOpenAtLogin:(NSMenuItem *)sender;

@end
