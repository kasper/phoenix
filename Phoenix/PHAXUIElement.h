/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface PHAXUIElement : NSObject

#pragma mark - Static Accessors

+ (id) getValueForAttribute:(NSString *)attribute forElement:(id)element;
+ (id) getValueForSystemAttribute:(NSString *)attribute;

#pragma mark - Initialise

- (instancetype) initWithElement:(id)element NS_DESIGNATED_INITIALIZER;

#pragma mark - Element Accessors

- (pid_t) processIdentifier;
- (id) getValueForAttribute:(NSString *)attribute;
- (id) getValueForAttribute:(NSString *)attribute withDefaultValue:(id)defaultValue;
- (NSArray *) getValuesForAttribute:(NSString *)attribute fromIndex:(NSUInteger)index count:(NSUInteger)count;

#pragma mark - Setters

- (BOOL) setAttribute:(NSString *)attribute withValue:(id)value;

@end
