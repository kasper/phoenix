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

    task.launchPath = @"/bin/bash";
    task.standardOutput = standardOutput;
    task.standardError = standardError;
    task.arguments = @[ @"-c", [NSString stringWithFormat:@"%@ %@", command, path] ];

    [task launch];
    [task waitUntilExit];

    NSError *taskError = [self readErrorFromStandardError:standardError];

    if (taskError) {

        if (error) {
            *error = taskError;
        }

        return script;
    }

    // Read past shebang-directive (hold onto it incase it's not the shebang text)
    NSString *outputHead = [[NSString alloc]
                               initWithData:[standardOutputFile readDataOfLength:scanner.scanLocation]
                                   encoding:NSUTF8StringEncoding];
    // Read the rest of processed output
    NSString *processed  = [[NSString alloc]
                               initWithData:[standardOutputFile readDataToEndOfFile]
                                   encoding:NSUTF8StringEncoding];

    // return the output with shebang clipped
    if ([command isEqualToString:outputHead]) {

        return processed;

    }

    // otherwise glue it back together
    return [outputHead stringByAppendingString:processed];
}

@end
