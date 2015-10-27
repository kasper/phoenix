/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface PHScriptHelper : NSObject

#pragma mark - Script Preprocessing

+ (nullable NSString *)preprocessScriptIfNeeded:(nonnull NSString *)script atPath:(NSString * __nonnull)path errorMessage:(NSString * _Nullable * _Nonnull)errorMessage;

@end
