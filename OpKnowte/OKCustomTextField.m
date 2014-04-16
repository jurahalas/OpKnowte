//
//  OKCustomTextField.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/11/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKCustomTextField.h"

@implementation OKCustomTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

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
    
    
}
-(void) setCustomTextFieldPlaceholder: (NSString*) placeholder Secured:(BOOL) secured DownArrow:(BOOL) downArrow{
    UIImageView *textFieldIcon = [[UIImageView alloc] init];
    
    if ([placeholder isEqualToString:@"your first name..."] || [placeholder isEqualToString:@"your last name..."] || [placeholder isEqualToString:@"Email"]) {
        textFieldIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 19, 18)] ;
        textFieldIcon.image = [UIImage imageNamed:@"nameTextFieldIcon"];
    } else if ([placeholder isEqualToString:@"your email..."]){
        textFieldIcon = [[UIImageView alloc] initWithFrame:CGRectMake(11, 3, 18, 12)] ;
        textFieldIcon.image = [UIImage imageNamed:@"emailTextFieldIcon"];
    } else if ([placeholder isEqualToString:@"MD"]){
        textFieldIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 1, 19, 16)] ;
        textFieldIcon.image = [UIImage imageNamed:@"MDTextFieldIcon"];
    } else {
        textFieldIcon = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 14, 18)] ;
        textFieldIcon.image = [UIImage imageNamed:@"passwordTextFieldIcon"];
    }
    UIView *textFieldIconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 18)];
    textFieldIconView.backgroundColor = [UIColor clearColor];
    [textFieldIconView addSubview:textFieldIcon];
    self.leftView = textFieldIconView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    
    if (downArrow) {
        UIView *textFieldDownArrowView = [[UIView alloc] init];
        UIImageView *textFieldDownArrow = [[UIImageView alloc] initWithFrame:CGRectMake(11, 3, 18, 11)] ;
        textFieldDownArrow.image = [UIImage imageNamed:@"down"];
        textFieldDownArrowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 18)];
        textFieldDownArrowView.backgroundColor = [UIColor clearColor];
        [textFieldDownArrowView addSubview:textFieldDownArrow];
        self.rightView = textFieldDownArrowView;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    self.secureTextEntry = secured;
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];

}

@end
