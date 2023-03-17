/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

#import "PHHandler.h"
#import "PHIdentifiableJSExport.h"

@protocol PHKeyHandlerJSExport <JSExport, PHIdentifiableJSExport>

@property(readonly) NSString *key;
@property(readonly) NSArray<NSString *> *modifiers;

#pragma mark - Constructing

- (instancetype)initWithKey:(NSString *)key modifiers:(NSArray<NSString *> *)modifiers callback:(JSValue *)callback;

#pragma mark - Binding

- (BOOL)isEnabled;
- (BOOL)enable;
- (BOOL)disable;

@end

@interface PHKeyHandler : PHHandler <PHKeyHandlerJSExport>

#pragma mark - Initialising

- (instancetype)initWithKey:(NSString *)key
                  modifiers:(NSArray<NSString *> *)modifiers
                   callback:(JSValue *)callback NS_DESIGNATED_INITIALIZER;

@end
