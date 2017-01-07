/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHEventConstants.h"
#import "PHEventTranslator.h"

@implementation PHEventTranslator

#pragma mark - Translating

+ (NSNotificationCenter *) notificationCenterForNotification:(NSString *)notification {

    static NSDictionary<NSString *, NSNotificationCenter *> *notificationToNotificationCenter;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        NSNotificationCenter *workspaceNotificationCenter = [NSWorkspace sharedWorkspace].notificationCenter;

        notificationToNotificationCenter = @{ /* Space Notifications */

                                              NSWorkspaceActiveSpaceDidChangeNotification: workspaceNotificationCenter,

                                              /* App Notifications */

                                              NSWorkspaceDidLaunchApplicationNotification: workspaceNotificationCenter,
                                              NSWorkspaceDidTerminateApplicationNotification: workspaceNotificationCenter,
                                              NSWorkspaceDidActivateApplicationNotification: workspaceNotificationCenter,
                                              NSWorkspaceDidHideApplicationNotification: workspaceNotificationCenter,
                                              NSWorkspaceDidUnhideApplicationNotification: workspaceNotificationCenter };
    });

    NSNotificationCenter *notificationCenter = notificationToNotificationCenter[notification];

    // Specific notification center for notification
    if (notificationCenter) {
        return notificationCenter;
    }

    return [NSNotificationCenter defaultCenter];
}

+ (NSString *) notificationForEvent:(NSString *)event {

    static NSDictionary<NSString *, NSString *> *eventToNotification;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        eventToNotification = @{ /* Event Notifications */

                                 @"didLaunch": PHEventDidLaunchNotification,
                                 @"willTerminate": PHEventWillTerminateNotification,

                                 /* Screen Notifications */

                                 @"screensDidChange": NSApplicationDidChangeScreenParametersNotification,

                                 /* Space Notifications */

                                 @"spaceDidChange": NSWorkspaceActiveSpaceDidChangeNotification,

                                 /* Mouse Notifications */

                                 @"mouseDidMove": PHMouseDidMoveNotification,
                                 @"mouseDidLeftClick": PHMouseDidLeftClickNotification,
                                 @"mouseDidRightClick": PHMouseDidRightClickNotification,
                                 @"mouseDidLeftDrag": PHMouseDidLeftDragNotification,
                                 @"mouseDidRightDrag": PHMouseDidRightDragNotification,

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
                                 @"windowDidMinimise": NSAccessibilityWindowMiniaturizedNotification,
                                 @"windowDidMinimize": NSAccessibilityWindowMiniaturizedNotification,
                                 @"windowDidUnminimise": NSAccessibilityWindowDeminiaturizedNotification,
                                 @"windowDidUnminimize": NSAccessibilityWindowDeminiaturizedNotification };
    });

    return eventToNotification[event];
}

@end
