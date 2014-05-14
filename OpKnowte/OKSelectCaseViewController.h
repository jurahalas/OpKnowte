//
//  OKSelectCaseViewController.h
//  OpKnowte
//
//  Created by Olegek on 25.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKBaseViewController.h"
#import "OKLoadingViewController.h"

@interface OKSelectCaseViewController : OKBaseViewController <UITableViewDelegate , UITableViewDataSource>

@property(strong, nonatomic) NSString *procID;
@property(strong, nonatomic) NSString *detailID;

@end