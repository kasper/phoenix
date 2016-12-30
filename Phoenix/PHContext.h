/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

@protocol PHContextDelegate <NSObject>

@property (readonly) NSString *primaryConfigurationPath;

#pragma mark - Loading

- (void) load;

#pragma mark - Terminating

- (void) shouldTerminate:(void (^)())terminate;

@end

@interface PHContext : NSObject <PHContextDelegate>

#pragma mark - Initialising

+ (instancetype) new NS_UNAVAILABLE;
+ (instancetype) context;

@end
