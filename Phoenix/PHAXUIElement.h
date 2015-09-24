/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface PHAXUIElement : NSObject

#pragma mark - Initialise

- (instancetype) init NS_UNAVAILABLE;
- (instancetype) initWithElement:(id)element NS_DESIGNATED_INITIALIZER;

#pragma mark - Static Accessors

+ (instancetype) elementForSystemAttribute:(NSString *)attribute;

#pragma mark - Element Accessors

- (pid_t) processIdentifier;
- (id) valueForAttribute:(NSString *)attribute;
- (id) valueForAttribute:(NSString *)attribute withDefaultValue:(id)defaultValue;
- (NSArray *) valuesForAttribute:(NSString *)attribute fromIndex:(NSUInteger)index count:(NSUInteger)count;

#pragma mark - Setters

- (BOOL) setAttribute:(NSString *)attribute withValue:(id)value;

@end
