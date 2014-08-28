//
//  OKCaseListViewController.h
//  OpKnowte
//
//  Created by Olegek on 28.08.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKBaseViewController.h"

@interface OKCaseListViewController : OKBaseViewController

@property (nonatomic) BOOL isReminderSetting;
@property (nonatomic) BOOL fromSettings;

@property(strong, nonatomic) NSString *procID;
@property(strong, nonatomic) NSString *detailID;
@property(strong, nonatomic) NSString *cameFromVC;
@property(strong, nonatomic) NSString *followUp;
@property(strong, nonatomic) NSString *stonesCount;


@end
