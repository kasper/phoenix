/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "NSTask+PHExtension.h"
#import "PHShebangPreprocessor.h"

@implementation PHShebangPreprocessor

#pragma mark - Scanning

+ (NSString *) scanCommand:(NSScanner *)scanner {

    // Shebang (#!) was not found
    if (![scanner scanString:@"#!" intoString:NULL]) {
        return nil;
    }

    NSString *command;
    [scanner scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:&command];

    return command;
}

#pragma mark - Preprocessing

+ (NSString *) process:(NSString *)script atPath:(NSString *)path error:(NSError **)error {

    NSScanner *scanner = [NSScanner scannerWithString:script];
    NSString *command = [self scanCommand:scanner];

    if (!command) {
        return script;
    }

    // Process
    NSError *taskError;
    NSString *output = [NSTask outputFromLaunchedTaskWithEnvironment:@{ @"PATH": [NSTask searchPath] }
                                                           arguments:@[ @"-c", [NSString stringWithFormat:@"%@ %@", command, path] ]
                                                               error:&taskError];
    if (taskError) {

        if (error) {
            *error = [NSError errorWithDomain:PHShebangPreprocessorErrorDomain
                                         code:PHShebangPreprocessorErrorCode
                                     userInfo:@{ NSLocalizedDescriptionKey: @"Preprocessing failed.",
                                                 NSUnderlyingErrorKey: taskError }];
        }

        return script;
    }

    // Remove shebang-directive if it is still present
    NSScanner *outputScanner = [NSScanner scannerWithString:output];
    [self scanCommand:outputScanner];

    return [output substringFromIndex:outputScanner.scanLocation];
}

@end
