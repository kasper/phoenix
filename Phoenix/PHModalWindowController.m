/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHModalWindowController.h"
#import "PHContext.h"

@interface PHModalWindowController ()

@property NSColor *textColor;

#pragma mark - Views

@property(weak) IBOutlet NSView *containerView;
@property(weak) IBOutlet NSImageView *iconView;
@property(weak) IBOutlet NSTextField *textField;

#pragma mark - Constraints

@property(weak) IBOutlet NSLayoutConstraint *iconViewZeroWidthConstraint;
@property(weak) IBOutlet NSLayoutConstraint *separatorConstraint;
@property(weak) IBOutlet NSLayoutConstraint *textFieldTextWidthConstraint;
@property(weak) IBOutlet NSLayoutConstraint *textFieldInputWidthConstraint;

@end

@implementation PHModalWindowController

typedef NS_ENUM(NSInteger, PHModalWindowControllerAppearanceMaterial) {
    PHModalWindowControllerAppearanceMaterialDark,
    PHModalWindowControllerAppearanceMaterialLight,
    PHModalWindowControllerAppearanceMaterialTransparent
};

static NSString *const PHModalWindowControllerAppearanceDark = @"dark";
static NSString *const PHModalWindowControllerIconKeyPath = @"icon";
static NSString *const PHModalWindowControllerMessageKeyPath = @"message";
static NSString *const PHModalWindowControllerOriginKeyPath = @"origin";
static NSString *const PHModalWindowControllerTextKeyPath = @"text";

#pragma mark - Initialising

- (instancetype)init {
    if (self = [super init]) {
        [self addObserverForKeyPaths:[PHModalWindowController keyPaths]];

        self.animationDuration = 0.2;
        self.weight = 24.0;
        self.appearance = PHModalWindowControllerAppearanceDark;
        self.hasShadow = YES;
        self.text = @"";
        self.textAlignment = @"left";
        self.font = [NSFont systemFontOfSize:self.weight].fontName;
        self.inputPlaceholder = @"";

        // Observe context load
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(close)
                                                     name:PHContextWillLoadNotification
                                                   object:nil];
    }

    return self;
}

#pragma mark - Deallocing

- (void)dealloc {
    [super close];
    [self removeObserverForKeyPaths:[PHModalWindowController keyPaths]];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PHContextWillLoadNotification object:nil];
}

#pragma mark - Key Paths

+ (NSArray<NSString *> *)keyPaths {
    static NSArray<NSString *> *keyPaths;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keyPaths = @[
            PHModalWindowControllerIconKeyPath,
            PHModalWindowControllerMessageKeyPath,
            PHModalWindowControllerOriginKeyPath,
            PHModalWindowControllerTextKeyPath
        ];
    });

    return keyPaths;
}

#pragma mark - NSWindowController

- (NSString *)windowNibName {
    return @"ModalWindow";
}

#pragma mark - NSControlTextEditingDelegate

- (void)controlTextDidChange:(NSNotification *)__unused notification {
    JSValue *callback = self.textDidChange;
    NSString *value = self.text ? self.text : @"";

    if (!callback.isUndefined) {
        [callback callWithArguments:@[value]];
    }
}

- (void)controlTextDidEndEditing:(NSNotification *)notification {
    static NSDictionary<NSNumber *, NSString *> *actions;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        actions =
            @{@(NSTextMovementReturn): @"return",
              @(NSTextMovementTab): @"tab",
              @(NSTextMovementBacktab): @"backtab"};
    });

    JSValue *callback = self.textDidCommit;
    NSString *value = self.text ? self.text : @"";
    NSNumber *textMovement = notification.userInfo[NSTextMovementUserInfoKey];
    NSString *action = actions[textMovement];

    if (!callback.isUndefined) {
        NSArray *arguments = action ? @[value, action] : @[value];
        [callback callWithArguments:arguments];
    }
}

#pragma mark - Appearance

- (NSTextAlignment)alignment {
    static NSDictionary<NSString *, NSNumber *> *alignments;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alignments = @{@"left": @0, @"right": @2, @"center": @1, @"centre": @1};
    });

    NSNumber *value = alignments[self.textAlignment.lowercaseString];

    if (!value) {
        return NSTextAlignmentLeft;
    }

    return value.integerValue;
}

- (PHModalWindowControllerAppearanceMaterial)material {
    static NSDictionary<NSString *, NSNumber *> *appearances;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appearances = @{PHModalWindowControllerAppearanceDark: @0, @"light": @1, @"transparent": @2};
    });

    NSNumber *value = appearances[self.appearance.lowercaseString];

    if (!value) {
        return PHModalWindowControllerAppearanceMaterialDark;
    }

    return value.integerValue;
}

- (void)setupVibrantAppearance {
    CGFloat cornerRadius = 10.0;
    NSDictionary<NSString *, id> *views = @{@"container": self.containerView};

    NSVisualEffectView *visualEffectView = [[NSVisualEffectView alloc] initWithFrame:self.window.contentView.frame];
    visualEffectView.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantDark];
    visualEffectView.state = NSVisualEffectStateActive;

    // Use light appearance
    if ([self material] == PHModalWindowControllerAppearanceMaterialLight) {
        visualEffectView.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantLight];
        self.textField.textColor = self.textColor ? self.textColor : [NSColor blackColor];
    }

    // Set mask image to rounded rectangle
    CGFloat edgeSize = 1.0 + (2 * cornerRadius);
    NSSize maskSize = NSMakeSize(edgeSize, edgeSize);
    visualEffectView.maskImage = [NSImage imageWithSize:maskSize
                                                flipped:NO
                                         drawingHandler:^BOOL(NSRect destination) {
                                             [[NSBezierPath bezierPathWithRoundedRect:destination
                                                                              xRadius:cornerRadius
                                                                              yRadius:cornerRadius] fill];
                                             return YES;
                                         }];

    // Make edges smooth
    visualEffectView.maskImage.capInsets = NSEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius);

    // Add container view as subview
    [visualEffectView addSubview:self.containerView];

    [visualEffectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[container]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];

    [visualEffectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[container]-(0)-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];

    [visualEffectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[container]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];

    [visualEffectView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[container]-(0)-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views]];
    // Set visual effect view as the content view
    self.window.contentView = visualEffectView;
}

- (void)setTextColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    self.textColor = [NSColor colorWithCalibratedRed:red / 255 green:green / 255 blue:blue / 255 alpha:alpha];
    self.textField.textColor = self.textColor;
}

#pragma mark - Properties

- (BOOL)hasText {
    return ![self.text isEqualToString:@""];
}

#pragma mark - KVO

- (void)addObserverForKeyPaths:(NSArray<NSString *> *)keyPaths {
    for (NSString *keyPath in keyPaths) {
        [self addObserver:self forKeyPath:keyPath options:0 context:NULL];
    }
}

- (void)removeObserverForKeyPaths:(NSArray<NSString *> *)keyPaths {
    for (NSString *keyPath in keyPaths) {
        [self removeObserver:self forKeyPath:keyPath];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)__unused object
                        change:(NSDictionary<NSString *, id> *)__unused change
                       context:(void *)__unused context {
    [self window];

    // Update text-property
    if ([keyPath isEqualToString:PHModalWindowControllerMessageKeyPath]) {
        NSLog(@"Deprecated: Property “message” for modal is deprecated and will be removed in later versions, use "
              @"“text” instead.");
        self.text = self.message;
    }

    // Update window origin
    if ([keyPath isEqualToString:PHModalWindowControllerOriginKeyPath]) {
        if (!isnan(self.origin.x) && !isnan(self.origin.y)) {
            [self.window setFrameOrigin:self.origin];
        }
    }

    // Update layout
    if ([keyPath isEqualToString:PHModalWindowControllerIconKeyPath] ||
        [keyPath isEqualToString:PHModalWindowControllerTextKeyPath]) {
        [self layout];
    }
}

#pragma mark - Displaying

- (BOOL)isDisplayable {
    return self.icon || self.isInput || [self hasText];
}

- (void)layout {
    self.iconViewZeroWidthConstraint.priority = !self.icon ? 999 : NSLayoutPriorityDefaultLow;
    self.separatorConstraint.constant = (!self.icon || (!self.isInput && ![self hasText])) ? 0.0 : 10.0;
    self.textFieldTextWidthConstraint.priority =
        self.isInput ? NSLayoutPriorityDefaultLow : NSLayoutPriorityDefaultHigh;
    self.textFieldInputWidthConstraint.priority =
        self.isInput ? NSLayoutPriorityDefaultHigh : NSLayoutPriorityDefaultLow;
}

- (NSRect)frame {
    [self layout];
    [self.window layoutIfNeeded];
    return self.window.frame;
}

- (void)fadeWindowToAlpha:(CGFloat)alpha completionHandler:(void (^)(void))completionHandler {
    [NSAnimationContext
        runAnimationGroup:^(NSAnimationContext *context) {
            context.duration = self.animationDuration;
            [self.window animator].alphaValue = alpha;
        }
        completionHandler:completionHandler];
}

- (instancetype)show {
    if (![self isDisplayable]) {
        return self;
    }

    // Set vibrant appearance
    if ([self material] != PHModalWindowControllerAppearanceMaterialTransparent) {
        [self setupVibrantAppearance];
    }

    self.window.ignoresMouseEvents = !self.isInput;
    self.window.hasShadow = self.hasShadow;
    self.textField.alignment = [self alignment];

    if (self.isInput) {
        self.textField.placeholderString = self.inputPlaceholder;

        // Required for text field to become key
        [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
    }

    [self layout];
    [self showWindow:self];
    [self fadeWindowToAlpha:1.0
          completionHandler:^{
              // Keep window open until closed
              if (self.duration == 0) {
                  return;
              }

              [self performSelector:@selector(close) withObject:nil afterDelay:self.duration];
          }];

    return self;
}

- (void)focus {
    [self.window makeKeyWindow];
    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
}

- (void)close {
    [self fadeWindowToAlpha:0.0
          completionHandler:^{
              [super close];
          }];
}

@end
