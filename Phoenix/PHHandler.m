/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHHandler.h"

@interface PHHandler ()

@property JSManagedValue *callback;

@end

@implementation PHHandler

#pragma mark - Initialising

- (instancetype) initWithCallback:(JSValue *)callback {

    if (self = [super init]) {
        self.callback = [JSManagedValue managedValueWithValue:callback andOwner:self];
    }

    return self;
}

#pragma mark - Calling

- (void) callWithArguments:(NSArray *)arguments {

    JSValue *function = self.callback.value;

    if (!function.isUndefined) {
        [function callWithArguments:arguments];
    }
}

@end
