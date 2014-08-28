//
//  OKUserListVC.h
//  OpKnowte
//
//  Created by Olegek on 27.08.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

@interface OKUserListVC : OKBaseViewController <UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate>

@property(strong, nonatomic) NSString *procID;
@property(strong, nonatomic) NSString *detailID;

@property (strong, nonatomic) NSMutableArray *detailsArray;

@end
