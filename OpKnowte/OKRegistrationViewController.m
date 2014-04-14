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
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"

#define     REGISTER_USER                   @"http://knowte.esy.es/signUpUser"


@interface OKRegistrationViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *MDTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (strong, nonatomic) IBOutlet UIButton *continueButton;
@property (strong, nonatomic) IBOutlet UIPickerView *MDPiker;
@property (strong, nonatomic) NSArray *MDPickerData;
@property (nonatomic) BOOL animatedKeyboard;
@end

@implementation OKRegistrationViewController

#pragma mark - View methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    [self setNeedsStatusBarAppearanceUpdate];
    [self setAllDesign];
    _MDPickerData = [[NSArray alloc] initWithObjects:@"MD",@"DO",@"PA",@"RN",@"LPN",@"MA",@"NONE",nil];
    _nameTextField.text = @"";
    _emailTextField.text = @"";
    _MDTextField.text = [NSString stringWithFormat:@"%@", [_MDPickerData objectAtIndex:0]];
    _passwordTextField.text = @"";
    _confirmPasswordField.text = @"";
    
    _nameTextField.tag = 1;
    _emailTextField.tag = 2;
    _MDTextField.tag = 3;
    _passwordTextField.tag = 4;
    _confirmPasswordField.tag = 5;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(registrationUser)
                                                 name:@"AgreeToTerms"
                                               object:nil];


	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
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
    if (textField.tag >3 && !_animatedKeyboard){
        [self animateTextField: textField up: YES];
    } else if (textField.tag <=3 && _animatedKeyboard){
        [self animateTextField: textField up: NO];
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
//    if (textField.tag >3){
//        [self animateTextField: textField up: NO];
//    }
}
#pragma mark - Picker methods

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSUInteger numRows=[_MDPickerData count];
    return numRows;
}


-(NSAttributedString*) pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *pickerString = [NSString stringWithFormat:@"%@", [_MDPickerData objectAtIndex:row]];
    NSAttributedString *pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    return pickerAttributedString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
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
    
    if ([_nameTextField.text isEqual: @""] || [_passwordTextField.text isEqual: @""] || [_confirmPasswordField.text isEqual: @""] || [_emailTextField.text isEqual: @""]) {
        [OKRegistrationViewController showInfoAlertView:@"Error" withMessage:@"Please fill all fields"];
    }
    else if (!isEmailValidate) {
        [OKRegistrationViewController showInfoAlertView:@"Error" withMessage:@"Please enter valid email"];
    }
    else if (![_passwordTextField.text isEqualToString:_confirmPasswordField.text]) {
        [OKRegistrationViewController showInfoAlertView:@"Error" withMessage:@"Password and re-password should be same"];
    }
    else {

    [self registrationUser];
    }
}


-(void)registrationUser
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:_emailTextField.text/*@"jekahy343@gmail.com"*/ forKey:@"email"];
    [params setObject:_passwordTextField.text/*@"123456789"*/ forKey:@"password"];
//    [params setObject:_confirmPasswordField.text/*@"123456789"*/ forKey:@"password_confirmation"];
    [params setObject:_nameTextField.text /*@"123456789"*/ forKey:@"firstName"];
    
    
    NSError *error = nil;
    NSData *json = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    
    if (!error){
        AFHTTPClient *client = [OKApiClient sharedManager];
        NSString *path = [NSString stringWithFormat:@"http://knowte.esy.es/signUpUser"];
        NSMutableURLRequest *request = [client requestWithMethod:@"POST" path:path parameters:nil];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:json];
        [request setHTTPShouldHandleCookies:YES];
        
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            NSInteger success = [[JSON  objectForKey:@"success"]integerValue];
            NSString *message;
            if(success == 1){
                message = [NSString stringWithFormat:@"Registration successful: %@",[JSON objectForKey:@"message"]];
                message = @"Registration successful: Check your email and confirm registration.";
            }else{
                message = [NSString stringWithFormat:@"Registration unsuccessful: %@",[JSON objectForKey:@"errors"]];
            }
            
            UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"REGISTRATION" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            
            [av show];
        }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
            
            NSString* errMsg = nil;
            if (JSON != nil) {
                errMsg = [JSON  objectForKey:@"info"];
            } else {
                errMsg = [error localizedDescription];
            }
            UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"REGISTRATION" message:[NSString stringWithFormat:@"Registration unsuccessful. Try again later."] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [av show];
        }];
        
        [operation start];
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
    
    [self setDesignForTextField:_nameTextField Placeholder: @"your name..." Secured:NO DownArrow:NO];
    [self setDesignForTextField:_emailTextField Placeholder: @"your email..." Secured:NO DownArrow:NO];
    [self setDesignForTextField:_MDTextField Placeholder: @"MD" Secured:NO DownArrow:YES];
    [self setDesignForTextField:_passwordTextField Placeholder:@"your password..." Secured:YES DownArrow:NO];
    [self setDesignForTextField:_confirmPasswordField Placeholder:@"once again..." Secured:YES DownArrow:NO];
    
    _continueButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:74/255.0 blue:89/255.0 alpha:1];
    _continueButton.layer.cornerRadius = 14;
    _continueButton.clipsToBounds = YES;
    
}

-(void) setDesignForTextField:(UITextField*) textField  Placeholder:(NSString*) placeholder Secured:(BOOL) secured DownArrow:(BOOL) downArrow{
    
    
    UIImageView *textFieldIcon = [[UIImageView alloc] init];
    
    if ([placeholder isEqualToString:@"your name..."]) {
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
    
    
    UIView *textFieldDownArrowView = [[UIView alloc] init];
    if (downArrow) {
        UIImageView *textFieldDownArrow = [[UIImageView alloc] initWithFrame:CGRectMake(11, 3, 18, 11)] ;
        textFieldDownArrow.image = [UIImage imageNamed:@"down"];
        textFieldDownArrowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 18)];
        textFieldDownArrowView.backgroundColor = [UIColor clearColor];
        [textFieldDownArrowView addSubview:textFieldDownArrow];
        textField.rightView = textFieldDownArrowView;
        textField.rightViewMode = UITextFieldViewModeAlways;
    }
    
    
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
