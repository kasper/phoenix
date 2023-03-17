/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

#import "PHPreprocessor.h"

static NSInteger const PHShebangPreprocessorErrorCode = -1;
static NSString* const PHShebangPreprocessorErrorDomain = @"PHShebangPreprocessorErrorDomain";

@interface PHShebangPreprocessor : NSObject <PHPreprocessor>

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

@end
