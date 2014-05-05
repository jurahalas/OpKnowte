//
//  OKViewController.m
//  OpKnowte
//
//  Created by Eugene on 09.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKViewController.h"
#import "OKLoadingViewController.h"

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

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setAllDesign];
    [self.navigationController setNavigationBarHidden:YES animated:YES ];
//    _passwordTextField.text = @"";
//    _emailTextField.text = @"";
}


-(void) viewWillAppear:(BOOL)animated {
    
     [self.navigationController setNavigationBarHidden:YES animated:YES ];
}


-(void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if([defaults objectForKey:@"EMAILADDRESS"]!=nil  && ![[defaults objectForKey:@"EMAILADDRESS"] isEqualToString:@""]){
        [self performSegueWithIdentifier:@"dashboardSegue" sender:self];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
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
    
    OKUserManager *usermanager = [OKUserManager instance];
   
    if ([_emailTextField.text  isEqual: @""] || [_passwordTextField.text  isEqual: @""]) {
        UIAlertView *loginFormAlertView = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Please complete all fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [loginFormAlertView show];
    }else {
        [[OKLoadingViewController instance] showWithText:@"Loading..."];

        _loginButton.enabled = NO;
        [usermanager signinWithEmail:_emailTextField.text password:_passwordTextField.text handler:^(NSString* error){
            if (error != nil) {
                UIAlertView *loginFormErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Login Error" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [loginFormErrorAlertView show];
                _loginButton.enabled = YES;
               
            } else {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:_emailTextField.text forKey:@"EMAILADDRESS"];
                [defaults setObject:_passwordTextField.text forKey:@"PASSWORD"];
                [defaults synchronize];
                
                UIAlertView *loginFormSuccessAlertView = [[UIAlertView alloc] initWithTitle:@"Login Success" message:@"Congratulations! You are logged in." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [loginFormSuccessAlertView show];
                [self.view endEditing:YES];
                [self performSegueWithIdentifier:@"loginSegue" sender:self];
                _loginButton.enabled = YES;
            }
            [[OKLoadingViewController instance] hide];
        }];
    }

}

- (IBAction)forgetPasswordButton:(id)sender {
    
    UIAlertView *customAlertView = [[UIAlertView alloc] initWithTitle:@"Restore Password" message:@"Please confirm your Email Address.\rWe will send you your password." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Send", nil];
    customAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [customAlertView textFieldAtIndex:0].placeholder = @"Email";
    [customAlertView textFieldAtIndex:0].text = @"frolow.artem@gmail.com";
    [customAlertView show];
    
}

- (IBAction)registerButton:(id)sender {

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    if (buttonIndex == 0) {
        NSLog(@"THE 'Cancel' BUTTON WAS PRESSED");
//        OKContactManager *contactManager = [OKContactManager instance];
//        [contactManager addContactWithRoleID:@"1" name:@"Johny Cage" email:@"jonhy.cage@gmail.com" steetAddress:@"qqqqqqq" city:@"qqqqqq" state:@"qqqqqqq" zip:@"qqqqqqqq" country:@"qqqqqqqq" fax:@"qqqqqqqq" contactID:@"0" updatedBy:@"130"/*[[NSUserDefaults standardUserDefaults] objectForKey:@"loginedUserID"]*/ handler:^(NSString* error){
//            if (error != nil) {
//                NSLog(@"Error add - %@",error);
//            } else {
//
//            }
//        }];
//
//        [contactManager deleteContactWithContactID:@"149" handler:^(NSString* error){
//            if (error != nil) {
//                NSLog(@"Error delete - %@",error);
//            } else {
//                
//            }
//        }];
//        [contactManager getContactsByUserID:@"130" roleID:@"1" handler:^(NSString* error){
//            if (error != nil) {
//                NSLog(@"Error  get - %@",error);
//            } else {
//                
//            }
//        }];
    }
    if (buttonIndex == 1) {
        if ([alertView.title isEqualToString:@"Restore Password"]) {
            OKUserManager *usermanager = [OKUserManager instance];
            [usermanager recoverPasswordWithEmail:[alertView textFieldAtIndex:0].text handler:^(NSString* error){
                NSLog(@"error - %@", error);
            }];
        } else {
            NSLog(@"THE 'Second' BUTTON WAS PRESSED");
        }
    }
    
}

#pragma mark - design

-(void) setAllDesign {
    
    [_emailTextField setCustomTextFieldPlaceholder:@"Email" Secured:NO DownArrow:NO];
    [_passwordTextField setCustomTextFieldPlaceholder:@"Password" Secured:YES DownArrow:NO];
    
    _loginButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _loginButton.layer.cornerRadius = 14;
    _loginButton.clipsToBounds = YES;
    
}

@end
