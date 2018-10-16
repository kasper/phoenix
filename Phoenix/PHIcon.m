/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHIcon.h"

@interface PHIcon ()

@end

@implementation PHIcon

+ (NSImage *) set:(NSImage*)anImage Width:(int)newWidth AndHeight:(int)newHeight {
    NSImage *sourceImage = anImage;
    
    // Report an error if the source isn't a valid image
    if (![sourceImage isValid]){
        NSLog(@"Invalid Image");
    } else {
        NSSize newSize;
        newSize.width = newWidth;
        newSize.height = newHeight;
        NSImage *smallImage = [[NSImage alloc] initWithSize: newSize];
        [smallImage lockFocus];
        NSImage* copy = sourceImage.copy;
        [copy setSize: newSize];
        [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
        [copy drawAtPoint:NSZeroPoint fromRect:CGRectMake(0, 0, newSize.width, newSize.height) operation:NSCompositeCopy fraction:1.0];
        [smallImage unlockFocus];
        return smallImage;
    }
    return nil;
}

+ (NSImage *) getFromFile:(NSString *)path withWidth:(int) width {
    NSImage* icon = [[NSImage alloc]initWithContentsOfFile:path];
    double ratio = icon.size.width / icon.size.height;
    int height = width*ratio;
    return [self set:icon Width:width AndHeight:height];
}

+ (NSImage *) getFromFile:(NSString *)path withHeight:(int) height {
    NSImage* icon = [[NSImage alloc]initWithContentsOfFile:path];
    double ratio = icon.size.width / icon.size.height;
    int width = height/ratio;
    return [self set:icon Width:width AndHeight:height];
}

+ (NSImage *) getFromFile:(NSString *)path {
    NSImage* icon = [[NSImage alloc]initWithContentsOfFile:path];
    return icon;
}

@end
