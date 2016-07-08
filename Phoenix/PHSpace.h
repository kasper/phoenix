/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

@class PHSpace;
@class PHWindow;

#import "PHIdentifiableJSExport.h"
#import "PHIterableJSExport.h"

@protocol PHSpaceJSExport <JSExport, PHIdentifiableJSExport, PHIterableJSExport>

#pragma mark - Exported Spaces

+ (instancetype) active;
+ (NSArray<PHSpace *> *) spaces;

#pragma mark - Properties

- (BOOL) isNormal;
- (BOOL) isFullScreen;
- (NSScreen *) screen;

#pragma mark - Windows

- (NSArray<PHWindow *> *) windows;
- (NSArray<PHWindow *> *) visibleWindows;
- (void) addWindows:(NSArray<PHWindow *> *)windows;
- (void) removeWindows:(NSArray<PHWindow *> *)windows;

@end

@interface PHSpace : NSObject <PHSpaceJSExport>

#pragma mark - Initialising

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;

- (instancetype) initWithIdentifier:(NSUInteger)identifier NS_DESIGNATED_INITIALIZER;

#pragma mark - Spaces

+ (NSArray<PHSpace *> *) spacesForWindow:(PHWindow *)window;

@end
