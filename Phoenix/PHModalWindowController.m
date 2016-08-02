/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHModalWindowController.h"

@interface PHModalWindowController ()

#pragma mark - IBOutlet

@property (weak) IBOutlet NSVisualEffectView *visualEffectView;
@property (weak) IBOutlet NSView *containerView;
@property (weak) IBOutlet NSTextField *textField;

@end

@implementation PHModalWindowController

static NSString * const PHModalWindowControllerAppearanceDark = @"dark";
static NSString * const PHModalWindowControllerAppearanceTransparent = @"transparent";
static NSString * const PHModalWindowControllerMessageKeyPath = @"message";
static NSString * const PHModalWindowControllerOriginKeyPath = @"origin";
static NSString * const PHModalWindowControllerWeightKeyPath = @"weight";

#pragma mark - Initialising

- (instancetype) init {

    if (self = [super init]) {

        self.weight = 24.0;
        self.appearance = PHModalWindowControllerAppearanceDark;

        [self addObserver:self
               forKeyPath:PHModalWindowControllerMessageKeyPath
                  options:NSKeyValueObservingOptionNew
                  context:NULL];

        [self addObserver:self
               forKeyPath:PHModalWindowControllerOriginKeyPath
                  options:NSKeyValueObservingOptionNew
                  context:NULL];

        [self addObserver:self
               forKeyPath:PHModalWindowControllerWeightKeyPath
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
    }

    return self;
}

#pragma mark - Deallocing

- (void) dealloc {

    [self removeObserver:self forKeyPath:PHModalWindowControllerMessageKeyPath];
    [self removeObserver:self forKeyPath:PHModalWindowControllerOriginKeyPath];
    [self removeObserver:self forKeyPath:PHModalWindowControllerWeightKeyPath];
}

#pragma mark - Appearance

- (void) setupVibrantAppearance {

    self.visualEffectView.material = NSVisualEffectMaterialDark;
    self.visualEffectView.state = NSVisualEffectStateActive;

    CGFloat cornerRadius = 10.0;
    CGFloat edgeSize = 1.0 + (2 * cornerRadius);
    NSSize maskSize = NSMakeSize(edgeSize, edgeSize);

    // Create mask image for rounded rectangle
    NSImage *mask = [NSImage imageWithSize:maskSize flipped:NO drawingHandler:^BOOL (NSRect destination) {

        [[NSBezierPath bezierPathWithRoundedRect:destination xRadius:cornerRadius yRadius:cornerRadius] fill];
        return YES;
    }];

    // Make edges smooth
    mask.capInsets = NSEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius);

    self.visualEffectView.maskImage = mask;
}

- (void) setupTransparentAppearance {

    NSDictionary<NSString *, id> *views = @{ @"container": self.containerView };
    NSView *transparentView = [[NSView alloc] initWithFrame:self.window.contentView.frame];
    [transparentView addSubview:self.containerView];

    // Hug left edge of container
    [transparentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[container]"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:views]];
    // Hug right edge of container
    [transparentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[container]-(0)-|"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:views]];
    // Hug top edge of container
    [transparentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[container]"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:views]];
    // Hug bottom edge of container
    [transparentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[container]-(0)-|"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:views]];
    // Set transparent view as content view
    self.window.contentView = transparentView;
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
                         change:(NSDictionary<NSString *, id> *)__unused change
                        context:(void *)__unused context {

    [self window];

    // Update text field
    if ([keyPath isEqualToString:PHModalWindowControllerMessageKeyPath]) {
        self.textField.stringValue = self.message;
    }

    // Update origin
    if ([keyPath isEqualToString:PHModalWindowControllerOriginKeyPath]) {
        [self.window setFrameOrigin:self.origin];
    }

    // Update weight
    if ([keyPath isEqualToString:PHModalWindowControllerWeightKeyPath]) {
        self.textField.font = [NSFont systemFontOfSize:self.weight];
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

    // Set appearance
    if ([self.appearance.lowercaseString isEqualToString:PHModalWindowControllerAppearanceTransparent]) {
        [self setupTransparentAppearance];
    } else {
        [self setupVibrantAppearance];
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
