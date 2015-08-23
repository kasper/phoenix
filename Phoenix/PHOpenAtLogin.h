/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface PHOpenAtLogin : NSObject

#pragma mark - Login Item

+ (BOOL) opensAtLogin;
+ (void) setOpensAtLogin:(BOOL)opensAtLogin;

@end
