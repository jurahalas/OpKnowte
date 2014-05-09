//
//  OKContactListVC.h
//  OpKnowte
//
//  Created by Apple on 09.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"
#import "OKContactListCell.h"
#import "OKContactManager.h"
#import "OKContactModel.h"
#import "OKUserModel.h"
#import "OKInstituteVC.h"

@interface OKContactListVC : OKBaseViewController <UITableViewDelegate , UITableViewDataSource>

@property(strong, nonatomic) NSString *contactID;
@property (nonatomic, strong) NSString *cameFromVC;

@end
