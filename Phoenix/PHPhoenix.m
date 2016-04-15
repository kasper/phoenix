/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHEventHandler.h"
#import "PHKeyHandler.h"
#import "PHNotificationHelper.h"
#import "PHPhoenix.h"
#import "PHPreferences.h"
#import "PHTimerHandler.h"

@interface PHPhoenix ()

@property (weak) id<PHContextDelegate> delegate;

@end

@implementation PHPhoenix

#pragma mark - Initialise

- (instancetype) initWithDelegate:(id<PHContextDelegate>)delegate {

    if (self = [super init]) {
        self.delegate = delegate;
    }

    return self;
}

#pragma mark - Actions

- (void) reload {

    [self.delegate load];
}

- (PHKeyHandler *) bindKey:(NSString *)key modifiers:(NSArray<NSString *> *)modifiers callback:(JSValue *)callback {

    return [self.delegate bindKey:key modifiers:modifiers callback:callback];
}

- (PHEventHandler *) bindEvent:(NSString *)event callback:(JSValue *)callback {

    return [self.delegate bindEvent:event callback:callback];
}

- (PHTimerHandler *) after:(NSTimeInterval)interval callback:(JSValue *)callback {

    return [PHTimerHandler withInterval:interval repeats:NO callback:callback];
}

- (PHTimerHandler *) every:(NSTimeInterval)interval callback:(JSValue *)callback {

    return [PHTimerHandler withInterval:interval repeats:YES callback:callback];
}

- (void) set:(NSDictionary<NSString *, id> *)preferences {

    [[PHPreferences sharedPreferences] add:preferences];
}

- (void) log:(NSString *)message {

    NSLog(@"%@", message);
}

- (void) notify:(NSString *)message {

    [PHNotificationHelper deliver:message];
}

@end
