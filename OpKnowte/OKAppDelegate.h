//
//  OKAppDelegate.h
//  OpKnowte
//
//  Created by Eugene on 09.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

//custom views
#import "OKBaseViewController.h"
#import "OKBottomTabBarView.h"
#import "OKConstants.h"
#import "OKCustomTextField.h"
#import "OKSelectProcedureCell.h"
#import "OKNationalDataTableViewCell.h"

//networking
#import "OKApiClient.h"
#import "OKUserManager.h"
#import "OKBaseManager.h"
#import "OKContactManager.h"

//models
#import "OKBaseModel.h"
#import "OKUserModel.h"

@interface OKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (UIViewController*)topViewController;

@end
