/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
#import "PHPopover.h"
#import "PHPreferences.h"
#import "PHWindow.h"
#import "NSScreen+PHExtension.h"

@implementation PHPopover {
    PHWindow *window;
    PHAXUIElement *element;
    NSPopover *popover;
    NSWindow *popoverWindow;
    PHPopover *_self;
}

# pragma mark - Init

- (instancetype) initForElement:(PHAXUIElement *)el {

    if (self = [super init]) {
        element = el;
        // Get window by element
        AXUIElementRef _window;
        _window = (__bridge AXUIElementRef)[element valueForAttribute:NSAccessibilityWindowAttribute];
        @autoreleasepool {
            window = [[PHWindow alloc] initWithElement:CFBridgingRelease(CFRetain(_window))];
        }
    }
    return self;
}

- (BOOL) isForElement:(PHAXUIElement *)el {
    return [element isEqual:el];
}
#pragma mark - Display

- (void) show {

    if ([[PHPreferences sharedPreferences] zoomBringToFront]) {
        [window focus];
        [window raise];
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.12 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self buildPopover];
    });
}

- (void) buildPopover {
    // Get size of the zoom button to position popover
    NSRect displayRegion = [[window screen] flipFrame:[element frame]];

    popoverWindow = [[NSWindow alloc] initWithContentRect:displayRegion
                                                styleMask:NSWindowStyleMaskBorderless
                                                  backing:NSBackingStoreBuffered
                                                    defer:NO];
    popoverWindow.releasedWhenClosed = NO;

    NSView *view = [[NSView alloc] initWithFrame:NSMakeRect(0, 0, 141, 29)];

    NSViewController *controller = [[NSViewController alloc] init];
    controller.view = view;

    popoverWindow.opaque = NO;
    popoverWindow.backgroundColor = [NSColor clearColor];
    popoverWindow.level = NSStatusWindowLevel;
    popoverWindow.accessibilityHidden = YES;
    [popoverWindow makeKeyAndOrderFront:nil];
    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];

    [self buildButtons:view];

    popover = [[NSPopover alloc] init];
    popover.behavior = NSPopoverBehaviorTransient;
    popover.delegate = self;
    [popover setContentSize:view.frame.size];
    [popover setContentViewController:controller];
    [popover setAnimates:NO];

    [popover showRelativeToRect:NSMakeRect(displayRegion.size.width / 2, 0, 1, 1) ofView:popoverWindow.contentView preferredEdge:NSMinYEdge];
}

- (void) buildButtons:(NSView *)view {

    NSButton *bFullscreen = [NSButton buttonWithImage:[NSImage imageNamed:@"fullscreen"] target:self action:@selector(moveWindowFullscreen)];
    bFullscreen.bordered = NO;
    [bFullscreen setFrame:NSMakeRect(5, 5, 23, 18)];

    NSButton *bLeft = [NSButton buttonWithImage:[NSImage imageNamed:@"left"] target:self action:@selector(moveWindowLeft)];
    bLeft.bordered = NO;
    [bLeft setFrame:NSMakeRect(32, 5, 23, 18)];

    NSButton *bRight = [NSButton buttonWithImage:[NSImage imageNamed:@"right"] target:self action:@selector(moveWindowRight)];
    bRight.bordered = NO;
    [bRight setFrame:NSMakeRect(59, 5, 23, 18)];

    NSButton *bTop = [NSButton buttonWithImage:[NSImage imageNamed:@"top"] target:self action:@selector(moveWindowTop)];
    bTop.bordered = NO;
    [bTop setFrame:NSMakeRect(86, 5, 23, 18)];

    NSButton *bBottom = [NSButton buttonWithImage:[NSImage imageNamed:@"bottom"] target:self action:@selector(moveWindowBottom)];
    bBottom.bordered = NO;
    [bBottom setFrame:NSMakeRect(113, 5, 23, 18)];

    [view addSubview:bFullscreen];
    [view addSubview:bLeft];
    [view addSubview:bRight];
    [view addSubview:bTop];
    [view addSubview:bBottom];
}

- (void) popoverDidClose:(NSNotification *)__unused notification {
    popover.delegate = nil;
    popover = nil;
}

- (void) close {
    if (popover) {
        [popover close];
        popover.delegate = nil;
        popover = nil;

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self->popoverWindow close];
            self->popoverWindow = nil;
            self->_self = nil;
        });
    } else {
        [popoverWindow close];
        popoverWindow = nil;
        _self = nil;
    }

    if ([[PHPreferences sharedPreferences] zoomActivateAfterRezie]) {
        [window focus];
    }
}

- (BOOL) isClosed {
    return ![popover isShown];
}

# pragma mark - Window positioning

- (void) moveWindowFullscreen {
    [self close];
    [window maximize];
}

- (void) moveWindowLeft {
    [self close];

    CGRect screenRect = [[window screen] flippedVisibleFrame];
    [window setFrame:NSMakeRect(screenRect.origin.x,
                                screenRect.origin.y,
                                screenRect.size.width / 2,
                                screenRect.size.height)];
}

- (void) moveWindowRight {
    [self close];

    CGRect screenRect = [[window screen] flippedVisibleFrame];
    [window setFrame:NSMakeRect(screenRect.origin.x + screenRect.size.width / 2,
                                screenRect.origin.y,
                                screenRect.size.width / 2,
                                screenRect.size.height)];
}

- (void) moveWindowBottom {
    [self close];

    CGRect screenRect = [[window screen] flippedVisibleFrame];
    [window setFrame:NSMakeRect(screenRect.origin.x,
                                screenRect.origin.y + screenRect.size.height / 2,
                                screenRect.size.width,
                                screenRect.size.height / 2 )];
}

- (void) moveWindowTop {
    [self close];

    CGRect screenRect = [[window screen] flippedVisibleFrame];
    [window setFrame:NSMakeRect(screenRect.origin.x,
                                screenRect.origin.y,
                                screenRect.size.width,
                                screenRect.size.height / 2 )];
}
@end
