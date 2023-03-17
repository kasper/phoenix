/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@interface NSArray <ObjectType>(PHExtension)

#pragma mark - Iterating

- (ObjectType)nextFrom:(ObjectType)object;
- (ObjectType)previousFrom:(ObjectType)object;

@end
