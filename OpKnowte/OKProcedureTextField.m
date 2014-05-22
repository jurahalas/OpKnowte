//
//  OKProcedureTextField.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/24/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureTextField.h"

@implementation OKProcedureTextField 

-(void) setup{
    _customTextField.text = @"";
    [self.delegate updateField:self.fieldName withValue:self.customTextField.text andTag:self.tagOfTextField];
}


-(void)setPlaceHolder:(NSString*)placeHolder
{
    [super setPlaceHolder:placeHolder];
    _customTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
}


-(void)setType:(enum OKProcedureTextFieldType)type{
    if (type == OKProcedureSymbolicTF) {
        _customTextField.keyboardType = UIKeyboardTypeDefault;
    } else {
        _customTextField.keyboardType = UIKeyboardTypeDecimalPad;
    }
}

-(void) setTagOfTextField:(NSInteger)tagOfTextField {
    _tagOfTextField = tagOfTextField;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.delegate goToNextElementFrom:self];
    return YES;
}


-(BOOL)resignFirstResponder
{
    [self.customTextField resignFirstResponder];
    return YES;
}

- (IBAction)textFieldChanged:(id)sender {
    [self.delegate updateField:self.fieldName withValue:self.customTextField.text andTag:self.tagOfTextField];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.delegate hidePickersWhenTextFieldBeginsEditing];
}

@end
