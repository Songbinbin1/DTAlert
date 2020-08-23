//
//  AppDelegate.m
//  DTAlert
//
//  Created by 宋彬彬 on 2020/7/21.
//  Copyright © 2020 宋彬彬. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.rootViewController = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]].instantiateInitialViewController;
    return YES;
}


#pragma mark - UISceneSession lifecycle


@end
