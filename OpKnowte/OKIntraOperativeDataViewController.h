//
//  OKIntraOperativeDataViewController.h
//  OpKnowte
//
//  Created by Olegek on 15.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

@interface OKIntraOperativeDataViewController : OKBaseViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property(strong, nonatomic) NSString *procID;
@property (strong, nonatomic) NSString *procTitle;

@property (nonatomic, retain) NSString *parent;
@property (nonatomic, retain) NSMutableArray *cases;
@property (nonatomic, retain) NSMutableArray *selectedCases;




@end