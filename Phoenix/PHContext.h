/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

@class PHKeyHandler;

@interface PHContext : NSObject

#pragma mark - Loading

- (void) load;

#pragma mark - Binding

- (PHKeyHandler *) bindKey:(NSString *)key modifiers:(NSArray *)modifiers callback:(JSValue *)callback;

#pragma mark - Events

- (void) keyDown:(UInt32)identifier;

@end
