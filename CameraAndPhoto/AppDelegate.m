
//  AppDelegate.m
//  CameraAndPhoto
//
//  Created by wststar on 14-4-11.
//  Copyright (c) 2014年 wststar. All rights reserved.
//

#import "AppDelegate.h"
#import "CameraUtil.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if ([CameraUtil isFrontCameraAvailable]){
        NSLog(@"The front camera is available.");
        if ([CameraUtil isFlashAvailableOnFrontCamera]){
            NSLog(@"The front camera is equipped with a flash");//前置摄头装备了闪光灯
        }else{
            NSLog(@"The front camera is not equipped with a flash");
        }
    }else{
        NSLog(@"The front camera is not available.");
    }
    
    if ([CameraUtil isRearCameraAvailable]){
        NSLog(@"The rear camera is available.");
        if ([CameraUtil isFlashAvailableOnRearCamera]){
            NSLog(@"The rear camera is equipped with a flash");
        }else{
            NSLog(@"The rear camera is not equipped with a flash");
        }
    }else{
        NSLog(@"The rear camera is not available.");
    }
    
    if ([CameraUtil doesCameraSupportTakingPhotos]){
        NSLog(@"The camera supports taking photos.");
    }else{
        NSLog(@"The camera does not support taking photos");
    }
    
    if ([CameraUtil doesCameraSupportShootingVideos]){
        NSLog(@"The camera supports shooting videos.");
    }else{
        NSLog(@"The camera does not support shooting videos.");
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
