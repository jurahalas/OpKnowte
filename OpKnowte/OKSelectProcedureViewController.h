//
//  OKSelectProcedureViewController.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/15/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"

@interface OKSelectProcedureViewController : OKBaseViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSString *cameFromVC;


@end
