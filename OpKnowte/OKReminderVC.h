//
//  OKReminderVC.h
//  OpKnowte
//
//  Created by Apple on 12.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"
#import "OKProceduresManager.h"

@interface OKReminderVC : OKBaseViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property(strong, nonatomic) NSString *procID;
@property(strong, nonatomic) NSString *detailID;

@end
