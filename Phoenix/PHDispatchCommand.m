/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHDispatchCommand.h"
#import "PHEventConstants.h"

@implementation PHDispatchCommand

- (id) performDefaultImplementation {
    NSMutableDictionary* notificationParameters = [NSMutableDictionary dictionary];
    NSString* data = [[self evaluatedArguments] objectForKey:@"data"];
    if (data) {
        notificationParameters[PHAppleScriptDispatchNotification] = data;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:PHAppleScriptDispatchNotification object:nil userInfo:notificationParameters];
    return nil;
}

@end
