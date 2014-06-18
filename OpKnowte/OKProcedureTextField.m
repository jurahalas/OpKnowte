//
//  OKProcedureTextField.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/24/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureTextField.h"
#import "OKLRPartialNephrectomyVC.h"

@implementation OKProcedureTextField 

-(void) setupWithValue:(NSString*)value{
    if ([self.fieldName isEqualToString:@"var_stonesLocations"] || [self.fieldName isEqualToString:@"var_stonesSizes"] || [self.fieldName isEqualToString:@"var_totalShocks"] || [self.fieldName isEqualToString:@"var_fragmentations"]) {
    //    _customTextField.text = value;
        [self.delegate updateField:self.fieldName withValue:self.customTextField.text andTag:self.tagOfTextField];
    }else{
        if (![value isEqualToString:@"NO"] && ![value isEqualToString:@"None"]) {
            _customTextField.text = value;
            [self.delegate updateField:self.fieldName withValue:self.customTextField.text andTag:self.tagOfTextField];
        }else{
            _customTextField.text = @"";
        }
    }
}

-(void) becomeCustomTextFieldFirstResponder{
    [_customTextField becomeFirstResponder];
}


-(void) resignCustomTextFieldFirstResponder{
        [_customTextField resignFirstResponder];
    [self.view endEditing:YES];
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
    [self endEditing:YES];

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


- (IBAction)textFieldChanged:(id)sender
{
    [self.delegate updateField:self.fieldName withValue:self.customTextField.text andTag:self.tagOfTextField];

}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.delegate hidePickersWhenTextFieldBeginsEditing];
}

@end
