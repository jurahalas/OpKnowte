//
//  OKCustomTextField.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/11/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKCustomTextField.h"

@implementation OKCustomTextField

-(void) awakeFromNib {
    [self drawCustomTextField];
}
-(void) drawCustomTextField{
    
    
    if (IS_IOS7) {
        self.tintColor = [UIColor whiteColor];
    } else {
        [[self valueForKey:@"textInputTraits"] setValue:[UIColor whiteColor] forKey:@"insertionPointColor"];
    }
    self.font = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0f];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderColor =[UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1.f;
    [self setTextColor:[UIColor whiteColor]];
    self.layer.cornerRadius = 14;
    self.clipsToBounds = YES;
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    UIView *textFieldIconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    textFieldIconView.backgroundColor = [UIColor clearColor];
    self.leftView = textFieldIconView;
    self.leftViewMode = UITextFieldViewModeAlways;
}


-(void) setCustomTextFieldPlaceholder: (NSString*) placeholder Secured:(BOOL) secured DownArrow:(BOOL) downArrow
{    
    UIImage *textFieldImage = [[UIImage alloc] init];
    if ([placeholder isEqualToString:@"First name"] || [placeholder isEqualToString:@"Last name"] || [placeholder isEqualToString:@"Email"]) {
        textFieldImage = [UIImage imageNamed:@"name"];
    } else if ([placeholder isEqualToString:@"Your email..."]){
        textFieldImage = [UIImage imageNamed:@"email"];
    } else if ([placeholder isEqualToString:@"MD"]){
        textFieldImage = [UIImage imageNamed:@"degree"];
    } else {
        textFieldImage = [UIImage imageNamed:@"password"];
    }
    
    UIImageView *textFieldIcon = [[UIImageView alloc] init];
    textFieldIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 20, 20)] ;
    textFieldIcon.image = textFieldImage;
    
    UIView *textFieldIconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    textFieldIconView.backgroundColor = [UIColor clearColor];
    [textFieldIconView addSubview:textFieldIcon];
    self.leftView = textFieldIconView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    
    if (downArrow) {
        UIView *textFieldDownArrowView = [[UIView alloc] init];
        UIImageView *textFieldDownArrow = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 20, 20)] ;
        textFieldDownArrow.image = [UIImage imageNamed:@"down"];
        textFieldDownArrowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        textFieldDownArrowView.backgroundColor = [UIColor clearColor];
        [textFieldDownArrowView addSubview:textFieldDownArrow];
        self.rightView = textFieldDownArrowView;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    self.secureTextEntry = secured;
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];

}

@end
