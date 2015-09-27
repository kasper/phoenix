/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

@class PHEventHandler;
@class PHKeyHandler;

@protocol PHContextDelegate <NSObject>

#pragma mark - Loading

- (void) load;

#pragma mark - Binding

- (PHKeyHandler *) bindKey:(NSString *)key modifiers:(NSArray<NSString *> *)modifiers callback:(JSValue *)callback;
- (PHEventHandler *) bindEvent:(NSString *)event callback:(JSValue *)callback;

@end

@interface PHContext : NSObject <PHContextDelegate>

@end
