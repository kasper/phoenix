/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

@class PHKeyHandler;

@protocol PHContextDelegate <NSObject>

#pragma mark - Loading

- (void) load;

#pragma mark - Binding

- (PHKeyHandler *) bindKey:(NSString *)key modifiers:(NSArray *)modifiers callback:(JSValue *)callback;

@end

@interface PHContext : NSObject <PHContextDelegate>

@end
