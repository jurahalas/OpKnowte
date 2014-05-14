//
//  OKChangePasswordViewController.m
//  OpKnowte
//
//  Created by Olegek on 02.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKChangePasswordViewController.h"

@interface OKChangePasswordViewController ()
@property (strong, nonatomic) IBOutlet UIButton *updatePasswordButton;
@property (strong, nonatomic) IBOutlet OKCustomTextField *theOldPasswordTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *theNewPasswordTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *theConfirmPasswordTextField;
@property (nonatomic) BOOL animatedKeyboard;

@end

@implementation OKChangePasswordViewController
@synthesize updatePasswordButton,theOldPasswordTextField,theNewPasswordTextField,theConfirmPasswordTextField,animatedKeyboard;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    
    [self design];
    
    theOldPasswordTextField.text = nil;
    theNewPasswordTextField.text = nil;
    theConfirmPasswordTextField.text = nil;
    
    theOldPasswordTextField.tag = 1;
    theNewPasswordTextField.tag = 2;
    theConfirmPasswordTextField.tag = 3;
}


- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    if (up) {
        animatedKeyboard = YES;
    } else {
        animatedKeyboard = NO;
    }
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UIResponder* nextResponder = [textField.superview viewWithTag:(textField.tag + 1)];
    if (textField.tag != theConfirmPasswordTextField.tag ) {
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
    if (textField.tag == theConfirmPasswordTextField.tag) {
        textField.returnKeyType = UIReturnKeyDone;
    } else {
        textField.returnKeyType = UIReturnKeyNext;
    }
        if (textField.tag <=3 && animatedKeyboard){
        [self animateTextField: textField up: NO];
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}


-(void)design{

    theOldPasswordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Old Password" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
     theNewPasswordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"New Password" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
     theConfirmPasswordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    
    updatePasswordButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    updatePasswordButton.layer.cornerRadius = 14;
    
}


- (IBAction)backButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}


- (IBAction)updatePasswordButton:(id)sender
{
    NSLog(@" psss %@", [OKUserManager instance].currentUser.password);
    
    if ([theOldPasswordTextField.text isEqual: @""] || [theNewPasswordTextField.text isEqual: @""] || [theConfirmPasswordTextField.text isEqual: @""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill all fields" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }else if (![theNewPasswordTextField.text isEqualToString:theConfirmPasswordTextField.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your password was not changed" message:@"New password and confirm new password did not match" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }else if (![theOldPasswordTextField.text isEqualToString:[OKUserManager instance].currentUser.password]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid current password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [[OKLoadingViewController instance] showWithText:@"Loading..."];

        [[OKUserManager instance] changePasswordWithUserID:[OKUserManager instance].currentUser.identifier password:theConfirmPasswordTextField.text  handler:^(NSString* error){
        if (error != nil) {
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Change password error" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [errorAlert show];
            updatePasswordButton.enabled = YES;
            
        } else {
            UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"Change password Success" message:@"Congratulations! You have change the password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [successAlert show];
            [self.view endEditing:YES];
            [self performSegueWithIdentifier:@"backToDashboard" sender:self];
            updatePasswordButton.enabled = YES;
            [[OKLoadingViewController instance] hide];
        }
        }];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
