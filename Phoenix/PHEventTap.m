/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHEventTap.h"
#import "PHAXUIElement.h"
#import "PHPopover.h"

static BOOL mouseDown = NO;

@implementation PHEventTap {
    CFMachPortRef   eventTap;
    PHPopover       *popover;
}

static CGEventRef pTapCallback(CGEventTapProxy __unused proxy,
                               CGEventType type,
                               CGEventRef event,
                               void *refcon) {

    if (type == kCGEventLeftMouseUp || type == kCGEventLeftMouseDown) {
        // Return original event if command modifier key is not present
        if (!((CGEventGetFlags(event) & kCGEventFlagMaskCommand) == kCGEventFlagMaskCommand)) {
            return event;
        }

        CGPoint location = CGEventGetLocation(event);
        PHAXUIElement *element = [PHAXUIElement elementAtPosition:location];

        // Check if element at click location have zoom button role
        NSArray *array = [[NSArray alloc] initWithObjects:@"AXZoomButton", @"AXFullScreenButton", nil];
        BOOL isZoom = [array containsObject:[element valueForAttribute:NSAccessibilitySubroleAttribute]];

        if (isZoom && [[element valueForAttribute:NSAccessibilityEnabledAttribute withDefaultValue:@"NO"] boolValue] == YES) {

            if (type == kCGEventLeftMouseDown) {
                mouseDown = YES;
            }

            if (type == kCGEventLeftMouseUp && mouseDown == YES) {
                mouseDown = NO;
                PHEventTap *instance = (__bridge id)refcon;
                [instance showPopoverFor:element];
            }

            // Do not return event so it won't be passed further along call chain
            return NULL;
        }
    }
    return event;
}

+ (instancetype) monitor {
    return [[self alloc] init];
}

- (instancetype) init {

    if (self = [super init]) {
        [self start];
    }
    return self;
}

- (void) start {
    eventTap = CGEventTapCreate(kCGHIDEventTap,
                                kCGHeadInsertEventTap,
                                kCGEventTapOptionDefault,
                                CGEventMaskBit(kCGEventLeftMouseUp) | CGEventMaskBit(kCGEventLeftMouseDown),
                                (CGEventTapCallBack)pTapCallback,
                                (__bridge void *)self);

    CFRunLoopSourceRef runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes);
    CFRelease(runLoopSource);

    CGEventTapEnable(eventTap, true);
    CFRunLoopRun();
}

- (void) dealloc {
    if (eventTap) {
        CFRelease(eventTap);
    }
}

- (void) showPopoverFor:(PHAXUIElement *)element {
    // Close popover if any
    if (popover) {
        [popover close];
    }
    popover = [[PHPopover alloc] initForElement:element];
    [popover show];
}
@end
