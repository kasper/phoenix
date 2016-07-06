/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHStorage.h"

@interface PHStorage ()

@property (copy) NSString *path;
@property NSMutableDictionary<NSString *, id> *storage;

@end

@implementation PHStorage

#if DEBUG
static NSString * const PHStoragePath = @"~/Library/Application Support/Phoenix/storage-debug.json";
#else
static NSString * const PHStoragePath = @"~/Library/Application Support/Phoenix/storage.json";
#endif

#pragma mark - Initialising

- (instancetype) init {

    if (self = [super init]) {
        self.path = PHStoragePath.stringByExpandingTildeInPath;
        self.storage = [NSMutableDictionary dictionary];
        [self load];
    }

    return self;
}

+ (instancetype) storage {

    return [[self alloc] init];
}

#pragma mark - Loading

- (void) load {

    // No storage file to load
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.path]) {
        return;
    }

    NSError *error;
    NSInputStream *stream = [NSInputStream inputStreamWithFileAtPath:self.path];

    [stream open];
    id data = [NSJSONSerialization JSONObjectWithStream:stream options:0 error:&error];
    [stream close];

    if (error) {
        NSLog(@"Error: Loading storage failed. (%@)", error);
        return;
    }

    [self.storage addEntriesFromDictionary:data];
}

#pragma mark - Persisting

- (BOOL) ensureStorageDirectory {

    NSError *error;
    NSString *directory = self.path.stringByDeletingLastPathComponent;

    // Ensure storage directory exists
    [[NSFileManager defaultManager] createDirectoryAtPath:directory
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    if (error) {
        NSLog(@"Error: Could not create storage directory to path “%@”. (%@)", directory, error);
        return false;
    }

    return true;
}

- (void) persist {

    if (![self ensureStorageDirectory]) {
        return;
    }

    NSError *error;
    NSOutputStream *stream = [NSOutputStream outputStreamToFileAtPath:self.path append:NO];

    [stream open];
    [NSJSONSerialization writeJSONObject:self.storage toStream:stream options:NSJSONWritingPrettyPrinted error:&error];
    [stream close];

    if (error) {
        NSLog(@"Error: Persisting storage failed. (%@)", error);
    }
}

#pragma mark - Storing

- (void) setObject:(id)object forKey:(NSString *)key {

    self.storage[key] = object;
    [self persist];
}

- (id) objectForKey:(NSString *)key {

    return self.storage[key];
}

@end
