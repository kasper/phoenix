/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "NSArray+PHExtension.h"
#import "NSScreen+PHExtension.h"
#import "PHOptionConstants.h"
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

    return [NSScreen mainScreen];
}

+ (NSArray<NSScreen *> *) all {

    return [NSScreen screens];
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

- (NSRect) calculateFrame:(NSRect)frame {

    NSScreen *primaryScreen = [NSScreen screens].firstObject;
    frame.origin.y = primaryScreen.frame.size.height - frame.size.height - frame.origin.y;

    return frame;
}

- (NSRect) frameInRectangle {

    return [self calculateFrame:self.frame];
}

- (NSRect) visibleFrameInRectangle {

    return [self calculateFrame:self.visibleFrame];
}

#pragma mark - Spaces

- (NSArray<PHSpace *> *) spaces {

    NSPredicate *spaceOnSameScreen = [NSPredicate predicateWithBlock:
                                      ^BOOL (PHSpace *space, __unused NSDictionary<NSString *, id> *bindings) {

        return [[space screen] isEqualTo:self];
    }];

    return [[PHSpace all] filteredArrayUsingPredicate:spaceOnSameScreen];
}

#pragma mark - Windows

- (NSArray<PHWindow *> *) windows {

    NSPredicate *windowOnSameScreen = [NSPredicate predicateWithBlock:
                                       ^BOOL (PHWindow *window, __unused NSDictionary<NSString *, id> *bindings) {

        return [[window screen] isEqualTo:self];
    }];

    return [[PHWindow windows] filteredArrayUsingPredicate:windowOnSameScreen];
}

- (NSArray<PHWindow *> *) windows:(NSDictionary<NSString *, id> *)optionals {

    NSNumber *visibilityOption = optionals[PHWindowVisibilityOptionKey];
    NSPredicate *visibility = [NSPredicate predicateWithBlock:^BOOL (PHWindow *window,
                                                                     __unused NSDictionary<NSString *, id> *bindings) {

        return visibilityOption.boolValue ? [window isVisible] : ![window isVisible];
    }];

    // Filter based on visibility
    if (visibilityOption) {
        return [[self windows] filteredArrayUsingPredicate:visibility];
    }

    return [self windows];
}

@end
