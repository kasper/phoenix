/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import JavaScriptCore;

#import "NSImage+PHExtension.h"
#import "NSScreen+PHExtension.h"
#import "PHAccessibilityObserver.h"
#import "PHApp.h"
#import "PHContext.h"
#import "PHEventHandler.h"
#import "PHGlobalEventMonitor.h"
#import "PHKeyHandler.h"
#import "PHModalWindowController.h"
#import "PHMouse.h"
#import "PHNotificationHelper.h"
#import "PHPathWatcher.h"
#import "PHPhoenix.h"
#import "PHPreferences.h"
#import "PHShebangPreprocessor.h"
#import "PHSpace.h"
#import "PHStorage.h"
#import "PHTaskHandler.h"
#import "PHTimerHandler.h"
#import "PHWindow.h"

@interface PHContext ()

@property JSContext *context;
@property (copy) NSString *primaryConfigurationPath;
@property NSMutableSet<NSString *> *configurationPaths;
@property PHPathWatcher *watcher;
@property PHAccessibilityObserver *observer;
@property PHGlobalEventMonitor *monitor;
@property PHStorage *storage;

@end

@implementation PHContext

#pragma mark - Initialising

- (instancetype) init {

    if (self = [super init]) {
        self.primaryConfigurationPath = [self resolvePrimaryConfigurationPath];
        self.configurationPaths = [NSMutableSet set];
        self.observer = [PHAccessibilityObserver observer];
        self.monitor = [PHGlobalEventMonitor monitor];
        self.storage = [PHStorage storage];
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

#pragma mark - Setting up

- (NSString *) resolvePrimaryConfigurationPath {

    static NSArray<NSString *> *primaryConfigurationPaths;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

#if DEBUG
        primaryConfigurationPaths = @[ @"~/.phoenix.debug.js",
                                       @"~/Library/Application Support/Phoenix/phoenix.debug.js",
                                       @"~/.config/phoenix/phoenix.debug.js" ];
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

    // Resolve relative path
    if(![path isAbsolutePath]) {
        NSURL *relativeUrl = [NSURL URLWithString:self.primaryConfigurationPath];
        path = [NSURL URLWithString:path relativeToURL:relativeUrl].absoluteString;
    }

    return path.stringByStandardizingPath;
}

- (void) createConfigurationFile:(NSString *)path {

    NSError *error;
    NSString *directory = path.stringByDeletingLastPathComponent;

    // Ensure configuration directory exists
    [[NSFileManager defaultManager] createDirectoryAtPath:directory
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    if (error) {
        NSLog(@"Error: Could not create configuration directory to path “%@”. (%@)", directory, error);
        return;
    }

    BOOL fileCreated = [[NSFileManager defaultManager] createFileAtPath:path
                                                               contents:[@"" dataUsingEncoding:NSUTF8StringEncoding]
                                                             attributes:nil];
    if (!fileCreated) {
        NSLog(@"Error: Could not create configuration file to path “%@”.", path);
        return;
    }

    [PHNotificationHelper deliver:[NSString stringWithFormat:@"Configuration file “%@” was created.", path] withDelegate:nil];
}

- (void) loadScript:(NSString *)path {

    NSError *error;
    NSString *script = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    NSURL *url = [NSURL fileURLWithPath:path relativeToURL:[NSURL fileURLWithPath:path.stringByDeletingLastPathComponent isDirectory:true]];

    if (error) {
        script = @"";
        NSLog(@"Error: Could not read file in path “%@” to string. (%@)", path, error);
    }

    NSError *preprocessError;
    script = [PHShebangPreprocessor process:script atPath:path error:&preprocessError];

    if (preprocessError) {
        NSError *underlyingError = preprocessError.userInfo[NSUnderlyingErrorKey];
        NSLog(@"Error: Preprocessing failed. (%@)", underlyingError.localizedFailureReason);
        [PHNotificationHelper deliver:@"Preprocessing failed. Refer to the logs for more information." withDelegate:self];
    }

    [self.context evaluateScript:script withSourceURL:url];
    [self.configurationPaths addObject:path];
}

- (void) setupAPI {

    PHContext * __weak weakSelf = self;

    self.context[@"Phoenix"] = [PHPhoenix withDelegate:self];
    self.context[@"Storage"] = weakSelf.storage;
    self.context[@"Key"] = [PHKeyHandler class];
    self.context[@"Event"] = [PHEventHandler class];
    self.context[@"Timer"] = [PHTimerHandler class];
    self.context[@"Task"] = [PHTaskHandler class];
    self.context[@"Image"] = [NSImage class];
    self.context[@"Modal"] = [PHModalWindowController class];
    self.context[@"Screen"] = [NSScreen class];
    self.context[@"Space"] = [PHSpace class];
    self.context[@"Mouse"] = [PHMouse class];
    self.context[@"App"] = [PHApp class];
    self.context[@"Window"] = [PHWindow class];

    self.context[@"require"] = ^(NSString *path) {

        path = [weakSelf resolvePath:path];

        if(![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            NSString *message = [NSString stringWithFormat:@"Require: File “%@” does not exist.", path];
            weakSelf.context.exception = [JSValue valueWithNewErrorFromMessage:message inContext:weakSelf.context];
            return;
        }

        [weakSelf loadScript:path];
    };
}

- (void) setupContext {

    PHContext * __weak weakSelf = self;
    self.context = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception) {

        JSValue *log = [context[@"Phoenix"] objectForKeyedSubscript:@"log"];
        [log callWithArguments:@[ exception ]];

        NSString *description = [NSString stringWithFormat:@"Uncaught exception raised: “%@” (%@:%@). Refer to the logs for more information.", exception[@"message"], exception[@"line"], exception[@"column"]];
        [PHNotificationHelper deliver:description
                         withDelegate:weakSelf];
    };

    [self setupAPI];
    [self loadScript:[[NSBundle mainBundle] pathForResource:@"lodash.min" ofType:@"js"]];
    [self loadScript:[[NSBundle mainBundle] pathForResource:@"phoenix.min" ofType:@"js"]];
    [self loadScript:self.primaryConfigurationPath];
}

#pragma mark - NSUserNotificationCenterDelegate

- (void) userNotificationCenter:(NSUserNotificationCenter *)__unused center
        didActivateNotification:(NSUserNotification *)__unused notification {

    [PHApp launch:@"Console" withOptionals:@{ PHAppFocusOptionKey: @YES }];
}

#pragma mark - PHContextDelegate

- (void) load {

    [[NSNotificationCenter defaultCenter] postNotificationName:PHContextWillLoadNotification object:nil];

    [[PHPreferences sharedPreferences] reset];
    [self resetConfigurationPaths];

    // No configuration file found, create one for the user
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.primaryConfigurationPath]) {
        [self createConfigurationFile:self.primaryConfigurationPath];
    }

    [self setupContext];
    [self resetWatcher];

    NSLog(@"Context loaded.");
}

- (void) shouldTerminate:(void (^)(void))terminate {

    if (![self.storage isPersisting]) {
        terminate();
        return;
    }

    // Wait until storage is persisted
    [[NSNotificationCenter defaultCenter] addObserverForName:PHStorageDidPersistNotification
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(__unused NSNotification *notification) {
        terminate();
    }];
}

@end
