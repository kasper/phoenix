/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHAccessibilityObserver.h"
#import "PHApp.h"
#import "PHCommand.h"
#import "PHContext.h"
#import "PHEventHandler.h"
#import "PHKeyHandler.h"
#import "PHModalWindowController.h"
#import "PHMouse.h"
#import "PHNotificationHelper.h"
#import "PHPathWatcher.h"
#import "PHPhoenix.h"
#import "PHWindow.h"

@interface PHContext ()

@property JSContext *context;
@property NSMutableSet<NSString *> *paths;
@property PHPathWatcher *watcher;
@property PHAccessibilityObserver *observer;
@property NSMutableDictionary<NSNumber *, NSValue *> *keyHandlers;

@end

@implementation PHContext

#if DEBUG
    static NSString * const PHConfigurationPath = @"~/.phoenix-debug.js";
#else
    static NSString * const PHConfigurationPath = @"~/.phoenix.js";
#endif

#pragma mark - Initialise

- (instancetype) init {

    if (self = [super init]) {

        self.paths = [NSMutableSet set];
        self.observer = [PHAccessibilityObserver observer];
        self.keyHandlers = [NSMutableDictionary dictionary];
    }

    return self;
}

+ (instancetype) context {

    return [[PHContext alloc] init];
}

#pragma mark - Resetting

- (void) resetConfigurationPaths {

    [self.paths removeAllObjects];
}

- (void) resetConfigurationWatcher {

    PHContext * __weak weakSelf = self;

    self.watcher = [PHPathWatcher watcherFor:self.paths.allObjects handler:^{

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

- (NSString *) resolvePath:(NSString *)path {

    path = path.stringByResolvingSymlinksInPath;

    // Resolve path
    if(![path isAbsolutePath]) {
        NSURL *relativeUrl = [NSURL URLWithString:PHConfigurationPath.stringByResolvingSymlinksInPath];
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

    [self.context evaluateScript:script];
    [self.paths addObject:path];
}

- (void) setupAPI {

    PHContext * __weak weakSelf = self;

    self.context[@"Phoenix"] = [[PHPhoenix alloc] initWithDelegate:self];
    self.context[@"Modal"] = [PHModalWindowController class];
    self.context[@"Command"] = [PHCommand class];
    self.context[@"Screen"] = [NSScreen class];
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
    [self loadScript:[self resolvePath:PHConfigurationPath]];
}

#pragma mark - Loading

- (void) load {

    [self resetConfigurationPaths];
    [self resetKeyHandlers];
    
    NSString *configurationPath = [self resolvePath:PHConfigurationPath];

    // No configuration file found, create one for the user
    if (![[NSFileManager defaultManager] fileExistsAtPath:configurationPath]) {
        [self createConfigurationFile:configurationPath];
    }

    [self setupContext];
    [self resetConfigurationWatcher];

    NSLog(@"Context loaded.");
}

#pragma mark - Binding

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

- (PHEventHandler *) bindEvent:(NSString *)event callback:(JSValue *)callback {

    return [[PHEventHandler alloc] initWithEvent:event callback:callback];
}

@end
