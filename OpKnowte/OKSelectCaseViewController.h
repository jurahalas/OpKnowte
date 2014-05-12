//
//  OKSelectCaseViewController.h
//  OpKnowte
//
//  Created by Olegek on 25.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKBaseViewController.h"

@interface OKSelectCaseViewController : OKBaseViewController <UITableViewDelegate , UITableViewDataSource>

@property(strong, nonatomic) NSString *procID;

@end
