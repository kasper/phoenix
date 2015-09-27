/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHHandler.h"

@interface PHHandler ()

@property JSManagedValue *callback;

@end

@implementation PHHandler

#pragma mark - Callback

- (void) setCallback:(JSValue *)callback forContext:(JSContext *)context {

    self.callback = [JSManagedValue managedValueWithValue:callback];
    [context.virtualMachine addManagedReference:self.callback withOwner:self];
}

#pragma mark - Call

- (void) call {

    [self.callback.value callWithArguments:@[]];
}

@end
