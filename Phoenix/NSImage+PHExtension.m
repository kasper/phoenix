/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "NSImage+PHExtension.h"

@implementation NSImage (PHExtension)

#pragma mark - Initialising

+ (instancetype) fromFile:(NSString *)path {

    NSString *resolvedPath = path.stringByResolvingSymlinksInPath;

    if (![[NSFileManager defaultManager] fileExistsAtPath:resolvedPath]) {
        NSLog(@"Warning: Trying to initialise an image from a non-existent path “%@”.", resolvedPath);
    }

    return [[self alloc] initWithContentsOfFile:resolvedPath];
}

@end
