/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHScriptHelper.h"

@implementation PHScriptHelper

#pragma mark - Script Preprocessing

+ (NSString * __nullable)preprocessScriptIfNeeded:(NSString * __nonnull)script atPath:(NSString * __nonnull)path {
    
    NSScanner *scanner = [NSScanner scannerWithString:script];
    
    /* Return early if no shebang "#!" */
    if (![scanner scanString:@"#!" intoString:NULL]) {
        return script;
    }
    
    NSString *preprocessCommand;
    [scanner scanUpToCharactersFromSet:[NSCharacterSet newlineCharacterSet] intoString:&preprocessCommand];
    
    NSPipe *stdoutPipe = [NSPipe pipe];
    NSPipe *stderrPipe = [NSPipe pipe];
    
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/sh"];
    [task setStandardOutput:stdoutPipe];
    [task setStandardError:stderrPipe];
    
    [task setArguments:@[@"-c", [NSString stringWithFormat:@"%@ %@", preprocessCommand, path]]];
    
    NSFileHandle *stdoutFile = [stdoutPipe fileHandleForReading];
    NSFileHandle *stderrFile = [stderrPipe fileHandleForReading];
    [task launch];
    
    /* Log any stderr output to Console */
    NSString *errorMessage = [[NSString alloc] initWithData:[stderrFile readDataToEndOfFile] encoding:NSUTF8StringEncoding];
    if (errorMessage.length > 0) {
        NSLog(@"Preprocessor error output: %@", errorMessage);
    }
    
    /* Read past the shebang line to prevent syntax error */
    [stdoutFile readDataOfLength:2 + preprocessCommand.length];
    
    return [[NSString alloc] initWithData:[stdoutFile readDataToEndOfFile] encoding:NSUTF8StringEncoding];
}

@end
