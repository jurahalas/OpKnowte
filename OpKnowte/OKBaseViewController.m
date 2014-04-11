//
//  OKBaseViewController.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/10/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"

@interface OKBaseViewController ()

@end

@implementation OKBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[UIScreen mainScreen] bounds].size.height == 568.0) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_568"]];
    } else {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
	}
    
    // Do any additional setup after loading the view.
}
-(UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addBottomTabBar{
    OKBottomTabBarView *bottomTabBarView = [[OKBottomTabBarView alloc] init];
    [bottomTabBarView drawBottomTabBar];
    [self.view addSubview:bottomTabBarView];
}


@end
