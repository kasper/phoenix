/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHAlerts.h"
#import "PHAppDelegate.h"
#import "PHKeyHandler.h"
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

+ (void) alertWithMessage:(NSString *)message duration:(NSTimeInterval)duration {

    PHAlerts *alerts = [PHAlerts sharedAlerts];

    // Not a number
    if (isnan(duration)) {
        [alerts show:message];
        return;
    }

    [alerts show:message duration:duration];
}

+ (void) closeAlerts {

    [[PHAlerts sharedAlerts] closeAlerts];
}

@end
