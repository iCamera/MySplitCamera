//
//  ISLAppDelegate.m
//  MySplitCamera
//
//  Created by alvin zheng on 5/29/13.
//  Copyright (c) 2013 alvin zheng. All rights reserved.
//

#import "ISLAppDelegate.h"
#import "ISLRootViewController.h"
@interface ISLAppDelegate ()


@property ISLRootViewController  *rootviewController;

//@property (strong, nonatomic) UINavigationController *navigationController;
@end


@implementation ISLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.rootviewController = [[ISLRootViewController alloc]init];
    //self.rootviewController.title = @"SplitCamera";
    
    self.navigationController =[[UINavigationController alloc]init];
    [self.navigationController pushViewController:self.rootviewController animated:YES];
    [self.window addSubview:self.navigationController.view];
    //self.rootviewController = [[ISLRootViewController alloc]initWithNibName:@"ISLRootViewController" bundle:nil];
    //UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:self.rootviewController];
    //self.window.backgroundColor = [UIColor whiteColor];
    
    //self.window.rootViewController = self.rootviewController;
    [self.window makeKeyAndVisible];
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
