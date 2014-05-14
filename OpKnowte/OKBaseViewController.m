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
    //dashboard
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


@end
