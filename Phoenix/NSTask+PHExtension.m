/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "NSTask+PHExtension.h"

@implementation NSTask (PHExtension)

#pragma mark - Environment

+ (NSString *) searchPath {

    NSError *error;
    NSString *path = [NSTask outputFromLaunchedTaskWithLaunchPath:[NSProcessInfo processInfo].environment[@"SHELL"]
                                                      environment:@{}
                                                        arguments:@[ @"-l", @"-c", @"echo $PATH" ]
                                                            error:&error];
    if (error) {
        return @"";
    }

    return path;
}

#pragma mark - Launching

+ (NSString *) outputFromLaunchedTaskWithLaunchPath:(NSString *)path
                                        environment:(NSDictionary<NSString *, NSString *> *)environment
                                          arguments:(NSArray<NSString *> *)arguments
                                              error:(NSError **)error {
    /* Launch task */

    NSTask *task = [[NSTask alloc] init];
    NSPipe *standardOutput = [NSPipe pipe];
    NSPipe *standardError = [NSPipe pipe];

    task.launchPath = path;
    task.environment = environment;
    task.arguments = arguments;
    task.standardOutput = standardOutput;
    task.standardError = standardError;

    [task launch];
    [task waitUntilExit];

    /* Read output */

    NSString *output = [[NSString alloc] initWithData:[standardOutput.fileHandleForReading readDataToEndOfFile]
                                             encoding:NSUTF8StringEncoding];
    /* Read error */

    if (error && task.terminationStatus != 0) {

        NSString *reason = [[NSString alloc] initWithData:[standardError.fileHandleForReading readDataToEndOfFile]
                                                 encoding:NSUTF8StringEncoding];

        *error = [NSError errorWithDomain:NSTaskErrorDomain
                                     code:NSTaskErrorCode
                                 userInfo:@{ NSLocalizedDescriptionKey: @"Task failed.",
                                             NSLocalizedFailureReasonErrorKey: reason }];
    }

    return output;
}

@end
