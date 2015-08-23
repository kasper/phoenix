/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "NSScreen+PHExtension.h"

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

    NSArray *screens = [NSScreen screens];
    NSUInteger nextIndex = [screens indexOfObject:self] + 1;

    // Last screen, return first
    if (nextIndex == screens.count) {
        return screens.firstObject;
    }
    
    return screens[nextIndex];
}

- (NSScreen *) previous {

    NSArray *screens = [NSScreen screens];
    NSInteger previousIndex = [screens indexOfObject:self] - 1;
    
    // First screen, return last
    if (previousIndex == -1) {
        return screens.lastObject;
    }
    
    return screens[previousIndex];
}

@end
