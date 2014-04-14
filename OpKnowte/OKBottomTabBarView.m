//
//  OKBottomTabBarView.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/10/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBottomTabBarView.h"

@interface OKBottomTabBarView ()
@property (strong, nonatomic) UIButton *homeButton;
@property (strong, nonatomic) UIButton *infoButton;
@property (strong, nonatomic) UIButton *settingsButton;
@property (strong, nonatomic) UIButton *logoutButton;
@end
@implementation OKBottomTabBarView


-(void) drawBottomTabBar{
    
    [self drawView];
    [self drawHomeButton];
    [self drawInfoButton];
    [self drawSettingsButton];
    [self drawLogoutButton];
    
}
-(void) drawHomeButton {
    _homeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _homeButton.frame = CGRectMake(0, 0, 80, 80);
    _homeButton.tintColor = [UIColor whiteColor];
    [self.homeButton setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [_homeButton addTarget:self action:@selector(homeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_homeButton];
}

-(void) drawInfoButton {
    _infoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _infoButton.frame = CGRectMake(80, 0, 80, 80);
    _infoButton.tintColor = [UIColor whiteColor];
    [self.infoButton setImage:[UIImage imageNamed:@"info"] forState:UIControlStateNormal];
    [_infoButton addTarget:self action:@selector(infoButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_infoButton];
}

-(void) drawSettingsButton {
    _settingsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _settingsButton.frame = CGRectMake(160, 0, 80, 80);
    _settingsButton.tintColor = [UIColor whiteColor];
    [self.settingsButton setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    [_settingsButton addTarget:self action:@selector(settingsButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_settingsButton];
}

-(void) drawLogoutButton {
    _logoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _logoutButton.frame = CGRectMake(240, 0, 80, 80);
    _logoutButton.tintColor = [UIColor whiteColor];
    [self.logoutButton setImage:[UIImage imageNamed:@"logout"] forState:UIControlStateNormal];
    [_logoutButton addTarget:self action:@selector(logoutButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_logoutButton];
}
-(void) drawView {
    self.backgroundColor = [UIColor colorWithRed:40/255.0 green:55/255.0 blue:76/255.0 alpha:1];
    self.frame = CGRectMake(0, 488, 320, 80);
}
-(void)homeButton:(id)sender{
    
}
-(void)infoButton:(id)sender{
    
}
-(void)settingsButton:(id)sender{
    
}
-(void)logoutButton:(id)sender{
    
}
@end
