//
//  UCESWLTimePoint.h
//  MZUroCapture
//
//  Created by Atif Joyia on 07/08/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RCSwitchOnOff;

@interface UCESWLTimePoint : UIViewController<UITextFieldDelegate>
{
    IBOutlet UILabel * l_Header;
    RCSwitchOnOff *compSwitch;
}


@property (nonatomic, retain) NSString *stonesCount;
@property (nonatomic, retain) NSString *caseID;

@property (nonatomic, retain) NSString *urlUserID;
@property (nonatomic, retain) NSString *urlProcedureID;
@property (nonatomic) BOOL isComingFromURL;

@property (nonatomic, retain) IBOutlet UIScrollView *scroller;
@property (nonatomic, retain) IBOutlet UITextField *descTF;

@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (nonatomic, retain) IBOutlet UIToolbar * t_toolbar;
@property (nonatomic, retain) NSMutableArray *pickerArray;

@property (nonatomic, retain) IBOutlet UIButton *fragmentationBtn1;
@property (nonatomic, retain) IBOutlet UIButton *fragmentationBtn2;
@property (nonatomic, retain) IBOutlet UIButton *fragmentationBtn3;
@property (nonatomic, retain) IBOutlet UIButton *fragmentationBtn4;
@property (nonatomic, retain) IBOutlet UIButton *fragmentationBtn5;

@property (nonatomic, retain) IBOutlet UILabel *fragmentationLbl1;
@property (nonatomic, retain) IBOutlet UILabel *fragmentationLbl2;
@property (nonatomic, retain) IBOutlet UILabel *fragmentationLbl3;
@property (nonatomic, retain) IBOutlet UILabel *fragmentationLbl4;
@property (nonatomic, retain) IBOutlet UILabel *fragmentationLbl5;

@end
