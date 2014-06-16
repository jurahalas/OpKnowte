//
//  OKProcedurePicker.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/27/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedurePicker.h"
#import "OKCustomTextField.h"

@interface OKProcedurePicker ()<UITextFieldDelegate>

- (IBAction)customButtonTapped:(id)sender;

@end

@implementation OKProcedurePicker

-(void) setupWithValue:(NSString*)value{
    if (![value isKindOfClass:[NSArray class]]) {
        if (![value isEqualToString:@"NO"]) {
        _customTextField.text = value;
        [self.delegate updateField:self.fieldName withValue:self.customTextField.text andTag:self.tagOfTextField];

        }else{
            _customTextField.text = @"";
            [self.delegate updateField:self.fieldName withValue:@"NO" andTag:self.tagOfTextField];
        }
    }
    _customTextField.enabled = NO;
    [self setTextFieldRightImage];
}


- (IBAction)customButtonTapped:(id)sender {
    [self.delegate showPickerWithData:_dataArray picker:self];
    [self.delegate updateField:self.fieldName withValue:self.customTextField.text andTag:self.tagOfTextField];

}


-(void)setPlaceHolder:(NSString*)placeHolder
{
    [super setPlaceHolder:placeHolder];
    _customTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
}


-(void) setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
}


-(void) setTagOfTextField:(NSInteger)tagOfTextField{
    _tagOfTextField = tagOfTextField;
}


-(void)setValue:(NSString*)value
{
    self.customTextField.text = value;
}


- (void) setTextFieldRightImage{
    UIView *textFieldDownArrowView = [[UIView alloc] init];
    UIImageView *textFieldDownArrow = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 20, 20)] ;
    textFieldDownArrow.image = [UIImage imageNamed:@"down"];
    textFieldDownArrowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    textFieldDownArrowView.backgroundColor = [UIColor clearColor];
    [textFieldDownArrowView addSubview:textFieldDownArrow];
    _customTextField.rightView = textFieldDownArrowView;
    _customTextField.rightViewMode = UITextFieldViewModeAlways;
}


-(BOOL)becomeFirstResponder
{
    [self customButtonTapped:nil];
    return YES;
}


- (IBAction)textFieldChanged:(id)sender {
    [self.delegate updateField:self.fieldName withValue:self.customTextField.text andTag:self.tagOfTextField];
}
-(void) setButtonEnabled:(BOOL) enabled{
    self.button.enabled = enabled;
    self.customTextField.enabled = enabled;
    [self endEditing:YES];
}

@end
