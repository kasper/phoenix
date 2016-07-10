/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "NSScreen+PHExtension.h"
#import "PHApp.h"
#import "PHSpace.h"
#import "PHWindow.h"

@interface PHWindow ()

@property id element;
@property PHApp *app;

@end

@implementation PHWindow

// XXX: Undocumented private attribute for full screen mode
static NSString * const NSAccessibilityFullScreenAttribute = @"AXFullScreen";

static NSString * const PHScreenOptionKey = @"screen";
static NSString * const PHWindowDirectionEast = @"east";
static NSString * const PHWindowDirectionNorth = @"north";
static NSString * const PHWindowDirectionSouth = @"south";
static NSString * const PHWindowDirectionWest = @"west";
static NSString * const PHWindowKey = @"window";
static NSString * const PHWindowScoreKey = @"score";

// XXX: Undocumented private API to get the CGWindowID for an AXUIElementRef
AXError _AXUIElementGetWindow(AXUIElementRef element, CGWindowID *identifier);

#pragma mark - Initialising

- (instancetype) initWithElement:(id)element {

    if (self = [super initWithElement:element]) {
        self.app = [[PHApp alloc] initWithApp:[NSRunningApplication runningApplicationWithProcessIdentifier:[self processIdentifier]]];
    }

    return self;
}

#pragma mark - Predicates

+ (NSPredicate *) isVisible:(BOOL)visible {

    return [NSPredicate predicateWithBlock:^BOOL (PHWindow *window, __unused NSDictionary<NSString *, id> *bindings) {

        return visible ? [window isVisible] : ![window isVisible];
    }];
}

#pragma mark - Windows

+ (instancetype) focused {

    id focusedWindow = [[self elementForSystemAttribute:(NSString *) kAXFocusedApplicationAttribute]
                        valueForAttribute:NSAccessibilityFocusedWindowAttribute];

    if (!focusedWindow) {
        return nil;
    }

    return [[self alloc] initWithElement:focusedWindow];
}

+ (NSArray<PHWindow *> *) windows {

    NSMutableArray<PHWindow *> *windows = [NSMutableArray array];

    for (PHApp *app in [PHApp all]) {
        [windows addObjectsFromArray:[app windows]];
    }

    return windows;
}

+ (NSArray<PHWindow *> *) filteredWindowsUsingPredicateBlock:(BOOL (^)(PHWindow *window, NSDictionary<NSString *, id> *bindings))block {

    return [[self windows] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:block]];
}

+ (NSArray<PHWindow *> *) all:(NSDictionary<NSString *, id> *)optionals {

    NSNumber *visibilityOption = optionals[PHWindowVisibilityOptionKey];

    // Filter based on visibility
    if (visibilityOption) {
        return [[self windows] filteredArrayUsingPredicate:[self isVisible:visibilityOption.boolValue]];
    }

    return [self windows];
}

+ (NSArray<PHWindow *> *) recent {

    NSArray<PHWindow *> *windows = [self windows];
    NSMutableArray<PHWindow *> *orderedWindows = [NSMutableArray array];

    // Windows returned in order from front to back
    NSArray *visibleWindowInfo = CFBridgingRelease(CGWindowListCopyWindowInfo(kCGWindowListOptionOnScreenOnly |
                                                                              kCGWindowListExcludeDesktopElements,
                                                                              kCGNullWindowID));

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

- (NSArray<PHWindow *> *) others:(NSDictionary<NSString *, id> *)optionals {

    NSNumber *visibilityOption = optionals[PHWindowVisibilityOptionKey];
    NSNumber *screenOption = optionals[PHScreenOptionKey];
    NSArray<PHWindow *> *others = [[self class] filteredWindowsUsingPredicateBlock:
                                   ^BOOL (PHWindow *window, __unused NSDictionary<NSString *, id> *bindings) {

        BOOL isOtherWindow = ![self isEqual:window];
        return screenOption ? isOtherWindow && [[self screen] isEqual:screenOption] : isOtherWindow;
    }];

    // Filter based on visibility
    if (visibilityOption) {
        return [others filteredArrayUsingPredicate:[[self class] isVisible:visibilityOption.boolValue]];
    }

    return others;
}

- (NSArray<PHWindow *> *) others {

    return [self others:nil];
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

- (BOOL) isFullScreen {

    return [[self valueForAttribute:NSAccessibilityFullScreenAttribute withDefaultValue:@NO] boolValue];
}

- (BOOL) isMinimized {

    return [[self valueForAttribute:NSAccessibilityMinimizedAttribute withDefaultValue:@NO] boolValue];
}

- (BOOL) isVisible {

    return ![self.app isHidden] && [self isNormal] && ![self isMinimized];
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

- (NSArray<PHSpace *> *) spaces {

    return [PHSpace spacesForWindow:self];
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

    return [self setSize:frame.size] && [self setTopLeft:frame.origin] && [self setSize:frame.size];
}

- (BOOL) setFullScreen:(BOOL)value {

    return [self setAttribute:NSAccessibilityFullScreenAttribute withValue:@(value)];
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
    NSArray<PHWindow *> *otherWindows = [self others];
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

        [closestOtherWindows addObject:@{ PHWindowKey: window, PHWindowScoreKey: @(score) }];
    }

    // Sort other windows based on distance score
    NSArray<PHWindow *> *sortedOtherWindows = [closestOtherWindows sortedArrayUsingComparator:
                                               ^NSComparisonResult(NSDictionary<NSString *, id> *window,
                                                                   NSDictionary<NSString *, id> *otherWindow) {

        return [window[PHWindowScoreKey] compare:otherWindow[PHWindowScoreKey]];
    }];

    return sortedOtherWindows;
}

- (NSArray<PHWindow *> *) neighborsToWest {

    return [[self windowsInDirection:^double (double angle) { return M_PI - fabs(angle); }
                shouldDisregardDelta:^BOOL (double deltaX, __unused double deltaY) { return (deltaX >= 0); }]
            valueForKeyPath:PHWindowKey];
}

- (NSArray<PHWindow *> *) neighborsToEast {

    return [[self windowsInDirection:^double (double angle) { return 0.0 - angle; }
                shouldDisregardDelta:^BOOL (double deltaX, __unused double deltaY) { return (deltaX <= 0); }]
            valueForKeyPath:PHWindowKey];
}

- (NSArray<PHWindow *> *) neighborsToNorth {

    return [[self windowsInDirection:^double (double angle) { return -M_PI_2 - angle; }
                shouldDisregardDelta:^BOOL (__unused double deltaX, double deltaY) { return (deltaY >= 0); }]
            valueForKeyPath:PHWindowKey];
}

- (NSArray<PHWindow *> *) neighborsToSouth {

    return [[self windowsInDirection:^double (double angle) { return M_PI_2 - angle; }
                shouldDisregardDelta:^BOOL (__unused double deltaX, double deltaY) { return (deltaY <= 0); }]
            valueForKeyPath:PHWindowKey];
}

- (NSArray<PHWindow *> *) neighbors:(NSString *)direction {

    NSString *lowercaseDirection = direction.lowercaseString;

    if ([lowercaseDirection isEqualToString:PHWindowDirectionWest]) {
        return [self neighborsToWest];
    } else if ([lowercaseDirection isEqualToString:PHWindowDirectionEast]) {
        return [self neighborsToEast];
    } else if ([lowercaseDirection isEqualToString:PHWindowDirectionNorth]) {
        return [self neighborsToNorth];
    } else if ([lowercaseDirection isEqualToString:PHWindowDirectionSouth]) {
        return [self neighborsToSouth];
    }

    return @[];
}

#pragma mark - Focusing

- (BOOL) focus {

    // Set this window as the main window
    if (![self setAttribute:NSAccessibilityMainAttribute withValue:@YES]) {
        return NO;
    }

    // Focus window’s app
    return [self.app focus];
}

- (BOOL) focusFirstClosestWindow:(NSArray<PHWindow *> *)closestWindows {

    for (PHWindow *window in closestWindows) {
        if ([window focus]) {
            return YES;
        }
    }

    return NO;
}

- (BOOL) focusClosestNeighbor:(NSString *)direction {

    NSString *lowercaseDirection = direction.lowercaseString;

    if ([lowercaseDirection isEqualToString:PHWindowDirectionWest]) {
        return [self focusFirstClosestWindow:[self neighborsToWest]];
    } else if ([lowercaseDirection isEqualToString:PHWindowDirectionEast]) {
        return [self focusFirstClosestWindow:[self neighborsToEast]];
    } else if ([lowercaseDirection isEqualToString:PHWindowDirectionNorth]) {
        return [self focusFirstClosestWindow:[self neighborsToNorth]];
    } else if ([lowercaseDirection isEqualToString:PHWindowDirectionSouth]) {
        return [self focusFirstClosestWindow:[self neighborsToSouth]];;
    }

    return false;
}

@end
