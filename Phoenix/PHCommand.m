/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHCommand.h"

@implementation PHCommand

#pragma mark - Actions

+ (BOOL) runPath:(NSString *)path withArguments:(NSArray *)arguments {

    NSTask *task = [[NSTask alloc] init];
    task.launchPath = path;

    if (arguments) {
        task.arguments = arguments;
    }

    @try {
        [task launch];
    }

    @catch (NSException *exception) {
        NSLog(@"Error: Could not run command in path %@ with arguments %@. Exception: %@.", path, arguments, exception);
        return NO;
    }

    [task waitUntilExit];
    return task.terminationStatus == 0;
}

@end
