/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "NSScreen+PHExtension.h"

#import "PHApp.h"

@implementation NSScreen (PHExtension)

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

#pragma mark - Screen

- (NSScreen *) next {

    NSArray<NSScreen *> *screens = [NSScreen screens];
    NSUInteger nextIndex = [screens indexOfObject:self] + 1;

    // Last screen, return first
    if (nextIndex == screens.count) {
        return screens.firstObject;
    }
    
    return screens[nextIndex];
}

- (NSScreen *) previous {

    NSArray<NSScreen *> *screens = [NSScreen screens];
    NSInteger previousIndex = [screens indexOfObject:self] - 1;
    
    // First screen, return last
    if (previousIndex == -1) {
        return screens.lastObject;
    }
    
    return screens[previousIndex];
}

#pragma mark - Windows

- (NSArray<PHWindow *> *) windows {

    NSMutableArray<PHWindow *> *windows = [NSMutableArray array];

    for (PHApp *app in [PHApp runningApps]) {
        [windows addObjectsFromArray:[app windows]];
    }

    NSPredicate *onScreen = [NSPredicate predicateWithBlock:^BOOL (PHWindow *window,
                                                                   __unused NSDictionary<NSString *, id> *bindings) {

        return [window.screen isEqualTo:self];
    }];

    return [windows filteredArrayUsingPredicate:onScreen];
}

- (NSArray<PHWindow *> *) visibleWindows {

    NSArray<PHWindow *> *windows = [self windows];

    NSPredicate *visibility = [NSPredicate predicateWithBlock:^BOOL (PHWindow *window,
                                                                     __unused NSDictionary<NSString *, id> *bindings) {

        return [window isVisible];
    }];

    return [windows filteredArrayUsingPredicate:visibility];
}

@end
