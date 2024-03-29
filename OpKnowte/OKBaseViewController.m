//
//  OKBaseViewController.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/10/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"
#import "OKSettingsViewController.h"
#import "OKDashboardVC.h"
#import "OKInfoViewController.h"

@interface OKBaseViewController () <OKBaseVCDelegate>

@end

@implementation OKBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    if ([[UIScreen mainScreen] bounds].size.height == 568.0) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_568"]];
    } else {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
	}
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        [[UINavigationBar appearance] setTitleTextAttributes: @{
                                                                UITextAttributeTextColor: [UIColor whiteColor],
                                                                UITextAttributeTextShadowColor: [UIColor clearColor],
                                                                UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                                                UITextAttributeFont: [UIFont fontWithName:@"AvenirNext-DemiBold" size:19.0f]
                                                                }];

    }else{
    
       
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:@"AvenirNext-DemiBold" size:19.0f], NSFontAttributeName,
                                        [UIColor whiteColor], NSForegroundColorAttributeName,
                                            [NSShadow new], NSShadowAttributeName,nil]];
    }

}


-(void) viewWillAppear:(BOOL)animated{
     [self.navigationController setNavigationBarHidden:NO animated:YES ];
}
-(void) goToSettingsVC{
    
    if(![self.restorationIdentifier isEqualToString:@"settings"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        OKSettingsViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"settings"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
-(void) goToDashboard {
    if(![self.restorationIdentifier isEqualToString:@"dashboard"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        OKDashboardVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"dashboard"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)goToInfoVC{
    if(![self.restorationIdentifier isEqualToString:@"info"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        OKInfoViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"info"];
        vc.cameFromVC = @"LogoTBButton";
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (BOOL)navBar{
    return self.navigationController.navigationBarHidden;
}


-(UIStatusBarStyle) preferredStatusBarStyle {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    return UIStatusBarStyleLightContent;
}


-(void) addBottomTabBar {
    OKBottomTabBarView *bottomTabBarView = [[OKBottomTabBarView alloc] init];
    bottomTabBarView.delegate = self;
    [self.view addSubview:bottomTabBarView];
    [bottomTabBarView drawBottomTabBar];
}


-(IBAction)backButton:(id)sender
{
    if(self.navigationController)
        [self.navigationController popViewControllerAnimated:YES];
}



@end
