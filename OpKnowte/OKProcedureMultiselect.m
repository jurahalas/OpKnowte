//
//  OKProcedureMultiselect.m
//  OpKnowte
//
//  Created by Eugene on 05.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureMultiselect.h"

@interface OKProcedureMultiselect ()

@property (strong, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) IBOutlet OKCustomTextField *customTextField;

@end

@implementation OKProcedureMultiselect

-(void) setup{
     [self setTextFieldRightImage];
}

-(void)setPlaceHolder:(NSString*)placeHolder
{
    [super setPlaceHolder:placeHolder];
    _customTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    //[self.button setTitle:placeHolder forState:UIControlStateNormal];
}


-(void)updateField:(NSString*)field WithData:(NSArray*)data;
{
    if(data.count != 0){
        _customTextField.text = [data componentsJoinedByString:@", "];
        //[self.button setTitle:[data componentsJoinedByString:@", "] forState:UIControlStateNormal];
    }else{
        _customTextField.text = @"";
        //[self.button setTitle:self.placeHolder forState:UIControlStateNormal];
    }
    [self.delegate updateField:field withData:data];
}


-(BOOL)becomeFirstResponder
{
    [self buttonTapped:nil];
    return YES;
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
- (IBAction)buttonTapped:(id)sender
{
    [self.delegate showMultiselectVCForFieldWithName:self.fieldName withData:self.dataArray sender:self];
}

@end
