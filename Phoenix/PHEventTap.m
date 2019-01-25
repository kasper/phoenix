/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHAXUIElement.h"
#import "PHEventTap.h"
#import "PHPopover.h"
#import "PHPreferences.h"

static NSString * const PHEventModifierCommand = @"command";
static NSString * const PHEventModifierCmd = @"cmd";
static NSString * const PHEventModifierOption = @"option";
static NSString * const PHEventModifierAlt = @"alt";
static NSString * const PHEventModifierControl = @"control";
static NSString * const PHEventModifierCtrl = @"ctrl";
static NSString * const PHEventModifierShift = @"shift";

static CFMachPortRef eventTap = NULL;

@implementation PHEventTap {
    PHPopover *popover;
}

static BOOL eventMatchModifier(CGEventRef event) {

    NSString *modifier = [[PHPreferences sharedPreferences] zoomModifier];

    if(modifier == nil) {
        return YES;
    }

    static NSDictionary<NSString *, NSNumber *> *modifierToFlag;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{

        modifierToFlag = @{ PHEventModifierCommand: @(kCGEventFlagMaskCommand),
                            PHEventModifierCmd: @(kCGEventFlagMaskCommand),
                            PHEventModifierOption: @(kCGEventFlagMaskAlternate),
                            PHEventModifierAlt: @(kCGEventFlagMaskAlternate),
                            PHEventModifierControl: @(kCGEventFlagMaskControl),
                            PHEventModifierCtrl: @(kCGEventFlagMaskControl),
                            PHEventModifierShift: @(kCGEventFlagMaskShift) };
    });

    return ((CGEventGetFlags(event) & [modifierToFlag[modifier] unsignedLongLongValue]) == [modifierToFlag[modifier] unsignedLongLongValue]);
}

static CGEventRef pTapCallback(CGEventTapProxy __unused proxy,
                               CGEventType type,
                               CGEventRef event,
                               void *refcon) {

    static BOOL mouseDown = NO;

    if (type == kCGEventTapDisabledByTimeout) {
        CGEventTapEnable(eventTap, true);
        return event;
    }

    // Skip handler if non mouse event received
    if (!(type == kCGEventLeftMouseUp || type == kCGEventLeftMouseDown)) {
        return event;
    }

    // Skip handler if zoom functionality is not enabled in config
    if([[PHPreferences sharedPreferences] zoomEnabled] != YES) {
        return event;
    }

    // Skip handler if key modifier is not matched or inverse modifier is set so default action is available only with it
    if([[PHPreferences sharedPreferences] zoomInverseModifierAction] == eventMatchModifier(event)) {
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
    // Reset popover if it's closed
    if(popover && [popover isClosed]) {
        popover = nil;
    }

    // Close popover if any
    if (popover) {
        if(![popover isForElement:element]) {
            [popover close];
            popover = nil;
        } else {
            // Do nothing since popover would be the same
            return;
        }
    }

    popover = [[PHPopover alloc] initForElement:element];
    [popover show];
}
@end
