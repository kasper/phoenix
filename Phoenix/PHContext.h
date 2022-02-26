/*
 * Phoenix is released under the MIT License. Refer to https://github.com/kasper/phoenix/blob/master/LICENSE.md
 */

@import Foundation;

static NSString * const PHContextWillLoadNotification = @"PHContextWillLoadNotification";

@protocol PHContextDelegate <NSObject>

#pragma mark - Loading

- (void) load;

#pragma mark - Terminating

- (void) shouldTerminate:(void (^)(void))terminate;

@end

@interface PHContext : NSObject <NSUserNotificationCenterDelegate, PHContextDelegate>

@property (readonly) NSString *primaryConfigurationPath;

#pragma mark - Initialising

+ (instancetype) new NS_UNAVAILABLE;
+ (instancetype) context;

@end
