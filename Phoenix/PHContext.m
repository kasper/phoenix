/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "NSScreen+PHExtension.h"
#import "PHAccessibilityObserver.h"
#import "PHApp.h"
#import "PHCommand.h"
#import "PHContext.h"
#import "PHKeyHandler.h"
#import "PHModalWindowController.h"
#import "PHMouse.h"
#import "PHNotificationHelper.h"
#import "PHPathWatcher.h"
#import "PHPhoenix.h"
#import "PHPreferences.h"
#import "PHShebangPreprocessor.h"
#import "PHSpace.h"
#import "PHWindow.h"

@interface PHContext ()

@property JSContext *context;
@property (copy) NSString *primaryConfigurationPath;
@property NSMutableSet<NSString *> *configurationPaths;
@property PHPathWatcher *watcher;
@property PHAccessibilityObserver *observer;
@property NSMutableDictionary<NSNumber *, NSValue *> *keyHandlers;

@end

@implementation PHContext

#pragma mark - Initialise

- (instancetype) init {

    if (self = [super init]) {
        self.primaryConfigurationPath = [self resolvePrimaryConfigurationPath];
        self.configurationPaths = [NSMutableSet set];
        self.observer = [PHAccessibilityObserver observer];
        self.keyHandlers = [NSMutableDictionary dictionary];
    }

    return self;
}

+ (instancetype) context {

    return [[self alloc] init];
}

#pragma mark - Resetting

- (void) resetConfigurationPaths {

    [self.configurationPaths removeAllObjects];
}

- (void) resetWatcher {

    PHContext * __weak weakSelf = self;

    self.watcher = [PHPathWatcher watcherFor:self.configurationPaths.allObjects handler:^{

        [[weakSelf class] cancelPreviousPerformRequestsWithTarget:weakSelf
                                                         selector:@selector(load)
                                                           object:nil];

        [weakSelf performSelector:@selector(load) withObject:nil afterDelay:0.5];
    }];
}

- (void) resetKeyHandlers {

    [self.keyHandlers removeAllObjects];
}

#pragma mark - Setup

- (void) handleException:(id)exception {

    NSLog(@"%@", exception);
    [PHNotificationHelper deliver:[NSString stringWithFormat:@"%@", exception]];
}

- (NSString *) resolvePrimaryConfigurationPath {

    static NSArray<NSString *> *primaryConfigurationPaths;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

#if DEBUG
        primaryConfigurationPaths = @[ @"~/.phoenix-debug.js",
                                       @"~/Library/Application Support/Phoenix/phoenix-debug.js",
                                       @"~/.config/phoenix/phoenix-debug.js" ];
#else
        primaryConfigurationPaths = @[ @"~/.phoenix.js",
                                       @"~/Library/Application Support/Phoenix/phoenix.js",
                                       @"~/.config/phoenix/phoenix.js" ];
#endif
    });

    // Look for the first existing configuration location
    for (NSString *primaryConfigurationPath in primaryConfigurationPaths) {

        NSString *resolvedPrimaryConfigurationPath = primaryConfigurationPath.stringByResolvingSymlinksInPath;

        if ([[NSFileManager defaultManager] fileExistsAtPath:resolvedPrimaryConfigurationPath]) {
            return resolvedPrimaryConfigurationPath;
        }
    }

    // Use default configuration location
    return primaryConfigurationPaths.firstObject.stringByResolvingSymlinksInPath;
}

- (NSString *) resolvePath:(NSString *)path {

    path = path.stringByResolvingSymlinksInPath;

    // Resolve path
    if(![path isAbsolutePath]) {
        NSURL *relativeUrl = [NSURL URLWithString:self.primaryConfigurationPath];
        path = [NSURL URLWithString:path relativeToURL:relativeUrl].absoluteString;
    }

    return path.stringByStandardizingPath;
}

- (void) createConfigurationFile:(NSString *)path {

    BOOL fileCreated = [[NSFileManager defaultManager] createFileAtPath:path
                                                               contents:[@"" dataUsingEncoding:NSUTF8StringEncoding]
                                                             attributes:nil];
    if (!fileCreated) {
        NSLog(@"Error: Could not create configuration file to path “%@”.", path);
        return;
    }

    [PHNotificationHelper deliver:[NSString stringWithFormat:@"Configuration file “%@” was created.", path]];
}

- (void) loadScript:(NSString *)path {

    NSError *error;
    NSString *script = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];

    if (error) {
        NSLog(@"Error: Could not read file in path “%@” to string. (%@)", path, error);
    }

    NSError *preprocessError;
    script = [PHShebangPreprocessor process:script atPath:path error:&preprocessError];

    if (preprocessError) {
        NSLog(@"Error: Preprocessing failed. (%@)", preprocessError);
    }

    [self.context evaluateScript:script];
    [self.configurationPaths addObject:path];
}

- (void) setupAPI {

    PHContext * __weak weakSelf = self;

    self.context[@"Phoenix"] = [PHPhoenix withDelegate:self];
    self.context[@"Modal"] = [PHModalWindowController class];
    self.context[@"Command"] = [PHCommand class];
    self.context[@"Screen"] = [NSScreen class];
    self.context[@"Space"] = [PHSpace class];
    self.context[@"Mouse"] = [PHMouse class];
    self.context[@"App"] = [PHApp class];
    self.context[@"Window"] = [PHWindow class];

    self.context[@"require"] = ^(NSString *path) {

        path = [weakSelf resolvePath:path];

        if(![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            NSString *message = [NSString stringWithFormat:@"Require: File “%@” does not exist.", path];
            [weakSelf handleException:message];
            return;
        }

        [weakSelf loadScript:path];
    };
}

- (void) setupContext {

    PHContext * __weak weakSelf = self;

    // Create context
    self.context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
    self.context.exceptionHandler = ^(__unused JSContext *context, JSValue *value) {

        [weakSelf handleException:value];
    };

    // Load context
    [self setupAPI];
    [self loadScript:[[NSBundle mainBundle] pathForResource:@"underscore-min" ofType:@"js"]];
    [self loadScript:self.primaryConfigurationPath];
}

#pragma mark - Loading

- (void) load {

    [[PHPreferences sharedPreferences] reset];
    [self resetConfigurationPaths];
    [self resetKeyHandlers];

    // No configuration file found, create one for the user
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.primaryConfigurationPath]) {
        [self createConfigurationFile:self.primaryConfigurationPath];
    }

    [self setupContext];
    [self resetWatcher];

    NSLog(@"Context loaded.");
}

#pragma mark - Binding Keys

- (PHKeyHandler *) bindKey:(NSString *)key modifiers:(NSArray<NSString *> *)modifiers callback:(JSValue *)callback {

    PHKeyHandler *keyHandler = self.keyHandlers[@([PHKeyHandler hashForKey:key modifiers:modifiers])]
                                   .nonretainedObjectValue;
    // Bind new key
    if (!keyHandler) {
        keyHandler = [PHKeyHandler withKey:key modifiers:modifiers];
    }

    // Key not supported
    if (!keyHandler) {
        return nil;
    }

    // Set callback
    [keyHandler manageCallback:callback];

    self.keyHandlers[@([keyHandler hash])] = [NSValue valueWithNonretainedObject:keyHandler];
    return keyHandler;
}

@end
