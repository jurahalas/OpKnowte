//
//  OKProcedureDatePicker.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/27/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureDatePicker.h"

@interface OKProcedureDatePicker ()<UITextFieldDelegate>
- (IBAction)customButtonTapped:(id)sender;

@end
@implementation OKProcedureDatePicker


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[NSBundle mainBundle] loadNibNamed:@"OKProcedureDatePicker" owner:self options:nil];
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
    [self setTextFieldRightImage];

}


- (IBAction)customButtonTapped:(id)sender {
    
    [self.delegate showDatePickerWithDate:[NSDate date] picker:self];

}


-(void)setFieldName:(NSString*)name
{
    _fieldName = name;
}


-(void)setPlaceHolder:(NSString*)placeHolder{
  _customTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
}


-(void) setTagOfTextField:(NSInteger)tagOfTextField{
    _tagOfTextField = tagOfTextField;
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


- (IBAction)textFieldChanged:(id)sender {
    [self.delegate updateField:self.fieldName withValue:self.customTextField.text andTag:self.tagOfTextField];
}

@end
