/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface PHScriptHelper : NSObject

#pragma mark - Script Preprocessing

+ (NSString * __nullable)preprocessScriptIfNeeded:(NSString * __nonnull)script atPath:(NSString * __nonnull)path;

@end
