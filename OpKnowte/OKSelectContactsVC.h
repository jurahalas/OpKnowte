//
//  OKSelectContactsVC.h
//  OpKnowte
//
//  Created by Apple on 13.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"
#import "OKSelectContactsCell.h"


@interface OKSelectContactsVC : OKBaseViewController <UITableViewDataSource,UITableViewDelegate>

@property(strong, nonatomic) NSString *contactID;


@end
