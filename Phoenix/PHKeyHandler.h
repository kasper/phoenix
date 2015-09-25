/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

#import "PHIdentifiableJSExport.h"

typedef void (^PHKeyHandlerBlock)();

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

@interface PHKeyHandler : NSObject <PHKeyHandlerJSExport>

#pragma mark Properties

@property (readonly) UInt32 identifier;
@property (copy) PHKeyHandlerBlock handler;

#pragma mark - Initialise

+ (PHKeyHandler *) withKey:(NSString *)key
                 modifiers:(NSArray<NSString *> *)modifiers
                   handler:(PHKeyHandlerBlock)handler;

#pragma mark - Hash

+ (NSUInteger) hashForKey:(NSString *)key modifiers:(NSArray<NSString *> *)modifiers;

#pragma mark - Invoke

- (void) invoke;

@end
