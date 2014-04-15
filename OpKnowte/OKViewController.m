//
//  OKViewController.m
//  OpKnowte
//
//  Created by Eugene on 09.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKViewController.h"

@interface OKViewController ()
@property (strong, nonatomic) IBOutlet OKCustomTextField *emailTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *forgotPasswordButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
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



#pragma mark - IBActions
- (IBAction)loginButton:(id)sender {
    
    OKUserManager *usermanager = [OKUserManager sharedManager];
//    [usermanager signinWithEmail:@"f_zhenya@i.ua" password:@"12341234" handler:^(NSString* error){
//        NSLog(@"error - %@", error);
//    }];
    [usermanager signinWithEmail:@"myname@i.ua" password:@"1234" handler:^(NSString* error){
        NSLog(@"error - %@", error);
    }];
    
}

- (IBAction)forgetPasswordButton:(id)sender {
    UIAlertView *customAlertView = [[UIAlertView alloc] initWithTitle:@"Restore Password" message:@"Please confirm your Email Address.\rWe will send you your password." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send", nil];
    customAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [customAlertView textFieldAtIndex:0].placeholder = @"Email";
    [customAlertView show];
}

- (IBAction)registerButton:(id)sender {

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"THE 'Cancel' BUTTON WAS PRESSED");
    }
    if (buttonIndex == 1) {
        NSLog(@"THE 'Send' BUTTON WAS PRESSED");
        OKUserManager *usermanager = [OKUserManager sharedManager];
        [usermanager recoverPasswordWithEmail:@"frolow.artem@gmail.com" handler:^(NSString* error){
            NSLog(@"error - %@", error);
        }];
    }
}

#pragma mark - design
-(void) setAllDesign {
    
    [_emailTextField setCustomTextFieldPlaceholder:@"Email" Secured:NO DownArrow:NO];
    [_passwordTextField setCustomTextFieldPlaceholder:@"Password" Secured:YES DownArrow:NO];
    
    _loginButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:74/255.0 blue:89/255.0 alpha:1];
    _loginButton.layer.cornerRadius = 14;
    _loginButton.clipsToBounds = YES;
    
}




@end
