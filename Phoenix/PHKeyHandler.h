/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Cocoa;
@import JavaScriptCore;

#import "PHIdentifiableJSExport.h"

typedef void (^PHKeyHandlerBlock)();

@protocol PHKeyHandlerJSExport <JSExport, PHIdentifiableJSExport>

#pragma mark Exported Properties

@property (readonly) NSString *key;
@property (readonly) NSArray *modifiers;
@property BOOL enabled;

@end

@interface PHKeyHandler : NSObject <PHKeyHandlerJSExport>

#pragma mark Properties

@property BOOL enabled;

#pragma mark - Initialise

+ (PHKeyHandler *) withKey:(NSString *)key modifiers:(NSArray *)modifiers handler:(PHKeyHandlerBlock)handler;

#pragma mark - Hash

+ (NSUInteger) hashForKey:(NSString *)key modifierFlags:(NSEventModifierFlags)flags;

#pragma mark - Invoke

- (void) invoke;

@end
