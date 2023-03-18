/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHStorage.h"

@interface PHStorage ()

@property(copy) NSString *path;
@property NSMutableDictionary<NSString *, id> *storage;
@property(getter=isPersisting) BOOL persisting;

@end

@implementation PHStorage

#if DEBUG
static NSString *const PHStoragePath = @"~/Library/Application Support/Phoenix/storage.debug.json";
#else
static NSString *const PHStoragePath = @"~/Library/Application Support/Phoenix/storage.json";
#endif

#pragma mark - Initialising

- (instancetype)init {
    if (self = [super init]) {
        self.path = PHStoragePath.stringByExpandingTildeInPath;
        self.storage = [NSMutableDictionary dictionary];
        [self load];
    }

    return self;
}

+ (instancetype)storage {
    return [[self alloc] init];
}

#pragma mark - Loading

- (void)load {
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

- (BOOL)ensureStorageDirectory {
    NSError *error;
    NSString *directory = self.path.stringByDeletingLastPathComponent;

    // Ensure storage directory exists
    [[NSFileManager defaultManager] createDirectoryAtPath:directory
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    if (error) {
        NSLog(@"Error: Could not create storage directory to path “%@”. (%@)", directory, error);
        return NO;
    }

    return YES;
}

- (void)persist {
    self.persisting = YES;

    if (![self ensureStorageDirectory]) {
        self.persisting = NO;
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

    self.persisting = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:PHStorageDidPersistNotification object:nil];
}

#pragma mark - Storing

- (void)forKey:(NSString *)key setObject:(id)object {
    if (![NSJSONSerialization isValidJSONObject:@[object]]) {
        NSLog(@"Error: Value for key “%@” is not a valid JSON-object.", key);
        return;
    }

    self.storage[key] = object;
    [self performSelectorInBackground:@selector(persist) withObject:nil];
}

- (id)objectForKey:(NSString *)key {
    return self.storage[key];
}

- (void)removeObjectForKey:(NSString *)key {
    [self.storage removeObjectForKey:key];
    [self performSelectorInBackground:@selector(persist) withObject:nil];
}

@end
