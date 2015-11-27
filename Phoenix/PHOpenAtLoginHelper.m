/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHOpenAtLoginHelper.h"

@implementation PHOpenAtLoginHelper

#pragma mark - Shared File List

+ (LSSharedFileListRef) sharedFileList {

    static LSSharedFileListRef sharedFileList;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        sharedFileList = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    });

    return sharedFileList;
}

+ (id) fileItem {

    NSURL *appUrl = [NSBundle mainBundle].bundleURL;

    UInt32 seed;
    NSArray *sharedFileListItems = (NSArray *) CFBridgingRelease(LSSharedFileListCopySnapshot([self sharedFileList],
                                                                                              &seed));
    for (id item in sharedFileListItems) {

        CFErrorRef error = NULL;
        NSURL *url = (NSURL *) CFBridgingRelease(LSSharedFileListItemCopyResolvedURL((__bridge LSSharedFileListItemRef) item,
                                                                                     0,
                                                                                     &error));
        if (error) {
            NSLog(@"Error: Could not copy resolved URL for session login item %@. (%@)", item, (__bridge NSError *) error);
            CFRelease(error);
        }

        // Found ourself
        if ([appUrl isEqual:url]) {
            return item;
        }
    }

    return nil;
}

#pragma mark - Login Item

+ (BOOL) opensAtLogin {

    return [self fileItem] != nil;
}

+ (void) setOpensAtLogin:(BOOL)opensAtLogin {

    NSURL *appUrl = [NSBundle mainBundle].bundleURL;

    /* Add item */

    if (opensAtLogin) {

        CFBridgingRelease(LSSharedFileListInsertItemURL([self sharedFileList],
                                                        kLSSharedFileListItemLast,
                                                        NULL,
                                                        NULL,
                                                        (__bridge CFURLRef) appUrl,
                                                        NULL,
                                                        NULL));
        return;
    }

    /* Remove item */

    id fileItem = [self fileItem];
    OSStatus error = LSSharedFileListItemRemove([self sharedFileList], (__bridge LSSharedFileListItemRef) fileItem);

    if (error != noErr) {
        NSLog(@"Error: Could not remove item %@ from session login items. (%d)", fileItem, error);
    }
}

@end
