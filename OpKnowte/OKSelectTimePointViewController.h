//
//  OKSelectTimePointViewController.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/18/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"
#import "OKAppDelegate.h"
#import "OKCase.h"

@interface OKSelectTimePointViewController : OKBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *cameFromVC;

@property (nonatomic, retain) NSMutableArray *performanceCases;
@property (nonatomic, retain) NSMutableArray *surgeonCases;
@property (nonatomic, retain) NSMutableArray *totlaNationalCases;
@property (nonatomic, retain) NSMutableArray *totalSurgeonCases;
@property (nonatomic) BOOL isFilter;
@property (nonatomic) BOOL isNationalFilter;


@end
