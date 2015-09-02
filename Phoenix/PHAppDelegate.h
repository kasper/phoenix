/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
@import JavaScriptCore;

@class PHKeyHandler;

@interface PHAppDelegate : NSObject <NSApplicationDelegate, NSMenuDelegate>

#pragma mark - Delegate

- (void) reloadContext;
- (PHKeyHandler *) bindKey:(NSString *)key modifiers:(NSArray *)modifiers callback:(JSValue *)callback;

#pragma mark - IBAction

- (IBAction) reloadContext:(id)sender;
- (IBAction) showAboutPanel:(id)sender;
- (IBAction) toggleOpenAtLogin:(NSMenuItem *)sender;

@end
