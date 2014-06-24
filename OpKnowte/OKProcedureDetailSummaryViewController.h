//
//  OKProcedureDetailSummaryViewController.h
//  OpKnowte
//
//  Created by Eugene on 4/18/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"
#import "OKAppDelegate.h"

@class OKOngoingData;

@interface OKProcedureDetailSummaryViewController : OKBaseViewController

@property (nonatomic, strong) OKOngoingData *ongoingData;
@property (nonatomic, assign) enum OKProcedureSummaryDetailPeriod detailPeriod;
@property(nonatomic, strong) NSString *caseNumber;

@end
