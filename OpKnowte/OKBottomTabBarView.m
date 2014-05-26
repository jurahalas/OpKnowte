//
//  OKBottomTabBarView.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/10/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBottomTabBarView.h"
#import "OKAccessSettingsViewController.h"
#import "OKSettingsViewController.h"

@interface OKBottomTabBarView ()
@property (strong, nonatomic) UIButton *homeButton;
@property (strong, nonatomic) UIButton *logoTBButton;

@property (strong, nonatomic) UIButton *settingsButton;

@end
@implementation OKBottomTabBarView


-(void) drawBottomTabBar{
    
    [self drawView];
    [self drawHomeButton];
    [self drawLogoTBImage];
    [self drawSettingsButton];
    
}
-(void) drawHomeButton {
    _homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _homeButton.frame = CGRectMake(0, 0, 80, 51);
    
    _homeButton.tintColor = [UIColor whiteColor];
    [self.homeButton setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [_homeButton addTarget:self action:@selector(homeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_homeButton];
}

-(void) drawLogoTBImage {
    _logoTBButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _logoTBButton.frame = CGRectMake(80, 0, 160, 51);

    _logoTBButton.tintColor = [UIColor whiteColor];
    [self.logoTBButton setImage:[UIImage imageNamed:@"logoTB"] forState:UIControlStateNormal];
    [_logoTBButton addTarget:self action:@selector(logoTBButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_logoTBButton];
    
}

-(void) drawSettingsButton {
    _settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _settingsButton.frame = CGRectMake(240, 0, 80, 51);
    
    _settingsButton.tintColor = [UIColor whiteColor];
    [self.settingsButton setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    [_settingsButton addTarget:self action:@selector(settingsButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_settingsButton];
}

-(void) drawView {
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbarBG"]];
    if (IS_IOS7 || [self.delegate navBar] == true) {
        self.frame = CGRectMake(0, self.superview.frame.size.height - 51, 320, 51);
        }
    else {
        self.frame = CGRectMake(0, self.superview.frame.size.height - 95, 320, 51);
        }
}
-(void) dView{

    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbarBG"]];
    if (IS_IOS7 || [self.delegate navBar] == true) {
        self.frame = CGRectMake(0, self.superview.frame.size.height - 115, 320, 51);
    }
    else {
        self.frame = CGRectMake(0, self.superview.frame.size.height - 155, 320, 51);
    }
}
- (void)draw{

    [self dView];
    [self drawHomeButton];
    [self drawLogoTBImage];
    [self drawSettingsButton];
    
}

-(void)homeButton:(id)sender
{
    [self.delegate goToDashboard];
}
-(void)logoTBButton:(id)sender
{
    [self.delegate goToInfoVC];
}

-(void)settingsButton:(id)sender
{
   [self.delegate goToSettingsVC];
}

@end
