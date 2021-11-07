/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import ApplicationServices;

#import "PHAXUIElement.h"

@interface PHAXUIElement ()

// AXUIElementRef
@property id element;

@end

@implementation PHAXUIElement

#pragma mark - Initialising

- (instancetype) initWithElement:(id)element {

    if (self = [super init]) {
        self.element = element;
        AXUIElementSetMessagingTimeout((__bridge AXUIElementRef) self.element, 0.5);
    }

    return self;
}

#pragma mark - System Accessors

+ (instancetype) systemWideElement {

    static id systemWideElement;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        systemWideElement = [[self alloc] initWithElement:CFBridgingRelease(AXUIElementCreateSystemWide())];
    });

    return systemWideElement;
}

+ (instancetype) elementForSystemAttribute:(NSString *)attribute {

    id element = [[self systemWideElement] valueForAttribute:attribute];
    return [[self alloc] initWithElement:element];
}

+ (instancetype) elementAtPosition:(CGPoint)position {

    PHAXUIElement *systemWideElement = [self systemWideElement];

    AXUIElementRef element = NULL;
    AXError error = AXUIElementCopyElementAtPosition((__bridge AXUIElementRef) systemWideElement.element,
                                                     position.x,
                                                     position.y,
                                                     &element);
    if (error != kAXErrorSuccess) {
        NSLog(@"Error: Could not get accessibility element at position %@. (%d)", NSStringFromPoint(position), error);
    }

    return [[self alloc] initWithElement:CFBridgingRelease(element)];
}

#pragma mark - Identifying

- (NSUInteger) hash {

    return [self.element hash];
}

- (BOOL) isEqualTo:(PHAXUIElement *)object {

    return [self.element isEqual:object.element];
}

- (BOOL) isEqual:(id)object {

    return [object isKindOfClass:[PHAXUIElement class]] && [self isEqualTo:object];
}

#pragma mark - Element Accessors

- (pid_t) processIdentifier {

    pid_t processIdentifier;
    AXError error = AXUIElementGetPid((__bridge AXUIElementRef) self.element, &processIdentifier);

    if (error != kAXErrorSuccess) {
        NSLog(@"Error: Could not get process identifier for accessibility element %@. (%d)", self.element, error);
    }

    return processIdentifier;
}

- (id) valueForAttribute:(NSString *)attribute {

    CFTypeRef value = NULL;
    AXError error = AXUIElementCopyAttributeValue((__bridge AXUIElementRef) self.element, (__bridge CFStringRef) attribute, &value);

    if (error != kAXErrorSuccess) {
        NSLog(@"Info: Could not get value for attribute “%@” from element %@. (%d)", attribute, self.element, error);
    }

    return CFBridgingRelease(value);
}

- (id) valueForAttribute:(NSString *)attribute withDefaultValue:(id)defaultValue {

    id value = [self valueForAttribute:attribute];

    if (value) {
        return value;
    }

    return defaultValue;
}

- (NSArray *) valuesForAttribute:(NSString *)attribute fromIndex:(NSUInteger)index count:(NSUInteger)count {

    CFArrayRef values = NULL;
    AXUIElementCopyAttributeValues((__bridge AXUIElementRef) self.element,
                                   (__bridge CFStringRef) attribute,
                                   index,
                                   count,
                                   &values);

    return CFBridgingRelease(values);
}

#pragma mark - Setters

- (BOOL) setAttribute:(NSString *)attribute withValue:(id)value {

    AXError error = AXUIElementSetAttributeValue((__bridge AXUIElementRef) self.element,
                                                 (__bridge CFStringRef) attribute,
                                                 (__bridge CFTypeRef) value);

    if (error != kAXErrorSuccess) {
        NSLog(@"Error: Could not set accessibility attribute “%@” with value “%@” for element %@. (%d)", attribute, value, self.element, error);
    }

    return error == kAXErrorSuccess;
}

#pragma mark - Actions

- (BOOL) performAction:(NSString *)action {

    AXError error = AXUIElementPerformAction((__bridge AXUIElementRef) self.element, (__bridge CFStringRef) action);

    if (error != kAXErrorSuccess) {
        NSLog(@"Error: Could not perform action “%@” for element %@. (%d)", action, self.element, error);
    }

    return error == kAXErrorSuccess;
}

@end
