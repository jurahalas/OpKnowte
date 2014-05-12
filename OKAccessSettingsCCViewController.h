//
//  OKAccessSettingsCCViewController.h
//  OpKnowte
//
//  Created by Olegek on 10.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"
#import "OKContactManager.h"
#import "OKContactModel.h"
#import "OKUserModel.h"
#import "OKInstituteVC.h"

@interface OKAccessSettingsCCViewController : OKBaseViewController <UITableViewDataSource,UITableViewDelegate>
@property(strong, nonatomic) NSString *contactID;
@property(nonatomic, strong) NSString *cameFromVC;

@property(nonatomic, strong) NSMutableArray * choseButton;

@end
