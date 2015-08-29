/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHModalWindowController.h"

@interface PHModalWindowController ()

#pragma mark IBOutlet

@property (weak) IBOutlet NSTextField *textField;

@end

@implementation PHModalWindowController

static NSString * const PHMessageKeyPath = @"message";

#pragma mark - Initialise

- (instancetype) init {

    if (self = [super init]) {
        [self addObserver:self forKeyPath:PHMessageKeyPath options:NSKeyValueObservingOptionNew context:NULL];
    }

    return self;
}

#pragma mark - Dealloc

- (void) dealloc {

    [self removeObserver:self forKeyPath:PHMessageKeyPath];
}

#pragma mark - NSWindowController

- (NSString *) windowNibName {

    return @"ModalWindow";
}

- (void) windowDidLoad {

    self.window.alphaValue = 0.0;
    self.window.animationBehavior = NSWindowAnimationBehaviorAlertPanel;
    self.window.backgroundColor = [NSColor clearColor];
    self.window.ignoresMouseEvents = YES;
    self.window.level = NSFloatingWindowLevel;
    self.window.opaque = NO;
}

#pragma mark - KVO

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)__unused object
                         change:(NSDictionary *)__unused change
                        context:(void *)__unused context {

    // Update text field
    if ([keyPath isEqualToString:PHMessageKeyPath]) {
        [self window];
        self.textField.stringValue = self.message;
    }
}

#pragma mark - Displaying

- (NSRect) frame {

    [self.window layoutIfNeeded];
    return self.window.frame;
}

- (void) fadeWindowToAlpha:(CGFloat)alpha completionHandler:(void (^)())completionHandler {

    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {

        context.duration = 0.2;
        [self.window animator].alphaValue = alpha;

    } completionHandler:completionHandler];
}

- (void) show {

    if (!self.message || isnan(self.origin.x) || isnan(self.origin.y)) {
        return;
    }

    [self showWindow:self];
    [self.window setFrameOrigin:self.origin];
    [self fadeWindowToAlpha:1.0 completionHandler:^{

        // Keep window open until closed
        if (self.duration == 0) {
            return;
        }

        [self performSelector:@selector(close) withObject:nil afterDelay:self.duration];
    }];
}

#pragma mark - Closing

- (void) close {

    [self fadeWindowToAlpha:0.0 completionHandler:^{

        [super close];
    }];
}

@end
