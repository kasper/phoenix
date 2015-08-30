/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import JavaScriptCore;

@protocol PHIdentifiableJSExport <JSExport>

#pragma mark - Identifying

- (NSUInteger) hash;
- (BOOL) isEqual:(id)object;

@end
