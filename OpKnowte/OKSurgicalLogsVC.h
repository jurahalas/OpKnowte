//
//  OKSurgicalLogsVC.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/11/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"

@interface OKSurgicalLogsVC : OKBaseViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property(strong, nonatomic) NSString *procID;
@property (strong, nonatomic) NSString *procTitle;
@end
