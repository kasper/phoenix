/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "NSArray+PHExtension.h"
#import "NSScreen+PHExtension.h"
#import "PHSpace.h"
#import "PHWindow.h"

@implementation NSScreen (PHExtension)

static NSString * const NSScreenNumberKey = @"NSScreenNumber";

#pragma mark - Screens

+ (instancetype) screenForIdentifier:(NSString *)identifier {

    for (NSScreen *screen in [self screens]) {

        if ([[screen identifier] isEqualToString:identifier]) {
            return screen;
        }
    }

    return nil;
}

+ (instancetype) main {

    return [self mainScreen];
}

+ (NSArray<NSScreen *> *) all {

    return [self screens];
}

#pragma mark - PHIterableJSExport

- (instancetype) next {

    return [[NSScreen screens] nextFrom:self];
}

- (instancetype) previous {

    return [[NSScreen screens] previousFrom:self];
}

#pragma mark - Properties

- (NSString *) identifier {

    id uuid = CFBridgingRelease(CGDisplayCreateUUIDFromDisplayID([self.deviceDescription[NSScreenNumberKey] unsignedIntValue]));
    return CFBridgingRelease(CFUUIDCreateString(NULL, (__bridge CFUUIDRef) uuid));
}

#pragma mark - Frame

- (CGRect) flipFrame:(NSRect)frame {

    // Use top-left origin
    NSScreen *primaryScreen = [NSScreen screens].firstObject;
    frame.origin.y = primaryScreen.frame.size.height - frame.size.height - frame.origin.y;

    return frame;
}

- (CGRect) flippedFrame {

    return [self flipFrame:self.frame];
}

- (CGRect) flippedVisibleFrame {

    return [self flipFrame:self.visibleFrame];
}

#pragma mark - Spaces

- (PHSpace *) currentSpace {

    return [PHSpace currentSpaceForScreen:self];
}

- (NSArray<PHSpace *> *) spaces {

    NSPredicate *spaceIsOnThisScreen = [NSPredicate predicateWithBlock:
                                        ^BOOL (PHSpace *space, __unused NSDictionary<NSString *, id> *bindings) {

        return [[space screens] containsObject:self];
    }];

    return [[PHSpace all] filteredArrayUsingPredicate:spaceIsOnThisScreen];
}

#pragma mark - Windows

- (NSArray<PHWindow *> *) windows {

    return [PHWindow filteredWindowsUsingPredicateBlock:^BOOL (PHWindow *window,
                                                               __unused NSDictionary<NSString *, id> *bindings) {
        return [[window screen] isEqualTo:self];
    }];
}

- (NSArray<PHWindow *> *) windows:(NSDictionary<NSString *, id> *)optionals {

    NSNumber *visibilityOption = optionals[PHWindowVisibilityOptionKey];

    // Filter based on visibility
    if (visibilityOption) {
        return [[self windows] filteredArrayUsingPredicate:[PHWindow isVisible:visibilityOption.boolValue]];
    }

    return [self windows];
}

@end
