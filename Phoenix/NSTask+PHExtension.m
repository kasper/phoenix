/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "NSTask+PHExtension.h"

@implementation NSTask (PHExtension)

#pragma mark - Environment

+ (NSString *) searchPath {

    NSError *error;
    NSString *path = [self outputFromLaunchedTaskWithEnvironment:@{}
                                                       arguments:@[ @"-l", @"-c", @"echo $PATH" ]
                                                           error:&error];
    if (error) {
        return @"";
    }

    return path;
}

#pragma mark - Launching

+ (NSString *) outputFromLaunchedTaskWithEnvironment:(NSDictionary<NSString *, NSString *> *)environment
                                           arguments:(NSArray<NSString *> *)arguments
                                               error:(NSError **)error {
    NSTask *task = [[self alloc] init];
    NSPipe *standardOutput = [NSPipe pipe];
    NSPipe *standardError = [NSPipe pipe];

    task.launchPath = [NSProcessInfo processInfo].environment[@"SHELL"];
    task.environment = environment;
    task.arguments = arguments;
    task.standardOutput = standardOutput;
    task.standardError = standardError;

    [task launch];

    // Read standard output
    NSString *output = [[NSString alloc] initWithData:[standardOutput.fileHandleForReading readDataToEndOfFile]
                                             encoding:NSUTF8StringEncoding];
    // Read standard error
    NSString *reason = [[NSString alloc] initWithData:[standardError.fileHandleForReading readDataToEndOfFile]
                                             encoding:NSUTF8StringEncoding];
    // Wait for task termination
    [task waitUntilExit];

    // Report any errors
    if (error && task.terminationStatus != 0) {
        *error = [NSError errorWithDomain:NSTaskErrorDomain
                                     code:NSTaskErrorCode
                                 userInfo:@{ NSLocalizedDescriptionKey: @"Task failed.",
                                             NSLocalizedFailureReasonErrorKey: reason }];
    }

    return output;
}

@end
