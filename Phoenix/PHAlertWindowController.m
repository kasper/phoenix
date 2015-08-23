/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHAlerts.h"
#import "PHAlertWindowController.h"

@interface PHAlertWindowController ()

@property (weak) id<PHAlertDelegate> delegate;

#pragma mark IBOutlet

@property (weak) IBOutlet NSTextField *textField;

@end

@implementation PHAlertWindowController

#pragma mark - Initialise

- (instancetype) initWithDelegate:(id<PHAlertDelegate>)delegate {

    if (self = [super init]) {
        self.delegate = delegate;
    }

    return self;
}

#pragma mark - NSWindowController

- (NSString *) windowNibName {

    return @"AlertWindow";
}

- (void) windowDidLoad {

    self.window.alphaValue = 0.0;
    self.window.animationBehavior = NSWindowAnimationBehaviorAlertPanel;
    self.window.backgroundColor = [NSColor clearColor];
    self.window.ignoresMouseEvents = YES;
    self.window.level = NSFloatingWindowLevel;
    self.window.opaque = NO;
}

#pragma mark - Positioning

- (void) setFrameWithAdjustment:(CGFloat)pushDownBy {

    [self.window layoutIfNeeded];

    CGRect frame = self.window.frame;
    frame.origin.x = ([NSScreen mainScreen].frame.size.width / 2.0) - (frame.size.width / 2.0);
    frame.origin.y = pushDownBy - frame.size.height;

    [self.window setFrame:frame display:NO];
}

#pragma mark - Displaying

- (void) fadeWindowToAlpha:(CGFloat)alpha completionHandler:(void (^)())completionHandler {

    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {

        context.duration = 0.2;
        [self.window animator].alphaValue = alpha;

    } completionHandler:completionHandler];
}

- (void) show:(NSString *)message duration:(NSTimeInterval)duration pushDownBy:(CGFloat)adjustment {

    [self showWindow:self];

    self.textField.stringValue = message;

    [self setFrameWithAdjustment:adjustment];
    [self fadeWindowToAlpha:1.0 completionHandler:^{

        [self performSelector:@selector(fadeWindowOut) withObject:nil afterDelay:duration];
    }];
}

#pragma mark - Closing

- (void) close {

    [self.window orderOut:self];
    [self.delegate alertDidClose:self];
}

- (void) fadeWindowOut {

    [self fadeWindowToAlpha:0.0 completionHandler:^{

        [self close];
    }];
}

@end
