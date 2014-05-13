//
//  UCEditProcedures.h
//  MZUroCapture
//
//  Created by Atif Joyia on 22/05/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCEditProcedureTemplateViewController.h"

@interface UCEditProceduresViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>{
    NSArray *namesArray;
    NSArray *numberArray;
}

@property (strong, nonatomic) IBOutlet UIToolbar * t_toolbar;
@property (strong, nonatomic) IBOutlet UIPickerView *hintPicker;
@property (nonatomic, retain) NSString *editableText;
@property (nonatomic, retain) UCEditProcedureTemplateViewController *parent;
@property (nonatomic, retain) IBOutlet UILabel *headerLbl;
@property (nonatomic, retain) IBOutlet UITextView *textView;

@end
