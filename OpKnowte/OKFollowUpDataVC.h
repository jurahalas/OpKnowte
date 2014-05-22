//
//  OKFollowUpDataVC.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/15/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"

@interface OKFollowUpDataVC : OKBaseViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property(strong, nonatomic) NSString *procID;
@property (strong, nonatomic) NSString *procTitle;
@end
