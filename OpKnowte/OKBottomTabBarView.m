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
@property (strong, nonatomic) UIView *logoTBView;
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
    _logoTBView = [[UIView alloc] init];
    _logoTBView.frame = CGRectMake(80, 0, 160, 51);
    _logoTBView.backgroundColor = [UIColor clearColor];
    
    UIImageView *logoTBImage = [[UIImageView alloc] initWithFrame:CGRectMake(31, 13, 98, 25)];
    logoTBImage.image = [UIImage imageNamed:@"logoTB"] ;
    [_logoTBView addSubview:logoTBImage];
    
    [self addSubview:_logoTBView];
}

-(void) drawSettingsButton {
    _settingsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _settingsButton.frame = CGRectMake(240, 0, 80, 51);
    
    _settingsButton.tintColor = [UIColor whiteColor];
    [self.settingsButton setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    [_settingsButton addTarget:self action:@selector(settingsButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_settingsButton];
}

-(void) drawView {
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbarBG"]];
    self.frame = CGRectMake(0, self.superview.frame.size.height-51 , 320, 51);
}
-(void)homeButton:(id)sender{
    
}
-(void)settingsButton:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"EMAILADDRESS"];
    [defaults removeObjectForKey:@"PASSWORD"];
    [defaults synchronize];
    NSLog(@"session was destroyed");
}

@end
