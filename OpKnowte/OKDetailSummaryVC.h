//
//  OKDetailSummaryVC.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/13/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"

@interface OKDetailSummaryVC : OKBaseViewController <UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic) NSString *procID;
@property(strong,nonatomic) id model;

@end
