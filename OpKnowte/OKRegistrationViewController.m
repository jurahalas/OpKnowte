//
//  OKRegistrationViewController.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/9/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKRegistrationViewController.h"
#import "OKBaseManager.h"
#import "OKApiClient.h"
#import "OKUserManager.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "OKLoadingViewController.h"

@interface OKRegistrationViewController ()
@property (strong, nonatomic) IBOutlet OKCustomTextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *emailTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *MDTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *passwordTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *confirmPasswordField;
@property (strong, nonatomic) IBOutlet UIButton *continueButton;
@property (strong, nonatomic) IBOutlet UIPickerView *MDPiker;
@property (strong, nonatomic) NSArray *MDPickerData;
@property (nonatomic) BOOL animatedKeyboard;
@end

@implementation OKRegistrationViewController

#pragma mark - View methods

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    [self setAllDesign];
    
    _MDPickerData = [[NSArray alloc] initWithObjects:@"MD",@"DO",@"PA",@"RN",@"LPN",@"MA",@"NONE",nil];
    _firstNameTextField.text = @"";
    _lastNameTextField.text = @"";
    _emailTextField.text = @"";
    _MDTextField.text = @"";
    _passwordTextField.text = @"";
    _confirmPasswordField.text = @"";
    
    _firstNameTextField.tag = 1;
    _lastNameTextField.tag = 2;
    _emailTextField.tag = 3;
    _MDTextField.tag = 4;
    _passwordTextField.tag = 5;
    _confirmPasswordField.tag = 6;

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    
}

#pragma mark - textField methods

- (void) animateTextField: (UITextField*) textField up: (BOOL) up {
    
    const int movementDistance = 70;// tweak as needed
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
    
    UIResponder* nextResponder = [textField.superview viewWithTag:(textField.tag + 1)];
    if (textField.tag != _confirmPasswordField.tag && textField.tag != _emailTextField.tag) {
        [textField resignFirstResponder];
        [nextResponder becomeFirstResponder];
    } else if (textField.tag == _emailTextField.tag){
        _MDPiker.hidden = NO;
        [textField resignFirstResponder];
    } else {
        [textField resignFirstResponder];
        [self animateTextField: textField up: NO];
    }
    return YES;

}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField.tag == _confirmPasswordField.tag) {
        textField.returnKeyType = UIReturnKeyDone;
    } else {
        textField.returnKeyType = UIReturnKeyNext;
    }
    
    if(textField.tag == _MDTextField.tag) {
        [self.view endEditing:YES];
        _MDPiker.hidden = NO;
        [_MDTextField resignFirstResponder];
    } else {
        _MDPiker.hidden = YES;
    }
    if (textField.tag >4 && !_animatedKeyboard){
        [self animateTextField: textField up: YES];
    } else if (textField.tag <=4 && _animatedKeyboard){
        [self animateTextField: textField up: NO];
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [textField resignFirstResponder];

}

#pragma mark - Picker methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSUInteger numRows=[_MDPickerData count];
    return numRows;
    
}

-(NSAttributedString*) pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *pickerString = [NSString stringWithFormat:@"%@", [_MDPickerData objectAtIndex:row]];
    NSAttributedString *pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    return pickerAttributedString;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    _MDTextField.text = [NSString stringWithFormat:@"%@", [_MDPickerData objectAtIndex:row]];
    
}

#pragma mark - IBActions

- (IBAction)MDButton:(id)sender {
    
    _MDPiker.hidden = NO;
    [self.view endEditing:YES];
    if (_animatedKeyboard) {
        [self animateTextField: _confirmPasswordField up: NO];
    }
}


- (IBAction)continueButton:(id)sender
{
    BOOL isEmailValidate = [OKRegistrationViewController validateEmail:_emailTextField.text];
    
    if ([_firstNameTextField.text isEqual: @""] || [_passwordTextField.text isEqual: @""] || [_confirmPasswordField.text isEqual: @""] || [_emailTextField.text isEqual: @""]
        || [_MDTextField.text isEqual: @""] || [_lastNameTextField.text isEqual: @""]) {
        [OKRegistrationViewController showInfoAlertView:@"Error" withMessage:@"Please fill all fields"];
    }
    else if (!isEmailValidate) {
        [OKRegistrationViewController showInfoAlertView:@"Error" withMessage:@"Please enter valid email"];
    }
    else if (![_passwordTextField.text isEqualToString:_confirmPasswordField.text]) {
        [OKRegistrationViewController showInfoAlertView:@"Error" withMessage:@"Password and re-password should be same"];
    }
    else {
        [[OKLoadingViewController instance] showWithText:@"Loading..."];
         _continueButton.enabled = NO;
        [[OKUserManager instance] signupWithFirstName:_firstNameTextField.text lastName:_lastNameTextField.text userEmail:_emailTextField.text password:_passwordTextField.text userTitle:_MDTextField.text handler:^(NSString *error) {
           
            if (error != nil) {
                UIAlertView *signUpFormErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Sign up error" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [signUpFormErrorAlertView show];
                _continueButton.enabled = YES;
                [[OKLoadingViewController instance] hide];

            } else {
                [[OKLoadingViewController instance] showWithText:@"Loading..."];
                
                UIAlertView *signUpFormSuccessAlertView = [[UIAlertView alloc] initWithTitle:@"Sign up Success"
                                                                                     message:@"Congratulations! You are signed up."
                                                                                    delegate:self
                                                                           cancelButtonTitle:@"OK"
                                                                           otherButtonTitles:nil, nil];
                [signUpFormSuccessAlertView show];
                [self.view endEditing:YES];
                
                [self performSegueWithIdentifier:@"registrationSegue" sender:self];
                _continueButton.enabled = YES;
                [[OKLoadingViewController instance] hide];
            }
        }];
    }
}

- (IBAction)navBarBackButton:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


+ (void)showInfoAlertView:(NSString *)title withMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    alert = nil;
}

+ (BOOL)validateEmail:(NSString *)inputText {
    NSString *emailRegex = @"[A-Z0-9a-z][A-Z0-9a-z._%+-]*@[A-Za-z0-9][A-Za-z0-9.-]*\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSRange aRange;
    if([emailTest evaluateWithObject:inputText]) {
        aRange = [inputText rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(0, [inputText length])];
        int indexOfDot = aRange.location;
        
        if(aRange.location != NSNotFound) {
            NSString *topLevelDomain = [inputText substringFromIndex:indexOfDot];
            topLevelDomain = [topLevelDomain lowercaseString];
            NSSet *TLD;
            TLD = [NSSet setWithObjects:@".aero", @".asia", @".biz", @".cat", @".com", @".coop", @".edu", @".gov", @".info", @".int", @".jobs", @".mil", @".mobi", @".museum", @".name", @".net", @".org", @".pro", @".tel", @".travel", @".ac", @".ad", @".ae", @".af", @".ag", @".ai", @".al", @".am", @".an", @".ao", @".aq", @".ar", @".as", @".at", @".au", @".aw", @".ax", @".az", @".ba", @".bb", @".bd", @".be", @".bf", @".bg", @".bh", @".bi", @".bj", @".bm", @".bn", @".bo", @".br", @".bs", @".bt", @".bv", @".bw", @".by", @".bz", @".ca", @".cc", @".cd", @".cf", @".cg", @".ch", @".ci", @".ck", @".cl", @".cm", @".cn", @".co", @".cr", @".cu", @".cv", @".cx", @".cy", @".cz", @".de", @".dj", @".dk", @".dm", @".do", @".dz", @".ec", @".ee", @".eg", @".er", @".es", @".et", @".eu", @".fi", @".fj", @".fk", @".fm", @".fo", @".fr", @".ga", @".gb", @".gd", @".ge", @".gf", @".gg", @".gh", @".gi", @".gl", @".gm", @".gn", @".gp", @".gq", @".gr", @".gs", @".gt", @".gu", @".gw", @".gy", @".hk", @".hm", @".hn", @".hr", @".ht", @".hu", @".id", @".ie", @" No", @".il", @".im", @".in", @".io", @".iq", @".ir", @".is", @".it", @".je", @".jm", @".jo", @".jp", @".ke", @".kg", @".kh", @".ki", @".km", @".kn", @".kp", @".kr", @".kw", @".ky", @".kz", @".la", @".lb", @".lc", @".li", @".lk", @".lr", @".ls", @".lt", @".lu", @".lv", @".ly", @".ma", @".mc", @".md", @".me", @".mg", @".mh", @".mk", @".ml", @".mm", @".mn", @".mo", @".mp", @".mq", @".mr", @".ms", @".mt", @".mu", @".mv", @".mw", @".mx", @".my", @".mz", @".na", @".nc", @".ne", @".nf", @".ng", @".ni", @".nl", @".no", @".np", @".nr", @".nu", @".nz", @".om", @".pa", @".pe", @".pf", @".pg", @".ph", @".pk", @".pl", @".pm", @".pn", @".pr", @".ps", @".pt", @".pw", @".py", @".qa", @".re", @".ro", @".rs", @".ru", @".rw", @".sa", @".sb", @".sc", @".sd", @".se", @".sg", @".sh", @".si", @".sj", @".sk", @".sl", @".sm", @".sn", @".so", @".sr", @".st", @".su", @".sv", @".sy", @".sz", @".tc", @".td", @".tf", @".tg", @".th", @".tj", @".tk", @".tl", @".tm", @".tn", @".to", @".tp", @".tr", @".tt", @".tv", @".tw", @".tz", @".ua", @".ug", @".uk", @".us", @".uy", @".uz", @".va", @".vc", @".ve", @".vg", @".vi", @".vn", @".vu", @".wf", @".ws", @".ye", @".yt", @".za", @".zm", @".zw", nil];
            
            if(topLevelDomain != nil && ([TLD containsObject:topLevelDomain])) {
                return TRUE;
            }
        }
    }
    return FALSE;
}


#pragma mark - design

-(void) setAllDesign {
    
    [_firstNameTextField setCustomTextFieldPlaceholder: @"First name" Secured:NO DownArrow:NO];
    [_lastNameTextField setCustomTextFieldPlaceholder: @"Last name" Secured:NO DownArrow:NO];
    [_emailTextField setCustomTextFieldPlaceholder: @"Your email..." Secured:NO DownArrow:NO];
    [_MDTextField setCustomTextFieldPlaceholder: @"MD" Secured:NO DownArrow:YES];
    [_passwordTextField setCustomTextFieldPlaceholder:@"Enter password..." Secured:YES DownArrow:NO];
    [_confirmPasswordField setCustomTextFieldPlaceholder:@"Re-enter password..." Secured:YES DownArrow:NO];

    _continueButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _continueButton.layer.cornerRadius = 14;
    _continueButton.clipsToBounds = YES;

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoNB"]];
}

@end
