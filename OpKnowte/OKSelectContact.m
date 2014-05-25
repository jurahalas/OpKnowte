//
//  OKSelectContact.m
//  OpKnowte
//
//  Created by Artem Frolow on 5/22/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSelectContact.h"

@implementation OKSelectContact

-(void) setup{
    _customTextField.text = @"";
    _customTextField.enabled = NO;
    [self.delegate updateField:self.fieldName withValue:self.contactIDs andTag:self.tagOfTextField];
    [self setTextFieldRightImage];
}


- (IBAction)customButtonTapped:(id)sender {

    [self.delegate goToSelectContactViewWithRoleID:self.roleID selectContactObject:self];
}
- (void) setRoleID:(NSString *)roleID{
    _roleID = roleID;
}

-(void)setPlaceHolder:(NSString*)placeHolder
{
    [super setPlaceHolder:placeHolder];
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


-(BOOL)becomeFirstResponder
{
    [self customButtonTapped:nil];
    return YES;
}

- (IBAction)textFieldChanged:(id)sender {
        [self.delegate updateField:self.fieldName withValue:self.contactIDs andTag:self.tagOfTextField];
}




@end
