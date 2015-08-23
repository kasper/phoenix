/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "PHAXUIElement.h"

@interface PHAXUIElement ()

@property AXUIElementRef element;

@end

@implementation PHAXUIElement

#pragma mark - Static Accessors

+ (AXUIElementRef) systemWideElement {

    static AXUIElementRef systemWideElement;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        systemWideElement = AXUIElementCreateSystemWide();
    });

    return systemWideElement;
}

+ (id) getValueForAttribute:(NSString *)attribute forElement:(id)element {

    CFTypeRef value = NULL;
    AXUIElementCopyAttributeValue((__bridge AXUIElementRef) element, (__bridge CFStringRef) attribute, &value);

    return CFBridgingRelease(value);
}

+ (id) getValueForSystemAttribute:(NSString *)attribute {

    return [PHAXUIElement getValueForAttribute:attribute forElement:(__bridge id) [PHAXUIElement systemWideElement]];
}

#pragma mark - Element Accessors

- (pid_t) processIdentifier {

    pid_t processIdentifier;
    AXError error = AXUIElementGetPid(self.element, &processIdentifier);

    if (error != kAXErrorSuccess) {
        NSLog(@"Error: Could not get process identifier for accessibility element %@. (%d)", self.element, error);
    }

    return processIdentifier;
}

- (id) getValueForAttribute:(NSString *)attribute {

    return [PHAXUIElement getValueForAttribute:attribute forElement:(__bridge id) self.element];
}

- (id) getValueForAttribute:(NSString *)attribute withDefaultValue:(id)defaultValue {

    id value = [self getValueForAttribute:attribute];

    if (value) {
        return value;
    }

    return defaultValue;
}

- (NSArray *) getValuesForAttribute:(NSString *)attribute fromIndex:(NSUInteger)index count:(NSUInteger)count {

    CFArrayRef values = NULL;
    AXUIElementCopyAttributeValues(self.element, (__bridge CFStringRef) attribute, index, count, &values);

    return CFBridgingRelease(values);
}

#pragma mark - Setters

- (BOOL) setAttribute:(NSString *)attribute withValue:(id)value {

    AXError error = AXUIElementSetAttributeValue(self.element,
                                                 (__bridge CFStringRef) attribute,
                                                 (__bridge CFTypeRef) value);

    if (error != kAXErrorSuccess) {
        NSLog(@"Error: Could not set accessibility attribute %@ with value %@ for element %@. (%d)", attribute, value, self.element, error);
    }

    return error == kAXErrorSuccess;
}

@end
