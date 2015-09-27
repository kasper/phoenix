/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "PHEventTranslator.h"

@implementation PHEventTranslator

static NSDictionary<NSString *, NSString *> *PHStringToNotification;

#pragma mark - Initialise

+ (void) initialize {

    /* Notifications */

    PHStringToNotification = @{ /* Screen Notifications */

                               @"screenchange": NSApplicationDidChangeScreenParametersNotification // screenChange

                              };
}

#pragma mark - Translate

+ (NSString *) notificationForString:(NSString *)string {

    return PHStringToNotification[string];
}

@end
