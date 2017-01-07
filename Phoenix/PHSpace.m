/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;

#import "NSArray+PHExtension.h"
#import "NSProcessInfo+PHExtension.h"
#import "NSScreen+PHExtension.h"
#import "PHSpace.h"
#import "PHWindow.h"

/* XXX: Undocumented private typedefs for CGSSpace */

typedef NSUInteger CGSConnectionID;
typedef NSUInteger CGSSpaceID;

typedef enum {

    kCGSSpaceIncludesCurrent = 1 << 0,
    kCGSSpaceIncludesOthers = 1 << 1,
    kCGSSpaceIncludesUser = 1 << 2,

    kCGSAllSpacesMask = kCGSSpaceIncludesCurrent | kCGSSpaceIncludesOthers | kCGSSpaceIncludesUser

} CGSSpaceMask;

typedef enum {

    kCGSSpaceUser,
    kCGSSpaceFullScreen = 4

} CGSSpaceType;

@interface PHSpace ()

@property CGSSpaceID identifier;

@end

@implementation PHSpace

static NSString * const CGSScreenIDKey = @"Display Identifier";
static NSString * const CGSSpaceIDKey = @"ManagedSpaceID";
static NSString * const CGSSpacesKey = @"Spaces";
static NSString * const PHWindowIDKey = @"identifier";

// XXX: Undocumented private API to get the CGSConnectionID for the default connection for this process
CGSConnectionID CGSMainConnectionID();

// XXX: Undocumented private API to get the CGSSpaceID for the active space
CGSSpaceID CGSGetActiveSpace(CGSConnectionID connection);

// XXX: Undocumented private API to get the CGSSpaceID for the current space for a given screen (UUID)
CGSSpaceID CGSManagedDisplayGetCurrentSpace(CGSConnectionID connection, CFStringRef screenId);

// XXX: Undocumented private API to get the CGSSpaceIDs for all spaces in order
CFArrayRef CGSCopyManagedDisplaySpaces(CGSConnectionID connection);

// XXX: Undocumented private API to get the CGSSpaceIDs for the given windows (CGWindowIDs)
CFArrayRef CGSCopySpacesForWindows(CGSConnectionID connection, CGSSpaceMask mask, CFArrayRef windowIds);

// XXX: Undocumented private API to get the CGSSpaceType for a given space
CGSSpaceType CGSSpaceGetType(CGSConnectionID connection, CGSSpaceID space);

// XXX: Undocumented private API to add the given windows (CGWindowIDs) to the given spaces (CGSSpaceIDs)
void CGSAddWindowsToSpaces(CGSConnectionID connection, CFArrayRef windowIds, CFArrayRef spaceIds);

// XXX: Undocumented private API to remove the given windows (CGWindowIDs) from the given spaces (CGSSpaceIDs)
void CGSRemoveWindowsFromSpaces(CGSConnectionID connection, CFArrayRef windowIds, CFArrayRef spaceIds);

#pragma mark - Initialising

- (instancetype) initWithIdentifier:(NSUInteger)identifier {

    if (self = [super init]) {
        self.identifier = identifier;
    }

    return self;
}

#pragma mark - Spaces

+ (instancetype) active {

    // Only supported from 10.11 upwards
    if (![NSProcessInfo isOperatingSystemAtLeastElCapitan]) {
        return nil;
    }

    return [(PHSpace *) [self alloc] initWithIdentifier:CGSGetActiveSpace(CGSMainConnectionID())];
}

+ (NSArray<PHSpace *> *) all {

    // Only supported from 10.11 upwards
    if (![NSProcessInfo isOperatingSystemAtLeastElCapitan]) {
        return @[];
    }

    NSMutableArray *spaces = [NSMutableArray array];
    NSArray *displaySpacesInfo = CFBridgingRelease(CGSCopyManagedDisplaySpaces(CGSMainConnectionID()));

    for (NSDictionary<NSString *, id> *spacesInfo in displaySpacesInfo) {

        NSArray<NSNumber *> *identifiers = [spacesInfo[CGSSpacesKey] valueForKey:CGSSpaceIDKey];

        for (NSNumber *identifier in identifiers) {
            [spaces addObject:[(PHSpace *) [self alloc] initWithIdentifier:identifier.unsignedLongValue]];
        }
    }

    return spaces;
}

+ (instancetype) currentSpaceForScreen:(NSScreen *)screen {

    // Only supported from 10.11 upwards
    if (![NSProcessInfo isOperatingSystemAtLeastElCapitan]) {
        return nil;
    }

    NSUInteger identifier = CGSManagedDisplayGetCurrentSpace(CGSMainConnectionID(),
                                                             (__bridge CFStringRef) [screen identifier]);

    return [(PHSpace *) [self alloc] initWithIdentifier:identifier];
}

+ (NSArray<PHSpace *> *) spacesForWindow:(PHWindow *)window {

    // Only supported from 10.11 upwards
    if (![NSProcessInfo isOperatingSystemAtLeastElCapitan]) {
        return @[];
    }

    NSMutableArray *spaces = [NSMutableArray array];
    NSArray<NSNumber *> *identifiers = CFBridgingRelease(CGSCopySpacesForWindows(CGSMainConnectionID(),
                                                                                 kCGSAllSpacesMask,
                                                                                 (__bridge CFArrayRef) @[ @([window identifier]) ]));
    for (PHSpace *space in [self all]) {

        NSNumber *identifier = @([space hash]);

        if ([identifiers containsObject:identifier]) {
            [spaces addObject:[(PHSpace *) [self alloc] initWithIdentifier:identifier.unsignedLongValue]];
        }
    }

    return spaces;
}

#pragma mark - Identifying

- (NSUInteger) hash {

    return self.identifier;
}

- (BOOL) isEqual:(id)object {

    return [object isKindOfClass:[PHSpace class]] && [self hash] == [object hash];
}

#pragma mark - PHIterableJSExport

- (instancetype) next {

    return [[PHSpace all] nextFrom:self];
}

- (instancetype) previous {

    return [[PHSpace all] previousFrom:self];
}

#pragma mark - Properties

- (BOOL) isNormal {

    return CGSSpaceGetType(CGSMainConnectionID(), self.identifier) == kCGSSpaceUser;
}

- (BOOL) isFullScreen {

    return CGSSpaceGetType(CGSMainConnectionID(), self.identifier) == kCGSSpaceFullScreen;
}

- (NSArray<NSScreen *> *) screens {

    if (![NSScreen screensHaveSeparateSpaces]) {
        return [NSScreen screens];
    }

    NSArray *displaySpacesInfo = CFBridgingRelease(CGSCopyManagedDisplaySpaces(CGSMainConnectionID()));

    for (NSDictionary<NSString *, id> *spacesInfo in displaySpacesInfo) {

        NSString *screenIdentifier = spacesInfo[CGSScreenIDKey];
        NSArray<NSNumber *> *identifiers = [spacesInfo[CGSSpacesKey] valueForKey:CGSSpaceIDKey];

        if ([identifiers containsObject:@(self.identifier)]) {
            return @[ [NSScreen screenForIdentifier:screenIdentifier] ];
        }
    }

    return @[];
}

#pragma mark - Windows

- (NSArray<PHWindow *> *) windows {

    return [PHWindow filteredWindowsUsingPredicateBlock:^BOOL (PHWindow *window,
                                                               __unused NSDictionary<NSString *, id> *bindings) {
        return [[window spaces] containsObject:self];
    }];
}

- (NSArray<PHWindow *> *) windows:(NSDictionary<NSString *, id> *)optionals {

    NSNumber *visibilityOption = optionals[PHWindowVisibilityOptionKey];

    // Filter based on visibility
    if (visibilityOption) {
        return [[self windows] filteredArrayUsingPredicate:[PHWindow isVisible:visibilityOption.boolValue]];
    }

    return [self windows];
}

- (void) addWindows:(NSArray<PHWindow *> *)windows {

    CGSAddWindowsToSpaces(CGSMainConnectionID(),
                          (__bridge CFArrayRef) [windows valueForKey:PHWindowIDKey],
                          (__bridge CFArrayRef) @[ @(self.identifier) ]);
}

- (void) removeWindows:(NSArray<PHWindow *> *)windows {

    CGSRemoveWindowsFromSpaces(CGSMainConnectionID(),
                               (__bridge CFArrayRef) [windows valueForKey:PHWindowIDKey],
                               (__bridge CFArrayRef) @[ @(self.identifier) ]);
}

@end
