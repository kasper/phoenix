/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

#import "PHHandler.h"
#import "PHIdentifiableJSExport.h"

static NSString * const PHKeyHandlerIdentifier = @"PHKeyHandlerIdentifier";
static NSString * const PHKeyHandlerKeyDownNotification = @"PHKeyHandlerKeyDownNotification";

@protocol PHKeyHandlerJSExport <JSExport, PHIdentifiableJSExport>

#pragma mark Exported Properties

@property (readonly) NSString *key;
@property (readonly) NSArray<NSString *> *modifiers;

#pragma mark - Binding

- (BOOL) isEnabled;
- (BOOL) enable;
- (BOOL) disable;

@end

@interface PHKeyHandler : PHHandler <PHKeyHandlerJSExport>

#pragma mark Properties

@property (readonly) UInt32 identifier;

#pragma mark - Initialise

- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initWithKey:(NSString *)key modifiers:(NSArray<NSString *> *)modifiers NS_DESIGNATED_INITIALIZER;

+ (instancetype) withKey:(NSString *)key modifiers:(NSArray<NSString *> *)modifiers;

#pragma mark - Hash

+ (NSUInteger) hashForKey:(NSString *)key modifiers:(NSArray<NSString *> *)modifiers;

@end
