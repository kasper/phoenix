/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
@import JavaScriptCore;

@class PHApp;
@class PHSpace;
@class PHWindow;

#import "PHAXUIElement.h"
#import "PHIdentifiableJSExport.h"

static NSString * const PHWindowVisibilityOptionKey = @"visible";

@protocol PHWindowJSExport <JSExport, PHIdentifiableJSExport>

#pragma mark - Exported Windows

+ (instancetype) focused;
+ (instancetype) at:(CGPoint)point;
+ (NSArray<PHWindow *> *) all:(NSDictionary<NSString *, id> *)optionals;
+ (NSArray<PHWindow *> *) recent;

- (NSArray<PHWindow *> *) others:(NSDictionary<NSString *, id> *)optionals;

#pragma mark - Exported Properties

- (NSString *) title;
- (BOOL) isMain;
- (BOOL) isNormal;
- (BOOL) isFullScreen;
- (BOOL) isMinimized;
- (BOOL) isVisible;
- (PHApp *) app;
- (NSScreen *) screen;
- (NSArray<PHSpace *> *) spaces;

#pragma mark - Position and Size

- (CGPoint) topLeft;
- (CGSize) size;
- (CGRect) frame;
- (BOOL) setTopLeft:(CGPoint)point;
- (BOOL) setSize:(CGSize)size;
- (BOOL) setFrame:(CGRect)frame;
- (BOOL) setFullScreen:(BOOL)value;
- (BOOL) maximize;
- (BOOL) minimize;
- (BOOL) unminimize;

#pragma mark - Alignment

- (NSArray<PHWindow *> *) neighbors:(NSString *)direction;

#pragma mark - Focusing

- (BOOL) raise;
- (BOOL) focus;
- (BOOL) focusClosestNeighbor:(NSString *)direction;

@end

@interface PHWindow : PHAXUIElement <PHWindowJSExport>

#pragma mark - Predicates

+ (NSPredicate *) isVisible:(BOOL)visible;

#pragma mark - Windows

+ (NSArray<PHWindow *> *) filteredWindowsUsingPredicateBlock:(BOOL (^)(PHWindow *window, NSDictionary<NSString *, id> *bindings))block;

#pragma mark - Properties

- (CGWindowID) identifier;

@end
