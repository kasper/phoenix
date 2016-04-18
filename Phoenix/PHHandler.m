/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHHandler.h"

@interface PHHandler ()

@property JSManagedValue *callback;

@end

@implementation PHHandler

#pragma mark - Callback

- (void) manageCallback:(JSValue *)callback {

    self.callback = [JSManagedValue managedValueWithValue:callback andOwner:self];
}

#pragma mark - Call

- (void) callWithArguments:(NSArray *)arguments {

    JSValue *function = self.callback.value;
    [function callWithArguments:arguments];
}

@end
