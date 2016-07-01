/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@protocol PHContextDelegate <NSObject>

#pragma mark - Loading

- (void) load;

@end

@interface PHContext : NSObject <PHContextDelegate>

#pragma mark - Initialise

+ (instancetype) new NS_UNAVAILABLE;
+ (instancetype) context;

@end
