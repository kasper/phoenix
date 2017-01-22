/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface PHAXUIElement : NSObject

#pragma mark - Initialising

+ (instancetype) new NS_UNAVAILABLE;
- (instancetype) init NS_UNAVAILABLE;

- (instancetype) initWithElement:(id)element NS_DESIGNATED_INITIALIZER;

#pragma mark - System Accessors

+ (instancetype) elementForSystemAttribute:(NSString *)attribute;
+ (instancetype) elementAtPosition:(CGPoint)position;

#pragma mark - Element Accessors

- (pid_t) processIdentifier;
- (id) valueForAttribute:(NSString *)attribute;
- (id) valueForAttribute:(NSString *)attribute withDefaultValue:(id)defaultValue;
- (NSArray *) valuesForAttribute:(NSString *)attribute fromIndex:(NSUInteger)index count:(NSUInteger)count;

#pragma mark - Setters

- (BOOL) setAttribute:(NSString *)attribute withValue:(id)value;

#pragma mark - Actions

- (BOOL) performAction:(NSString *)action;

@end
