//
//  AppDelegate.m
//  VenuFest
//
//  Created by Sayan Chatterjee on 04/12/16.
//  Copyright © 2016 Sayan Chatterjee. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleSignIn/GoogleSignIn.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize userLoggedIN = _userLoggedIN;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"user_first_time_login"] ) {
        
        self.isuserLoggedinFirstTime = [[[NSUserDefaults standardUserDefaults] valueForKey:@"user_first_time_login"] boolValue];
    }
    else
        self.isuserLoggedinFirstTime = YES;
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"user_loggedIn"] boolValue]) {
        
        [AppManager sharedDataAccess].IsLoggedIn = YES; 
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

    if ([AppManager sharedDataAccess].IsLoggedIn) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:[AppManager sharedDataAccess].IsLoggedIn]  forKey:@"user_loggedIn"];
    }
    if (!self.isuserLoggedinFirstTime) {
        
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:self.isuserLoggedinFirstTime]  forKey:@"user_first_time_login"];

    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation{
    
    BOOL success = NO;
    if ([[url scheme] isEqualToString:FACEBOOK_API_CALLBACK_URL_SCHEME]){
        success = [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
    else if ([[[url scheme] lowercaseString] isEqualToString:[GOOGLE_PLUS_REVERSED_CLIENT_ID lowercaseString]]){
        success =  [[GIDSignIn sharedInstance] handleURL:url sourceApplication:sourceApplication
                                          annotation:annotation];
    }
    
    
    return success;
}


@end
