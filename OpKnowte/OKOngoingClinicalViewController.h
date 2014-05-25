//
//  OKOngoingClinicalViewController.h
//  OpKnowte
//
//  Created by Olegek on 28.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

@class OKOngoingData;

@interface OKOngoingClinicalViewController : OKBaseViewController

@property (strong, nonatomic) OKOngoingData *ongoingData;
@property (nonatomic, assign) enum OKProcedureSummaryDetailPeriod detailPeriod;

@end
