/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHNotificationHelper.h"
#import "PHPhoenix.h"
#import "PHPreferences.h"

@interface PHPhoenix ()

@property (weak) id<PHContextDelegate> delegate;

@end

@implementation PHPhoenix

#pragma mark - Initialising

- (instancetype) initWithDelegate:(id<PHContextDelegate>)delegate {

    if (self = [super init]) {
        self.delegate = delegate;
    }

    return self;
}

+ (instancetype) withDelegate:(id<PHContextDelegate>)delegate {

    return [[self alloc] initWithDelegate:delegate];
}

#pragma mark - Actions

- (void) reload {

    [self.delegate load];
}

- (void) set:(NSDictionary<NSString *, id> *)preferences {

    [[PHPreferences sharedPreferences] add:preferences];
}

- (id) key:(NSString *)key value:(id)value {

    // Get value
    if (!value) {
        return [self.delegate objectInStorageForKey:key];
    }

    // Store value
    [self.delegate storeObject:value forKey:key];
    return nil;
}

- (void) log:(NSString *)message {

    NSLog(@"%@", message);
}

- (void) notify:(NSString *)message {

    [PHNotificationHelper deliver:message];
}

@end
