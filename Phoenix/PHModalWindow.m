/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHModalWindow.h"

@implementation PHModalWindow

#pragma mark - Initialising

- (instancetype) initWithContentRect:(NSRect)contentRect
                           styleMask:(NSWindowStyleMask)style
                             backing:(NSBackingStoreType)backingStoreType
                               defer:(BOOL)flag {

    if (self = [super initWithContentRect:contentRect
                                styleMask:style
                                  backing:backingStoreType
                                    defer:flag]) {
        self.alphaValue = 0.0;
        self.animationBehavior = NSWindowAnimationBehaviorAlertPanel;
        self.backgroundColor = [NSColor clearColor];
        self.ignoresMouseEvents = YES;
        self.level = NSFloatingWindowLevel;
        self.opaque = NO;
    }

    return self;
}

#pragma mark - Key Status

- (BOOL) canBecomeKeyWindow {

    return YES;
}

@end
