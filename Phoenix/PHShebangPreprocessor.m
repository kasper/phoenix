/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHShebangPreprocessor.h"

@implementation PHShebangPreprocessor

#pragma mark - Reading

+ (NSString *) scanCommand:(NSScanner *)scanner {

    // Shebang (#!) was not found
    if (![scanner scanString:@"#!" intoString:NULL]) {
        return nil;
    }

    NSString *command;
    [scanner scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:&command];

    return command;
}

+ (NSError *) readErrorFromStandardError:(NSPipe *)standardError {

    NSData *errorData = [standardError.fileHandleForReading readDataToEndOfFile];

    if (errorData.length == 0) {
        return nil;
    }

    NSString *reason = [[NSString alloc] initWithData:errorData encoding:NSUTF8StringEncoding];

    return [NSError errorWithDomain:PHShebangPreprocessorErrorDomain
                               code:PHShebangPreprocessorErrorCode
                           userInfo:@{ NSLocalizedDescriptionKey: @"Preprocessing failed.",
                                       NSLocalizedFailureReasonErrorKey: reason }];
}

+ (NSString *) readOutputFromStandardOutputFile:(NSFileHandle *)standardOutputFile {

    NSString *output = [[NSString alloc] initWithData:[standardOutputFile readDataToEndOfFile]
                                             encoding:NSUTF8StringEncoding];

    // Remove shebang-directive if it is still present
    NSScanner *outputScanner = [NSScanner scannerWithString:output];
    [self scanCommand:outputScanner];

    return [output substringFromIndex:outputScanner.scanLocation];
}

#pragma mark - Preprocessing

+ (NSString *) process:(NSString *)script atPath:(NSString *)path error:(NSError **)error {

    NSScanner *scanner = [NSScanner scannerWithString:script];
    NSString *command = [self scanCommand:scanner];

    if (!command) {
        return script;
    }

    /* Launch process */

    NSTask *task = [[NSTask alloc] init];
    NSPipe *standardOutput = [NSPipe pipe];
    NSPipe *standardError = [NSPipe pipe];
    NSFileHandle *standardOutputFile = standardOutput.fileHandleForReading;

    // Make sure we use the current user's $SHELL
    NSDictionary *environmentDict = [[NSProcessInfo processInfo] environment];
    NSString *shellString = [environmentDict objectForKey:@"SHELL"];

    task.launchPath = shellString;
    task.standardOutput = standardOutput;
    task.standardError = standardError;
    task.arguments = @[ @"-cl", [NSString stringWithFormat:@"%@ %@", command, path] ];

    [task launch];
    [task waitUntilExit];

    /* Read output */

    NSError *taskError = [self readErrorFromStandardError:standardError];

    if (taskError) {

        if (error) {
            *error = taskError;
        }

        return script;
    }

    return [self readOutputFromStandardOutputFile:standardOutputFile];
}

@end
