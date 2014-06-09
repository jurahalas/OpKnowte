//
//  OKBMIViewController.h
//  OpKnowte
//
//  Created by Olegek on 09.06.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKAppDelegate.h"
#import "OKBaseProcedureElement.h"

@protocol OKBMICalcViewDelegeta <NSObject>
-(void)bmiCancelBtnTapped;
-(void)bmiCalculateBtnTapped;

@end

@interface OKBMIViewController : OKBaseViewController

@property (nonatomic, weak) id<OKBMICalcViewDelegeta>delegate;
@property (strong, nonatomic) IBOutlet OKCustomTextField *height;
@property (strong, nonatomic) IBOutlet OKCustomTextField *weight;
@property (strong, nonatomic) IBOutlet UIButton *calculateBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) NSString *BMIValue;

- (IBAction)canlecBtn:(id)sender;
- (IBAction)calculateBtn:(id)sender;
@end
