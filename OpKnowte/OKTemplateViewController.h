//
//  OKTemplateViewController.h
//  OpKnowte
//
//  Created by Olegek on 02.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

@interface OKTemplateViewController : OKBaseViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) int procedureID;

@end
