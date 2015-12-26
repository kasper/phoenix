/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;
@import JavaScriptCore;

@protocol PHIterableJSExport <JSExport>

#pragma mark - Iteration

- (instancetype) next;
- (instancetype) previous;

@end
