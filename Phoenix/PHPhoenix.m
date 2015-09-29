/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHEventHandler.h"
#import "PHKeyHandler.h"
#import "PHNotification.h"
#import "PHPhoenix.h"

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

- (void) log:(NSString *)message {

    NSLog(@"%@", message);
}

- (void) notify:(NSString *)message {

    [PHNotification deliver:message];
}

@end
