//
//  AppDelegate.m
//  GasAll
//
//  Created by Álvaro Balbontín Gutiérrez on 31/12/13.
//  Copyright (c) 2013 Mobivery. All rights reserved.
//

#import "AppDelegate.h"
#import "MalcomLib.h"
#import "HockeySDK.h"
#import "MVYDefines.h"
#import "MainViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [MalcomLib initWithUUID:kMalcomUUID
    					 andSecretKey:kMalcomSecretKey
    					     withAdId:kMalcomAdId];
    [MalcomLib initAndStartBeacon:NO];

    #if DEBUG
    	[MalcomLib showLog:NO];
    #endif

    [MalcomLib loadConfiguration:nil withDelegate:nil withSplash:NO];
    
    #if DISTRIBUTION
    	[MalcomLib startNotifications:application withOptions:launchOptions isDevelopmentMode:NO];
    #else
    	[MalcomLib startNotifications:application withOptions:launchOptions isDevelopmentMode:YES];
    #endif
    
    #if DEBUG
    	[[BITHockeyManager sharedHockeyManager] configureWithBetaIdentifier:kHockeyAppBetaIdentifier
                                                             liveIdentifier:kHockeyAppBetaLiveIdentifier
                                                                   delegate:nil];
    	[[BITHockeyManager sharedHockeyManager] startManager];
    #endif
    
    MainViewController *mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.rootViewController = self.navigationController;
	[self.window makeKeyAndVisible];
    
	return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [MalcomLib setAppActive:NO];
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
    [MalcomLib setAppActive:YES];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
								
    [MalcomLib didRegisterForRemoteNotificationsWithDeviceToken:devToken];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
								
    [MalcomLib didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
								
    [MalcomLib didReceiveRemoteNotification:userInfo active:[MalcomLib getAppActive]];
}

@end
