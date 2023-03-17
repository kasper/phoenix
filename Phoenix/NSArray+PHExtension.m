/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

#import "NSArray+PHExtension.h"

@implementation NSArray (PHExtension)

#pragma mark - Iterating

- (id)nextFrom:(id)object {
    NSArray *objects = [NSArray arrayWithArray:self];
    NSUInteger nextIndex = [objects indexOfObject:object] + 1;

    // Last object, return first
    if (nextIndex == objects.count) {
        return objects.firstObject;
    }

    return objects[nextIndex];
}

- (id)previousFrom:(id)object {
    NSArray *objects = [NSArray arrayWithArray:self];
    NSInteger previousIndex = [objects indexOfObject:object] - 1;

    // First object, return last
    if (previousIndex == -1) {
        return objects.lastObject;
    }

    return objects[previousIndex];
}

@end
