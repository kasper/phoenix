/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHShebangPreprocessor.h"

@implementation PHShebangPreprocessor

#pragma mark - Preprocessing

+ (NSString *) process:(NSString *)script atPath:(NSString *)path error:(NSError **)error {

    NSScanner *scanner = [NSScanner scannerWithString:script];

    // Shebang #! was not found
    if (![scanner scanString:@"#!" intoString:nil]) {
        return script;
    }

    NSTask *task = [[NSTask alloc] init];
    NSPipe *standardOutput = [NSPipe pipe];
    NSPipe *standardError = [NSPipe pipe];
    NSFileHandle *standardOutputFile = standardOutput.fileHandleForReading;

    NSString *command;
    [scanner scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:&command];

    task.launchPath = @"/bin/bash";
    task.standardOutput = standardOutput;
    task.standardError = standardError;
    task.arguments = @[ @"-c", [NSString stringWithFormat:@"%@ %@", command, path] ];

    [task launch];

    NSData *errorData = [standardError.fileHandleForReading readDataToEndOfFile];

    // Command resulted in error
    if (errorData.length > 0) {

        NSString *description = [[NSString alloc] initWithData:errorData encoding:NSUTF8StringEncoding];

        *error = [NSError errorWithDomain:PHShebangPreprocessorErrorDomain
                                     code:PHShebangPreprocessorErrorCode
                                 userInfo:@{ NSLocalizedDescriptionKey: description }];
    }

    // Read past shebang #!
    [standardOutputFile readDataOfLength:2 + command.length];

    return [[NSString alloc] initWithData:[standardOutputFile readDataToEndOfFile] encoding:NSUTF8StringEncoding];
}

@end
