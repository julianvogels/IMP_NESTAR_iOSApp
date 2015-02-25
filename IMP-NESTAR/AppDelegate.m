//
//  AppDelegate.m
//  IMP-NESTAR
//
//  Created by Julian Vogels on 2/1/2014.
//  Copyright (c) 2014 Julian Vogels. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // force view class to load so it may be referenced directly from NIB
    [ZBarReaderView class];
    
    // UIPageControle design customisation
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    
    
    // Register the preference defaults early.
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstlaunch"]) {
        // subsequent launch
    } else {
        //first launch
        
        
        [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],@"firstLaunch",[NSNumber numberWithBool:NO], @"displayScanner", nil]];
    }

    
//    // check for Settings to enable the scanner
//    UITabBarController *tabController = (UITabBarController *)self.window.rootViewController;
//    NSLog(@"TAB BAR CONTROLLER COUNT: %lu", (unsigned long)[tabController.viewControllers count]);
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"displayScanner"]) {
//        if ([tabController.viewControllers count]==2) {
//            // scanner was removed, has to be added again
//            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle: nil];
//            UINavigationController *scannerController = [mainStoryboard instantiateViewControllerWithIdentifier:@"scannerNavigationController"];
//            NSMutableArray *tbViewControllers = [NSMutableArray arrayWithArray:[tabController viewControllers]];
//            [tbViewControllers insertObject:scannerController atIndex:1];
//            [tabController setViewControllers:tbViewControllers];
//        }
//    } else {
//        if ([tabController.viewControllers count]==3) {
//            // remove scanner
//            NSMutableArray *tbViewControllers = [NSMutableArray arrayWithArray:[tabController viewControllers]];
//            [tbViewControllers removeObjectAtIndex:1];
//            [tabController setViewControllers:tbViewControllers];
//        }
//    }
//    
//    // set tabbar to opaque (doen't seem to have any effect?)
//    [tabController.tabBar setOpaque:YES];
    
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
