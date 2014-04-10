//
//  OKViewController.m
//  OpKnowte
//
//  Created by Eugene on 09.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKViewController.h"

@interface OKViewController ()
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *forgotPasswordButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) UIView *forgotPasswordView;
@property (strong, nonatomic) UIView *forgotPasswordViewBackground;
@property (strong, nonatomic) UILabel *forgotPasswordViewLabel;
@property (strong, nonatomic) UITextField *forgotPasswordViewTextField;
@property (strong, nonatomic) UIButton *forgotPasswordViewButton;


@end

@implementation OKViewController

#pragma mark - view methods


- (void)viewDidLoad
{
    [self setAllDesign];
    [self.navigationController setNavigationBarHidden:YES animated:YES ];
    _passwordTextField.text = @"";
    _emailTextField.text = @"";
    _forgotPasswordViewTextField.text = @"";
    CGRect forgotPasswordViewBackgroundRect = CGRectMake(0, 0, 320, 568);
    _forgotPasswordViewBackground = [[UIView alloc] initWithFrame:forgotPasswordViewBackgroundRect];
    _forgotPasswordViewBackground.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    CGRect forgotPasswordViewRect = CGRectMake(20, 200, 280, 200);
    _forgotPasswordView = [[UIView alloc] initWithFrame:forgotPasswordViewRect];
    _forgotPasswordView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    CGRect forgotPasswordViewTextFieldRect = CGRectMake(20, 90, 240, 30);
    _forgotPasswordViewTextField = [[UITextField alloc] initWithFrame:forgotPasswordViewTextFieldRect];
    _forgotPasswordViewTextField.borderStyle = UITextBorderStyleRoundedRect;
    _forgotPasswordViewTextField.text = @"";
    CGRect forgotPasswordViewButtonRect = CGRectMake(20, 130, 240, 30);
    _forgotPasswordViewButton = [[UIButton alloc] initWithFrame:forgotPasswordViewButtonRect];
    [_forgotPasswordViewButton setTitle:@"Send" forState:UIControlStateNormal];
    [_forgotPasswordViewButton addTarget:self action:@selector(forgotPasswordViewButton:) forControlEvents:UIControlEventTouchUpInside];
    //_forgotPasswordViewButton.backgroundColor = [UIColor greenColor];
    [_forgotPasswordViewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    CGRect forgotPasswordViewLabelRect = CGRectMake(20, 10, 240, 70);
    _forgotPasswordViewLabel = [[UILabel alloc] initWithFrame:forgotPasswordViewLabelRect];
    _forgotPasswordViewLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:13.0f];
    _forgotPasswordViewLabel.textAlignment = NSTextAlignmentCenter;
    _forgotPasswordViewLabel.text = @"Please confirm your Email Address.\rWe will send you your password.";
    _forgotPasswordViewLabel.numberOfLines = 0;
    
    
    
    UITapGestureRecognizer *forgotPasswordViewBackgroundTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgotPasswordViewBackgroundTapAction:)];
    [self.forgotPasswordViewBackground addGestureRecognizer:forgotPasswordViewBackgroundTap];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textField methods

- (void) animateTextField: (UITextField*) textField up: (BOOL) up {
    const int movementDistance = 55;// tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    int movement = (up ? -movementDistance : movementDistance);
    [UIView animateWithDuration:movementDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    } completion:nil];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _emailTextField) {
        [textField resignFirstResponder];
        [_passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _emailTextField) {
        textField.returnKeyType = UIReturnKeyNext;
        [self animateTextField: textField up: YES];
    } else {
        textField.returnKeyType = UIReturnKeyDone;
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField != _emailTextField) {
        [self animateTextField: textField up: NO];
    }
}

#pragma mark - Custom methods

-(void) forgotPasswordViewBackgroundTapAction: (UITapGestureRecognizer *) recognizer {
    [_forgotPasswordViewBackground removeFromSuperview];
    [_forgotPasswordView removeFromSuperview];
}

#pragma mark - IBActions
- (IBAction)loginButton:(id)sender {
}
- (void)forgotPasswordViewButton:(id)sender{
    [_forgotPasswordViewBackground removeFromSuperview];
    [_forgotPasswordView removeFromSuperview];
    
}
- (IBAction)forgetPasswordButton:(id)sender {
    [self.view addSubview:_forgotPasswordViewBackground];
    [self.view addSubview:_forgotPasswordView];
    [_forgotPasswordView addSubview:_forgotPasswordViewTextField];
    [_forgotPasswordView addSubview:_forgotPasswordViewButton];
    [_forgotPasswordView addSubview:_forgotPasswordViewLabel];
}
-(void) setAllDesign {
    [self setTextFieldsDesign];
}
-(void) setTextFieldsDesign {
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    _emailTextField.backgroundColor = [UIColor clearColor];
    _emailTextField.layer.borderColor =[UIColor whiteColor].CGColor;
    _emailTextField.layer.borderWidth = 1.f;
    _emailTextField.leftView = paddingView;
    _emailTextField.leftViewMode = UITextFieldViewModeAlways;
    [_emailTextField setTextColor:[UIColor whiteColor]];
    _emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor], NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Regular" size:15.0f]}];
    _emailTextField.layer.cornerRadius = 10;
    _emailTextField.clipsToBounds = YES;
    
    
    _passwordTextField.backgroundColor = [UIColor clearColor];
    _passwordTextField.layer.borderColor =[UIColor whiteColor].CGColor;
    _passwordTextField.layer.borderWidth = 1.f;
    _passwordTextField.leftView = paddingView;
    _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor], NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Regular" size:15.0f]}];
    _passwordTextField.layer.cornerRadius = 10;
    _passwordTextField.clipsToBounds = YES;
    _passwordTextField.secureTextEntry = YES;
}

- (IBAction)registerButton:(id)sender {
}


@end
