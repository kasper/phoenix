//
//  LVPathWatcher.h
//  Leviathan
//
//  Created by Steven Degutis on 11/6/13.
//  Copyright (c) 2013 Steven Degutis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PHPathWatcher : NSObject

+ (PHPathWatcher*) watcherFor:(NSArray*)paths handler:(void(^)())handler;

@end
