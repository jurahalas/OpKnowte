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
#import "OKLoadingViewController.h"
//#import "OKOngoingClinicalViewController.h"

// cells
#import "OKSelectProcedureCell.h"
#import "OKNationalDataTableViewCell.h"
#import "OKSelectTimePointCell.h"
#import "OKProcedureDetailSummaryCell.h"
#import "OKSurgeonPerformanceDataComparisonContentCell.h"
#import "OKSurgeonPerformanceDataComparisonTitleCell.h"
#import "OKFacilityTableViewCell.h"

//networking
#import "OKApiClient.h"
#import "OKUserManager.h"
#import "OKBaseManager.h"
#import "OKContactManager.h"

//models
#import "OKBaseModel.h"
#import "OKUserModel.h"

//proc Parser VCs


@interface OKAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) BOOL fromUrl;
@property (assign, nonatomic) NSURL *url;
//@property (assign, nonatomic) OKOngoingClinicalViewController* controller;

- (UIViewController*)topViewController;

@end
