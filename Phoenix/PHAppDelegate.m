/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHAppDelegate.h"
#import "PHContext.h"
#import "PHEventConstants.h"
#import "PHOpenAtLoginHelper.h"
#import "PHPreferences.h"
#import "PHUniversalAccessHelper.h"

@interface PHAppDelegate ()

@property BOOL hasAccessibilityPermission;
@property PHContext *context;
@property NSStatusItem *statusItem;

#pragma mark - IBOutlet

@property(weak) IBOutlet NSMenu *statusItemMenu;

@end

@implementation PHAppDelegate

static NSString *const PHDocumentationURL = @"https://kasper.github.io/phoenix/";

#pragma mark - Initialising

- (void)toggleStatusItem:(BOOL)enabled {
    // Status item is already up-to-date
    if ((self.statusItem && enabled) || (!self.statusItem && !enabled)) {
        return;
    }

    // Remove status item
    if (!enabled) {
        [[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
        self.statusItem = nil;
        return;
    }

    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.button.image = [NSImage imageNamed:@"StatusItemIcon"];
    self.statusItem.menu = self.statusItemMenu;
}

#pragma mark - NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)__unused notification {
    self.hasAccessibilityPermission = [PHUniversalAccessHelper askPermissionIfNeeded];

    // Observe accessibility permission
    [NSTimer scheduledTimerWithTimeInterval:30
                                     target:self
                                   selector:@selector(observeAccessibilityPermission)
                                   userInfo:nil
                                    repeats:YES];

    // Observe changes in preferences
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferencesDidChange:)
                                                 name:PHPreferencesDidChangeNotification
                                               object:nil];
    self.context = [PHContext context];
    [self.context load];

    [[NSNotificationCenter defaultCenter] postNotificationName:PHEventDidLaunchNotification object:nil];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:PHEventWillTerminateNotification object:nil];

    [self.context shouldTerminate:^{
        [application replyToApplicationShouldTerminate:YES];
    }];

    return self.context ? NSTerminateLater : NSTerminateNow;
}

#pragma mark - NSMenuDelegate

- (void)menuNeedsUpdate:(NSMenu *)menu {
    [menu itemWithTitle:@"Open at Login"].state =
        [PHOpenAtLoginHelper opensAtLogin] ? NSControlStateValueOn : NSControlStateValueOff;
}

#pragma mark - Event Handling

- (void)observeAccessibilityPermission {
    BOOL hasPermission = [PHUniversalAccessHelper hasPermission];

    if (!hasPermission) {
        NSLog(
            @"Info: No “Accessibility” permission. Please enable “Accessibility” for Phoenix in “System Preferences”.");
    }

    // Reload context when permission is granted
    if (!self.hasAccessibilityPermission && hasPermission) {
        [self.context load];
    }

    self.hasAccessibilityPermission = hasPermission;
}

- (void)preferencesDidChange:(NSNotification *)__unused notification {
    [self toggleStatusItem:![[PHPreferences sharedPreferences] isDaemon]];
    [PHOpenAtLoginHelper setOpensAtLogin:[[PHPreferences sharedPreferences] openAtLogin]];
}

#pragma mark - IBAction

- (IBAction)reloadContext:(id)__unused sender {
    [self.context load];
}

- (IBAction)editConfiguration:(id)__unused sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL fileURLWithPath:self.context.primaryConfigurationPath]];
}

- (IBAction)viewDocumentation:(id)__unused sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:PHDocumentationURL]];
}

- (IBAction)showAboutPanel:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];
    [NSApp orderFrontStandardAboutPanel:sender];
}

- (IBAction)toggleOpenAtLogin:(NSMenuItem *)sender {
    BOOL openAtLogin = sender.state == NSControlStateValueOff;
    [[PHPreferences sharedPreferences] add:@{PHPreferencesOpenAtLoginKey: @(openAtLogin)}];
}

@end
