//
//  OKFacilityVC.h
//  OpKnowte
//
//  Created by Apple on 29.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"
#import <MessageUI/MessageUI.h>
#import "OKContactManager.h"
#import "OKSendFaxManager.h"
#import "OKContactModel.h"
#import "OKUserModel.h"


@interface OKFacilityVC : OKBaseViewController <UITableViewDelegate , UITableViewDataSource, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) NSMutableDictionary *templateDictionary;

@end