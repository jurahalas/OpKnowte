//
//  OKAccessSettingsCCViewController.h
//  OpKnowte
//
//  Created by Olegek on 10.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"
#import "OKContactManager.h"
#import "OKContactModel.h"
#import "OKUserModel.h"
#import "OKInstituteVC.h"

@class  OKAccessSettingsCCViewController;

@protocol OKAccessSettingsCCDelegate <NSObject>
@required

-(void) updateWithArray:(NSMutableArray *) array;
@end

@interface OKAccessSettingsCCViewController : OKBaseViewController <UITableViewDataSource,UITableViewDelegate>
@property(strong, nonatomic) NSString *contactID;
@property(nonatomic, strong) NSString *cameFromVC;
@property (nonatomic, strong) OKContactModel *contactModel;
@property(strong, nonatomic) NSMutableArray *choosedContacts;
@property (nonatomic, weak) id <OKAccessSettingsCCDelegate> delegate;
@property(nonatomic,strong) NSMutableArray * accessArray;
@property(strong, nonatomic) NSString *caseID;
@property(strong, nonatomic) NSMutableArray *shareUsersIDs;

@end
