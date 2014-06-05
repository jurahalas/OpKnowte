//
//  OKInstituteVC.h
//  OpKnowte
//
//  Created by Apple on 24.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"
//#import "OKAppDelegate.h"

@interface OKInstituteVC : OKBaseViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSString *contactID;
@property (nonatomic, strong) NSString *cameFromVC;
@property (nonatomic, strong) OKContactModel *selectedContact;
- (IBAction)saveButton:(id)sender;

@end
