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

@protocol OKFacilityVCDelegate <NSObject>

-(void) setContactFieldWithContactArray: (NSMutableArray*) contactsArray;

@end
@interface OKFacilityVC : OKBaseViewController <UITableViewDelegate , UITableViewDataSource, MFMailComposeViewControllerDelegate>
@property (nonatomic, weak) id <OKFacilityVCDelegate> delegate;
@property (strong, nonatomic) NSMutableDictionary *templateDictionary;
@property (strong, nonatomic) NSString *cameFromVC;
@property (strong, nonatomic) NSString *roleID;
@property (strong, nonatomic) id model;

@end