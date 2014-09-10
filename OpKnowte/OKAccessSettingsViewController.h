//
//  OKAccessSettingsViewController.h
//  OpKnowte
//
//  Created by Olegek on 01.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"
#import "OKAccessSettingsCCViewController.h"

@interface OKAccessSettingsViewController : OKBaseViewController <UITableViewDelegate,UITableViewDataSource, OKAccessSettingsCCDelegate>

@property (strong, nonatomic) NSDictionary *dataDict;

@property(nonatomic, strong) NSString *procID;
@property(nonatomic, strong) NSString *userID;
@property(strong, nonatomic) NSMutableArray *accessArray;
@property(strong, nonatomic) NSMutableArray *selectedContacts;
@property(strong, nonatomic) NSMutableArray *choosedContacts;
@property(strong, nonatomic) NSString *caseID;
@property(strong, nonatomic) NSMutableArray *shareUsersIDs;

@end
