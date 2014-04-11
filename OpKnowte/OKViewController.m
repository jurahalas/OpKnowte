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
@property (nonatomic) BOOL animatedKeyboard;


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
-(void) viewWillAppear:(BOOL)animated{
     [self.navigationController setNavigationBarHidden:YES animated:YES ];
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
    if (up) {
        _animatedKeyboard = YES;
    } else {
        _animatedKeyboard = NO;
    }
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _emailTextField) {
        [textField resignFirstResponder];
        [_passwordTextField becomeFirstResponder];
    } else {
        [self animateTextField: textField up: NO];
        [textField resignFirstResponder];
    }
    return YES;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _emailTextField) {
        textField.returnKeyType = UIReturnKeyNext;
    } else {
        textField.returnKeyType = UIReturnKeyDone;
    }
    if (!_animatedKeyboard) {
        [self animateTextField: textField up: YES];
    }     
}
- (void)textFieldDidEndEditing:(UITextField *)textField {

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

- (IBAction)registerButton:(id)sender {
    
}
#pragma mark - design
-(void) setAllDesign {
    
    [self setDesignForTextField:_emailTextField Placeholder: @"Email" Secured:NO];
    [self setDesignForTextField:_passwordTextField Placeholder:@"Password" Secured:YES];
    
    _loginButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:74/255.0 blue:89/255.0 alpha:1];
    _loginButton.layer.cornerRadius = 14;
    _loginButton.clipsToBounds = YES;
    
}

-(void) setDesignForTextField:(UITextField*) textField  Placeholder:(NSString*) placeholder Secured:(BOOL) secured{
    
    
    UIImageView *textFieldIcon = [[UIImageView alloc] init];
    if ([placeholder isEqualToString:@"Email"]) {
        textFieldIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 19, 18)] ;
        textFieldIcon.image = [UIImage imageNamed:@"nameTextFieldIcon"];
    } else {
        textFieldIcon = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 14, 18)] ;
        textFieldIcon.image = [UIImage imageNamed:@"passwordTextFieldIcon"];
    }
    
    UIView *textFieldIconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 18)];
    textFieldIconView.backgroundColor = [UIColor clearColor];
    [textFieldIconView addSubview:textFieldIcon];
    
    textField.tintColor = [UIColor whiteColor];
    textField.leftView = textFieldIconView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.font = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0f];
    textField.backgroundColor = [UIColor clearColor];
    textField.layer.borderColor =[UIColor whiteColor].CGColor;
    textField.layer.borderWidth = 1.f;
    [textField setTextColor:[UIColor whiteColor]];
    textField.layer.cornerRadius = 14;
    textField.clipsToBounds = YES;
    textField.secureTextEntry = secured;
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{
                                                                                                          NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                                                                                          NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-UltraLightItalic" size:14.0f]
                                                                                                          }];
}


@end
