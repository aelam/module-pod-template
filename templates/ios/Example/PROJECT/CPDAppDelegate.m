//
//  CPDAppDelegate.m
//  PROJECT
//
//  Created by PROJECT_OWNER on TODAYS_DATE.
//  Copyright (c) TODAYS_YEAR PROJECT_OWNER. All rights reserved.
//

#import "CPDAppDelegate.h"
#import <MSAppModuleKit/MSAppModuleKit.h>
#import <PROJECT/PROJECT.h>
#import "EMAppSettings.h"
#import <MSRoutes/MSActiveControllerFinder.h>

@implementation CPDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupModule];
    return YES;
}

- (void)setupModule {
    //
    [MSActiveControllerFinder setFinder:[MSActiveControllerFinder new]];

    /* 读取系统配置 */
    EMAppSettings *appSettings = [EMAppSettings appSettings];
    /* 初始化appModuleController 并加载设置进去 */
    [MSAppModuleController appModuleControllerWithSettings:appSettings];
    [appModuleManager addModule:[PROJECT new]];

}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [[UIApplication sharedApplication] registerForRemoteNotifications];

    [appModuleManager applicationDidRegisterUserNotificationSettings:notificationSettings];

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [appModuleManager applicationDidReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    NSLog(@"devToken = %@", devToken);

    [appModuleManager applicationDidRegisterForRemoteNotificationsWithDeviceToken:devToken];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    [appModuleManager applicationDidFailToRegisterForRemoteNotificationsWithError:err];

    NSLog(@"didFailToRegisterForRemoteNotificationsWithError:%@", [NSString stringWithFormat:@"Error: %@", err]);
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
