/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHEventTranslator.h"

@implementation PHEventTranslator

static NSDictionary<NSString *, NSNotificationCenter *> *PHNotificationToNotificationCenter;
static NSDictionary<NSString *, NSString *> *PHStringToNotification;

#pragma mark - Initialise

+ (void) initialize {

    NSNotificationCenter *workspaceNotificationCenter = [[NSWorkspace sharedWorkspace] notificationCenter];

    /* Notification Centers */

    PHNotificationToNotificationCenter = @{ /* App Notifications */

                                            NSWorkspaceDidLaunchApplicationNotification: workspaceNotificationCenter,
                                            NSWorkspaceDidTerminateApplicationNotification: workspaceNotificationCenter,
                                            NSWorkspaceDidActivateApplicationNotification: workspaceNotificationCenter,
                                            NSWorkspaceDidHideApplicationNotification: workspaceNotificationCenter,
                                            NSWorkspaceDidUnhideApplicationNotification: workspaceNotificationCenter };
    /* Notifications */

    PHStringToNotification = @{ /* Screen Notifications */

                                @"screensDidChange": NSApplicationDidChangeScreenParametersNotification,

                                /* App Notifications */

                                @"appDidLaunch": NSWorkspaceDidLaunchApplicationNotification,
                                @"appDidTerminate": NSWorkspaceDidTerminateApplicationNotification,
                                @"appDidActivate": NSWorkspaceDidActivateApplicationNotification,
                                @"appDidHide": NSWorkspaceDidHideApplicationNotification,
                                @"appDidShow": NSWorkspaceDidUnhideApplicationNotification,

                                /* Window Notifications */

                                @"windowDidOpen": NSAccessibilityWindowCreatedNotification,
                                @"windowDidClose": NSAccessibilityUIElementDestroyedNotification,
                                @"windowDidFocus": NSAccessibilityFocusedWindowChangedNotification,
                                @"windowDidMove": NSAccessibilityWindowMovedNotification,
                                @"windowDidResize": NSAccessibilityWindowResizedNotification,
                                @"windowDidMinimize": NSAccessibilityWindowMiniaturizedNotification,
                                @"windowDidUnminimize": NSAccessibilityWindowDeminiaturizedNotification

                              };
}

#pragma mark - Notification Center

+ (NSNotificationCenter *) notificationCenterForNotification:(NSString *)notification {

    NSNotificationCenter *notificationCenter = PHNotificationToNotificationCenter[notification];

    // Specific notification center
    if (notificationCenter) {
        return notificationCenter;
    }

    // Default notification center
    return [NSNotificationCenter defaultCenter];
}

#pragma mark - Translate

+ (NSString *) notificationForString:(NSString *)string {

    return PHStringToNotification[string];
}

@end
