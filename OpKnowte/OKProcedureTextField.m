//
//  OKProcedureTextField.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/24/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureTextField.h"

@interface OKProcedureTextField ()<UITextFieldDelegate>

@end

@implementation OKProcedureTextField


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[NSBundle mainBundle] loadNibNamed:@"OKProcedureTextField" owner:self options:nil];
        self.frame = frame;
        [self addSubview:self.view];
        self.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self setup];
    }
    return self;
}


-(void) setup{
    _customTextField.text = @"";
    [self.delegate updateField:self.fieldName withValue:self.customTextField.text andTag:self.tagOfTextField];
}


-(void)setFieldName:(NSString*)name
{
    _fieldName = name;
}


-(void)setPlaceHolder:(NSString*)placeHolder{
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

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_customTextField resignFirstResponder];
    return YES;
}


- (IBAction)textFieldChanged:(id)sender {
    [self.delegate updateField:self.fieldName withValue:self.customTextField.text andTag:self.tagOfTextField];
}



@end
