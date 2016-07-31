/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHModalWindowController.h"

@interface PHModalWindowController ()

#pragma mark - IBOutlet

@property (weak) IBOutlet NSBox *box;
@property (weak) IBOutlet NSTextField *textField;

@end

@implementation PHModalWindowController

static NSString * const PHModalWindowControllerFontSizeKeyPath = @"fontSize";
static NSString * const PHModalWindowControllerMessageKeyPath = @"message";
static NSString * const PHModalWindowControllerOriginKeyPath = @"origin";

#pragma mark - Initialising

- (instancetype) init {

    if (self = [super init]) {

        self.fontSize = 24.0;

        [self addObserver:self
               forKeyPath:PHModalWindowControllerFontSizeKeyPath
                  options:NSKeyValueObservingOptionNew
                  context:NULL];

        [self addObserver:self
               forKeyPath:PHModalWindowControllerMessageKeyPath
                  options:NSKeyValueObservingOptionNew
                  context:NULL];

        [self addObserver:self
               forKeyPath:PHModalWindowControllerOriginKeyPath
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    }

    return self;
}

#pragma mark - Deallocing

- (void) dealloc {

    [self removeObserver:self forKeyPath:PHModalWindowControllerFontSizeKeyPath];
    [self removeObserver:self forKeyPath:PHModalWindowControllerMessageKeyPath];
    [self removeObserver:self forKeyPath:PHModalWindowControllerOriginKeyPath];
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
    self.box.transparent = self.transparent;
}

#pragma mark - KVO

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)__unused object
                         change:(NSDictionary<NSString *, id> *)__unused change
                        context:(void *)__unused context {

    // Update font size
    if ([keyPath isEqualToString:PHModalWindowControllerFontSizeKeyPath]) {
        self.textField.font = [NSFont systemFontOfSize:self.fontSize];
    }

    // Update text field
    if ([keyPath isEqualToString:PHModalWindowControllerMessageKeyPath]) {
        [self window];
        self.textField.stringValue = self.message;
    }

    // Update origin
    if ([keyPath isEqualToString:PHModalWindowControllerOriginKeyPath]) {
        [self.window setFrameOrigin:self.origin];
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
