/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "NSScreen+PHExtension.h"
#import "PHApp.h"
#import "PHWindow.h"

@interface PHWindow ()

@property id element;
@property PHApp *app;

@end

@implementation PHWindow

// XXX: Undocumented private API to get the CGWindowID for an AXUIElementRef
AXError _AXUIElementGetWindow(AXUIElementRef, CGWindowID *out);

#pragma mark - Initialise

- (instancetype) initWithElement:(id)element {

    if (self = [super initWithElement:element]) {
        self.app = [[PHApp alloc] initWithApp:[NSRunningApplication runningApplicationWithProcessIdentifier:[self processIdentifier]]];
    }

    return self;
}

#pragma mark - Windows

+ (PHWindow *) focusedWindow {

    id focusedWindow = [[PHAXUIElement elementForSystemAttribute:(NSString *) kAXFocusedApplicationAttribute]
                        valueForAttribute:NSAccessibilityFocusedWindowAttribute];

    if (!focusedWindow) {
        return nil;
    }

    return [[PHWindow alloc] initWithElement:focusedWindow];
}

+ (NSArray<PHWindow *> *) windows {

    NSMutableArray<PHWindow *> *windows = [NSMutableArray array];
    
    for (PHApp *app in [PHApp runningApps]) {
        [windows addObjectsFromArray:[app windows]];
    }
    
    return windows;
}

+ (NSArray<PHWindow *> *) visibleWindows {

    NSPredicate *visibility = [NSPredicate predicateWithBlock:^BOOL (PHWindow *window,
                                                                     __unused NSDictionary<NSString *, id> *bindings) {

        return ![window.app isHidden] && [window isNormal] && ![window isMinimized];
    }];

    return [[self windows] filteredArrayUsingPredicate:visibility];
}

+ (NSArray<PHWindow *> *) visibleWindowsInOrder {

    // Windows returned in order from front to back
    NSArray *visibleWindowInfo = CFBridgingRelease(CGWindowListCopyWindowInfo(kCGWindowListOptionOnScreenOnly |
                                                                              kCGWindowListExcludeDesktopElements,
                                                                              kCGNullWindowID));
    NSArray<PHWindow *> *windows = [self windows];
    NSMutableArray<PHWindow *> *orderedWindows = [NSMutableArray array];

    for (NSMutableDictionary<NSString *, id> *windowInfo in visibleWindowInfo) {

        int layer = [windowInfo[(NSString *) kCGWindowLayer] intValue];
        float alpha = [windowInfo[(NSString *) kCGWindowAlpha] floatValue];
        CGWindowID identifier = [windowInfo[(NSString *) kCGWindowNumber] intValue];

        // Window is not visible
        if (layer != 0 || alpha == 0.0) {
            continue;
        }

        // Find window object
        for (PHWindow *window in windows) {

            if ([window identifier] == identifier) {
                [orderedWindows addObject:window];
                break;
            }
        }
    }

    return orderedWindows;
}

- (NSArray<PHWindow *> *) otherWindowsOnSameScreen {

    NSPredicate *otherWindowOnSameScreen = [NSPredicate predicateWithBlock:
                                            ^BOOL (PHWindow *window, __unused NSDictionary<NSString *, id> *bindings) {

        return ![self isEqual:window] && [[self screen] isEqual:[window screen]];
    }];

    return [[PHWindow visibleWindows] filteredArrayUsingPredicate:otherWindowOnSameScreen];
}

- (NSArray<PHWindow *> *) otherWindowsOnAllScreens {

    NSPredicate *otherWindowOnAllScreens = [NSPredicate predicateWithBlock:
                                            ^BOOL (PHWindow *window, __unused NSDictionary<NSString *, id> *bindings) {
        return ![self isEqual:window];
    }];

    return [[PHWindow visibleWindows] filteredArrayUsingPredicate:otherWindowOnAllScreens];
}

#pragma mark - Properties

- (CGWindowID) identifier {

    CGWindowID identifier;
    _AXUIElementGetWindow((__bridge AXUIElementRef) self.element, &identifier);

    return identifier;
}

- (NSString *) subrole {

    return [self valueForAttribute:NSAccessibilitySubroleAttribute withDefaultValue:@""];
}

- (NSString *) title {

    return [self valueForAttribute:NSAccessibilityTitleAttribute withDefaultValue:@""];
}

- (BOOL) isMain {

    return [[self valueForAttribute:NSAccessibilityMainAttribute withDefaultValue:@NO] boolValue];
}

- (BOOL) isNormal {

    return [[self subrole] isEqualToString:NSAccessibilityStandardWindowSubrole];
}

- (BOOL) isMinimized {

    return [[self valueForAttribute:NSAccessibilityMinimizedAttribute withDefaultValue:@NO] boolValue];
}

- (NSScreen *) screen {

    CGRect windowFrame = [self frame];
    CGFloat volume = 0;
    NSScreen *appScreen;

    for (NSScreen *screen in [NSScreen screens]) {

        CGRect screenFrame = [screen frameInRectangle];
        CGRect intersection = CGRectIntersection(windowFrame, screenFrame);
        CGFloat intersectionVolume = intersection.size.width * intersection.size.height;

        // A large part of the window is on this screen
        if (intersectionVolume > volume) {
            volume = intersectionVolume;
            appScreen = screen;
        }
    }

    return appScreen;
}

#pragma mark - Position and Size

- (CGPoint) topLeft {

    CGPoint topLeft;
    CFTypeRef positionWrapper = (__bridge CFTypeRef) [self valueForAttribute:NSAccessibilityPositionAttribute];
    AXValueGetValue(positionWrapper, kAXValueCGPointType, (void *) &topLeft);

    return topLeft;
}

- (CGSize) size {

    CGSize size;
    CFTypeRef sizeWrapper = (__bridge CFTypeRef) [self valueForAttribute:NSAccessibilitySizeAttribute];
    AXValueGetValue(sizeWrapper, kAXValueCGSizeType, (void *) &size);

    return size;
}

- (CGRect) frame {

    CGRect frame;
    frame.origin = [self topLeft];
    frame.size = [self size];

    return frame;
}

- (BOOL) setTopLeft:(CGPoint)point {

    id positionWrapper = CFBridgingRelease(AXValueCreate(kAXValueCGPointType, (void * const) &point));
    return [self setAttribute:NSAccessibilityPositionAttribute withValue:positionWrapper];
}

- (BOOL) setSize:(CGSize)size {

    id sizeWrapper = CFBridgingRelease(AXValueCreate(kAXValueCGSizeType, (void * const) &size));
    return [self setAttribute:NSAccessibilitySizeAttribute withValue:sizeWrapper];
}

- (BOOL) setFrame:(CGRect)frame {

    BOOL topLeftSet = [self setTopLeft:frame.origin];
    BOOL sizeSet = [self setSize:frame.size];

    return topLeftSet && sizeSet;
}

- (BOOL) maximize {

    CGRect screenRect = [[self screen] visibleFrameInRectangle];
    return [self setFrame:screenRect];
}

- (BOOL) minimize {

    return [self setAttribute:NSAccessibilityMinimizedAttribute withValue:@YES];
}

- (BOOL) unminimize {

    return [self setAttribute:NSAccessibilityMinimizedAttribute withValue:@NO];
}

#pragma mark - Alignment

- (NSArray<PHWindow *> *) windowsInDirection:(double (^)(double angle))direction
                        shouldDisregardDelta:(BOOL (^)(double deltaX, double deltaY))shouldDisregard {

    CGRect frame = [self frame];
    NSPoint centrePoint = NSMakePoint(NSMidX(frame), NSMidY(frame));

    // Other windows
    NSArray<PHWindow *> *otherWindows = [self otherWindowsOnAllScreens];
    NSMutableArray *closestOtherWindows = [NSMutableArray arrayWithCapacity:otherWindows.count];
    
    for (PHWindow *window in otherWindows) {

        CGRect otherFrame = [window frame];
        NSPoint otherPoint = NSMakePoint(NSMidX(otherFrame), NSMidY(otherFrame));
        
        double deltaX = otherPoint.x - centrePoint.x;
        double deltaY = otherPoint.y - centrePoint.y;

        // Can disregard
        if (shouldDisregard(deltaX, deltaY)) {
            continue;
        }

        // Distance
        double angle = atan2(deltaY, deltaX);
        double distance = hypot(deltaX, deltaY);
        double angleDifference = direction(angle);
        double score = distance / cos(angleDifference / 2.0);

        [closestOtherWindows addObject:@{ @"window": window, @"score": @(score) }];
    }

    // Sort other windows based on distance score
    NSArray<PHWindow *> *sortedOtherWindows = [closestOtherWindows sortedArrayUsingComparator:
                                               ^NSComparisonResult(NSDictionary<NSString *, id> *window,
                                                                   NSDictionary<NSString *, id> *otherWindow) {
        return [window[@"score"] compare:otherWindow[@"score"]];
    }];
    
    return sortedOtherWindows;
}

- (NSArray<PHWindow *> *) windowsToWest {

    return [[self windowsInDirection:^double (double angle) { return M_PI - fabs(angle); }
                shouldDisregardDelta:^BOOL (double deltaX, __unused double deltaY) { return (deltaX >= 0); }]
            valueForKeyPath:@"window"];
}

- (NSArray<PHWindow *> *) windowsToEast {

    return [[self windowsInDirection:^double (double angle) { return 0.0 - angle; }
                shouldDisregardDelta:^BOOL (double deltaX, __unused double deltaY) { return (deltaX <= 0); }]
            valueForKeyPath:@"window"];
}

- (NSArray<PHWindow *> *) windowsToNorth {

    return [[self windowsInDirection:^double (double angle) { return -M_PI_2 - angle; }
                shouldDisregardDelta:^BOOL (__unused double deltaX, double deltaY) { return (deltaY >= 0); }]
            valueForKeyPath:@"window"];
}

- (NSArray<PHWindow *> *) windowsToSouth {

    return [[self windowsInDirection:^double (double angle) { return M_PI_2 - angle; }
                shouldDisregardDelta:^BOOL (__unused double deltaX, double deltaY) { return (deltaY <= 0); }]
            valueForKeyPath:@"window"];
}

#pragma mark - Focusing

- (BOOL) focus {

    // Set this window as the main window
    if (![self setAttribute:NSAccessibilityMainAttribute withValue:@YES]) {
        return NO;
    }

    // Focus app
    return [self.app focus];
}

- (BOOL) focusFirstClosestWindowIn:(NSArray<PHWindow *> *)closestWindows {

    for (PHWindow *window in closestWindows) {
        if ([window focus]) {
            return YES;
        }
    }

    return NO;
}

- (BOOL) focusClosestWindowInWest {

    return [self focusFirstClosestWindowIn:[self windowsToWest]];
}

- (BOOL) focusClosestWindowInEast {

    return [self focusFirstClosestWindowIn:[self windowsToEast]];
}

- (BOOL) focusClosestWindowInNorth {

    return [self focusFirstClosestWindowIn:[self windowsToNorth]];
}

- (BOOL) focusClosestWindowInSouth {

    return [self focusFirstClosestWindowIn:[self windowsToSouth]];
}

@end
