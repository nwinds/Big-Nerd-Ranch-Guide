//
//  BNRAppDelegate.m
//  Hypnosister
//
//  Created by John Gallagher on 1/6/14.
//  Copyright (c) 2014 John Gallagher. All rights reserved.
//

#import "BNRAppDelegate.h"
#import "BNRHypnosisView.h"
#import "BNRHypnosisViewController.h"
#import "BNRReminderViewController.h"
@implementation BNRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Intitialization after app started
    BNRHypnosisViewController *hvc = [[BNRHypnosisViewController alloc] init];

//    NSBundle *appBundle = [NSBundle mainBundle];
    
    BNRReminderViewController *rvc = [[BNRReminderViewController alloc] init];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[hvc, rvc];
    

    self.window.rootViewController = tabBarController;
    
//    // Create two CGRect structs, for UIScrollView and BNRHypnosisView
//    CGRect screenRect = self.window.bounds;
//    CGRect bigRect = screenRect;
//    bigRect.size.width *= 2.0;
////    bigRect.size.height *= 2.0;
//    
//    
//    
//    // Create an UIScrollView object, set its size as window size
//    // Simply code is not easy to manage!
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:screenRect];
//    [scrollView setPagingEnabled:YES];
//    [self.window addSubview:scrollView];
//    
//    
////    // Paging
////    BNRHypnosisView *hypnosisView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
////    [scrollView addSubview:hypnosisView];
////    
////    // Create another BNRHypnosisView object and add it to UIScrollView' right side, making it exactly moved outside the screen
////    screenRect.origin.x += screenRect.size.width;                       // Move it JUST outside
////    BNRHypnosisView *anotherView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
////    [scrollView addSubview:anotherView];
////    
//    
//    // Play time
//    // Paging: make three
//    NSMutableArray *pagesView = [[NSMutableArray alloc] init];
//    for (int i = 0; i < 3; i++) {
//        BNRHypnosisView *item = [[BNRHypnosisView alloc] initWithFrame:screenRect];
//        [pagesView addObject:item];
//        screenRect.origin.x += screenRect.size.width;
//    }
//    for (BNRHypnosisView *item in pagesView) {
//        [scrollView addSubview:item];
//    }
//    
//    // Reset bigRect, otherwise the 3rd page cannot be focused to the camera
//    bigRect = screenRect;
//    bigRect.size.width *= 3.0;
//    
//    
//    
//    
//    scrollView.contentSize = bigRect.size;
//    
//    
    
    self.window.backgroundColor = [UIColor whiteColor];
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
