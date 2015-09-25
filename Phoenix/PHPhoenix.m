/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHKeyHandler.h"
#import "PHNotification.h"
#import "PHPhoenix.h"

@interface PHPhoenix ()

@property id<PHContextDelegate> delegate;

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

    return [self.delegate bindKey:key.lowercaseString
                        modifiers:[modifiers valueForKey:@"lowercaseString"]
                         callback:callback];
}

- (void) log:(NSString *)message {

    NSLog(@"%@", message);
}

- (void) notify:(NSString *)message {

    [PHNotification deliver:message];
}

@end
