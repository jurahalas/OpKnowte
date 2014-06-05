//
//  OKProcedureTextField.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/24/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureTextField.h"

@implementation OKProcedureTextField 

-(void) setupWithValue:(NSString*)value{
    _customTextField.text = value;
    [self.delegate updateField:self.fieldName withValue:self.customTextField.text andTag:self.tagOfTextField];
}
-(void) becomeCustomTextFieldFirstResponder{
    [_customTextField becomeFirstResponder];
}

-(void)setPlaceHolder:(NSString*)placeHolder
{
    [super setPlaceHolder:placeHolder];
    _customTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
}

- (IBAction)touchToTextField:(id)sender {
    [self.delegate openBMICalc:self.fieldName];
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


-(void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if(!enabled){
        self.customTextField.text = nil;
    }
}


-(void)setValue:(NSString*)value
{
    self.customTextField.text = value;
}


- (IBAction)textFieldChanged:(id)sender {
    [self.delegate updateField:self.fieldName withValue:self.customTextField.text andTag:self.tagOfTextField];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.delegate hidePickersWhenTextFieldBeginsEditing];
}

@end
