/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHAppDelegate.h"
#import "PHKeyHandler.h"
#import "PHNotification.h"
#import "PHPhoenix.h"

@implementation PHPhoenix

#pragma mark - Delegate

+ (PHAppDelegate *) delegate {

    return (PHAppDelegate *) [NSApplication sharedApplication].delegate;
}

#pragma mark - Actions

+ (void) reload {

    [[self delegate] reloadContext];
}

+ (PHKeyHandler *) bindKey:(NSString *)key modifiers:(NSArray *)modifiers callback:(JSValue *)callback {

    return [[self delegate] bindKey:key modifiers:modifiers callback:callback];
}

+ (void) log:(NSString *)message {

    NSLog(@"%@", message);
}

+ (void) notify:(NSString *)message {

    [PHNotification deliver:message];
}

@end
