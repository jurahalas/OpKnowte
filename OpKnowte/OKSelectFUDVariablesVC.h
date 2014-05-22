//
//  OKSelectFUDVariablesVC.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/17/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"

@interface OKSelectFUDVariablesVC : OKBaseViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSString *cameFromVC;

@property (nonatomic, retain) NSMutableArray *performanceCases;
@property (nonatomic, retain) NSMutableArray *surgeonCases;
@property (nonatomic, retain) NSMutableArray *totlaNationalCases;
@property (nonatomic, retain) NSMutableArray *totalSurgeonCases;
@property (nonatomic) int timepointID;
@end
