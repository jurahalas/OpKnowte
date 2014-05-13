//
//  OKSelectContactTypeVC.h
//  OpKnowte
//
//  Created by Apple on 13.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"
#import "OKSelectContactTypeCell.h"
#import "OKSelectContactsVC.h"



@interface OKSelectContactTypeVC : OKBaseViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSDictionary *dataDict;


@end
