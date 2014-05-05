//
//  OKSurgeonViewController.m
//  OpKnowte
//
//  Created by Olegek on 02.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSurgeonViewController.h"

@interface OKSurgeonViewController ()
@property (strong, nonatomic) IBOutlet UIView *bottomTabBar;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet OKCustomTextField *streetTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *cityTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *stateTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *zipTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *coutryTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *EmailTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *FaxTextField;


@property (nonatomic) BOOL animatedKeyboard;
@end

@implementation OKSurgeonViewController
@synthesize bottomTabBar,submitButton,animatedKeyboard,streetTextField,cityTextField,stateTextField,zipTextField,coutryTextField,EmailTextField,FaxTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self design];
    
    streetTextField.text = @"";
    cityTextField.text = @"";
    stateTextField.text = @"";
    zipTextField.text = @"";
    coutryTextField.text = @"";
    EmailTextField.text = @"";
    FaxTextField.text = @"";

    streetTextField.tag = 1;
    cityTextField.tag = 2;
    stateTextField.tag = 3;
    zipTextField.tag = 4;
    coutryTextField.tag = 5;
    EmailTextField.tag = 6;
    FaxTextField.tag = 7;
}
-(void)design{
    
    streetTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Streer Adress:" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    cityTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"City:" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    stateTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"State:" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    zipTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Zip:" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    coutryTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Country:" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    EmailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email:" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    FaxTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Fax:" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    
    bottomTabBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradientBG"]];
    bottomTabBar.backgroundColor = [UIColor clearColor];
    submitButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    submitButton.layer.cornerRadius = 14;

}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80;
    const float movementDuration = 0.3f;
    int movement = (up ? -movementDistance : movementDistance);
    [UIView animateWithDuration:movementDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    } completion:nil];
    if (up) {
        animatedKeyboard = YES;
    } else {
        animatedKeyboard = NO;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UIResponder* nextResponder = [textField.superview viewWithTag:(textField.tag + 1)];
    if (textField.tag != FaxTextField.tag ) {
        [textField resignFirstResponder];
        [nextResponder becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        [self animateTextField: textField up: NO];
    }
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == FaxTextField.tag) {
        textField.returnKeyType = UIReturnKeyDone;
    } else {
        textField.returnKeyType = UIReturnKeyNext;
    }
    
    if (textField.tag >5 && !animatedKeyboard){
        [self animateTextField: textField up: YES];
    } else if (textField.tag <=5 && animatedKeyboard){
        [self animateTextField: textField up: NO];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    
}
- (IBAction)backButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
