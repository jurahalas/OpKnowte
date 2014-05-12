//
//  OKAccessSettingsViewController.h
//  OpKnowte
//
//  Created by Olegek on 01.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

@interface OKAccessSettingsViewController : OKBaseViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSDictionary *dataDict;

@property(nonatomic, strong) NSString *procID;
@property(nonatomic, strong) NSString *userID;
@property(strong, nonatomic) NSArray *accessArray;
@property(strong, nonatomic) NSMutableArray *selectedContacts;

@end
