/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHMouse.h"

@implementation PHMouse

#pragma mark - Mouse Position

+ (NSPoint) location {

    return [NSEvent mouseLocation];
}

+ (BOOL) moveTo:(NSPoint)point {

    CGError error = CGWarpMouseCursorPosition(point);

    if (error != kCGErrorSuccess) {
        NSLog(@"Error: Could not move cursor position to “%@”. (%d)", NSStringFromPoint(point), error);
        return NO;
    }

    return YES;
}

@end
