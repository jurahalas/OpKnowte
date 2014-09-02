//
//  OKAppDelegate.m
//  OpKnowte
//
//  Created by Eugene on 09.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//


#import "OKAppDelegate.h"
#import "OKTimer.h"
#import "OKViewController.h"
#import "OKBaseProcedureVC.h"
#import "OKLRPartialNephrectomyModel.h"
#import "OKOngoingClinicalViewController.h"
#import "OKTimePointsManager.h"

@implementation OKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidTimeout:) name:kApplicationDidTimeoutNotification object:nil];

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
    self.fromUrl = NO;
    
    [self restoreCurrentUser];
    return YES;
}

-(void)applicationDidTimeout:(NSNotification *) notif
{    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"user"];
    [defaults synchronize];
    [OKUserManager instance].currentUser = nil;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"offAlertBMI" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"offTimeAlert" object:nil];
    
    UIViewController *controller = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:NULL] instantiateViewControllerWithIdentifier:@"LoginView"];
    [(UINavigationController *)self.window.rootViewController pushViewController:controller animated:YES];
    [self.window endEditing:YES];
    

    
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


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"%@",url];
    NSLog(@"%@",[urlString lowercaseString]);
    if ([[urlString lowercaseString] isEqualToString:@"opknowte://enterpatientsdetails"]){
        NSLog(@":p");
    }else{
        NSArray *components = [urlString componentsSeparatedByString:@"?"];
        components = [[components objectAtIndex:1] componentsSeparatedByString:@"&"];
        NSLog(@"compoooooooooo %@",components);
        NSString *foo;
        NSString *trimmed;
        NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        
        //OpKnowte://EnterPatientDetail?surgeonID=88&procedureID=10&caseID=17&timePointID=6%20Months"&patientName=Atif&patientDOB=16-11-1990&mrNumber=46&gender=male&patientDOS=16-11-1990&stonesCount=2
        
        foo = [components objectAtIndex:0];
        trimmed = [foo stringByTrimmingCharactersInSet:set];
        [data setObject:trimmed forKey:@"SurgeonID"];
        
        foo = [components objectAtIndex:1];
        trimmed = [foo stringByTrimmingCharactersInSet:set];
        [data setObject:trimmed forKey:@"procedureID"];
        
        foo = [components objectAtIndex:2];
        trimmed = [foo stringByTrimmingCharactersInSet:set];
        [data setObject:trimmed forKey:@"caseID"];
        
        foo = [components objectAtIndex:3];
        trimmed = [foo stringByTrimmingCharactersInSet:set];
        [data setObject:trimmed forKey:@"timePointID"];
        
        [data setObject:foo = [[[[components objectAtIndex:4] componentsSeparatedByString:@"="] objectAtIndex:1]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"patientName"];
        
        [data setObject:foo = [[[components objectAtIndex:5] componentsSeparatedByString:@"="] objectAtIndex:1] forKey:@"patientDOB"];
        
        foo = [components objectAtIndex:6];
        trimmed = [foo stringByTrimmingCharactersInSet:set];
        [data setObject:trimmed forKey:@"mrNumber"];
        
        [data setObject:foo = [[[components objectAtIndex:7] componentsSeparatedByString:@"="] objectAtIndex:1] forKey:@"gender"];
        
        [data setObject:foo = [[[components objectAtIndex:8] componentsSeparatedByString:@"="] objectAtIndex:1] forKey:@"patientDOS"];
    }
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                  bundle:nil];
    OKOngoingClinicalViewController* controller = [sb instantiateViewControllerWithIdentifier:@"OKOngoingClinicalViewController"];
    
    controller.timePoint = [data objectForKey:@"timePointID"];
    controller.isComingFromUrl = YES;
    controller.caseNumber = [data objectForKey:@"caseID"];
    controller.urlTimepointID = [data objectForKey:@"timePointID"];
    controller.urlUserID = [data objectForKey:@"SurgeonID"];
    controller.procID = [data objectForKey:@"procedureID"];
    controller.urlPatientName = [data objectForKey:@"patientName"];
    controller.urlPatientDOB = [data objectForKey:@"patientDOB"];
    controller.urlPatientMR = [data objectForKey:@"mrNumber"];
    controller.urlPatientGender = [data objectForKey:@"gender"];
    controller.urlPatientDOS = [data objectForKey:@"patientDOS"];
//
//    if (![defaults objectForKey:@"user"]) {
//        self.fromUrl = YES;
//        self.url = url;
//        UIViewController *controller = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:NULL] instantiateViewControllerWithIdentifier:@"LoginView"];
//        
//        [(UINavigationController *)self.window.rootViewController presentViewController:controller animated:NO completion:nil];
//    }else{
//        self.fromUrl = NO;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        [nav setNavigationBarHidden:YES];
        [(UINavigationController *)self.window.rootViewController presentViewController:nav animated:YES completion:nil];
//    }
    
    return YES;
}

@end
