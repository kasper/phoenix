/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

static NSString * const PHStorageDidPersistNotification = @"PHStorageDidPersistNotification";

@protocol PHStorageJSExport <JSExport>

#pragma mark - Storing

JSExportAs(set, - (void) forKey:(NSString *)key setObject:(id)object);
JSExportAs(get, - (id) objectForKey:(NSString *)key);
JSExportAs(remove, - (void) removeObjectForKey:(NSString *)key);

@end

@interface PHStorage : NSObject <PHStorageJSExport>

#pragma mark - Initialising

+ (instancetype) new NS_UNAVAILABLE;
+ (instancetype) storage;

#pragma mark - Persisting

- (BOOL) isPersisting;

@end
