/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHShebangPreprocessor.h"

@implementation PHShebangPreprocessor

#pragma mark - Reading

+ (NSString *) scanCommand:(NSScanner *)scanner {

    // Shebang (#!) was not found
    if (![scanner scanString:@"#!" intoString:nil]) {
        return nil;
    }

    NSString *command;
    [scanner scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:&command];

    return command;
}

+ (NSError *) errorFromStandardError:(NSPipe *)standardError {

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

    *error = [self errorFromStandardError:standardError];

    if (*error) {
        return script;
    }

    // Read past shebang-directive
    [standardOutputFile readDataOfLength:scanner.scanLocation];

    return [[NSString alloc] initWithData:[standardOutputFile readDataToEndOfFile] encoding:NSUTF8StringEncoding];
}

@end
