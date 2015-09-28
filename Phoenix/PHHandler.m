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

    // Create a new scope for callback
    JSValue *callback = self.callback.value;
    JSContext *scope = [[JSContext alloc] initWithVirtualMachine:callback.context.virtualMachine];
    JSValue *function = [JSValue valueWithObject:callback inContext:scope];

    [function callWithArguments:arguments];
}

- (void) call {

    [self callWithArguments:@[]];
}

@end
