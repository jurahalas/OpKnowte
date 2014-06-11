//
//  OKAppDelegate.m
//  OpKnowte
//
//  Created by Eugene on 09.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//


#define DELEGATE ((OKAppDelegate*)[[UIApplication sharedApplication] delegate])

#import "OKAppDelegate.h"
#import "OKTimer.h"
#import "OKViewController.h"
#import "OKBaseProcedureVC.h"

@implementation OKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidTimeout:) name:kApplicationDidTimeoutNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ofTimeAlert:) name:@"allertTime" object:nil];

    if (IS_IOS7) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbarBG"] forBarMetrics:UIBarMetricsDefault ];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        
        NSDictionary *navbarTitleProperties = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"AvenirNext-DemiBold" size:17.0f], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
        [[UINavigationBar appearance] setTitleTextAttributes: navbarTitleProperties];
    }
    else{
       [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbarBG6"] forBarMetrics:UIBarMetricsDefault ];
        
        [[UINavigationBar appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"AvenirNextBold" size:10.f], nil]];
    }
    
    [self restoreCurrentUser];
    
    return YES;
}

-(void)applicationDidTimeout:(NSNotification *) notif
{    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"user"];
    [defaults synchronize];
    [OKUserManager instance].currentUser = nil;

    OKBaseProcedureVC * vc = [[OKBaseProcedureVC alloc]init];
    vc.alertBMI = nil;
    vc.alertTime = nil;
    
    UIViewController *controller = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:NULL] instantiateViewControllerWithIdentifier:@"LoginView"];
    [(UINavigationController *)self.window.rootViewController pushViewController:controller animated:YES];
    [self.window endEditing:YES];
}

-(void)ofTimeAlert:(NSNotification *) no{

}

-(void)restoreCurrentUser
{
    NSData *encodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    OKUserModel *user = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    [OKUserManager instance].currentUser = user;
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
    [self.window endEditing:YES];
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

- (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
}


- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}


@end
