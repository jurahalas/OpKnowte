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
@property (strong, nonatomic) UITextField *forgotPasswordViewTextField;
@property (strong, nonatomic) UIButton *forgotPasswordViewButton;


@end

@implementation OKViewController

- (void)viewDidLoad
{
    _passwordTextField.text = @"";
    _emailTextField.text = @"";
    _forgotPasswordViewTextField.text = @"";
    CGRect forgotPasswordViewBackgroundRect = CGRectMake(0, 0, 320, 568);
    _forgotPasswordViewBackground = [[UIView alloc] initWithFrame:forgotPasswordViewBackgroundRect];
    _forgotPasswordViewBackground.backgroundColor = [UIColor blackColor];
    _forgotPasswordViewBackground.alpha = 0.3;
    
    UITapGestureRecognizer *forgotPasswordViewBackgroundTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgotPasswordViewBackgroundTapAction:)];
    [self.forgotPasswordViewBackground addGestureRecognizer:forgotPasswordViewBackgroundTap];
    

    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) forgotPasswordViewBackgroundTapAction: (UITapGestureRecognizer *) recognizer {
    [_forgotPasswordViewBackground removeFromSuperview];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButton:(id)sender {
}

- (IBAction)forgetPasswordButton:(id)sender {
    [self.view addSubview:_forgotPasswordViewBackground];
}

- (IBAction)registerButton:(id)sender {
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
