//
//  OKInstituteVC.m
//  OpKnowte
//
//  Created by Apple on 24.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKInstituteVC.h"
#import "OKContactManager.h"
#import "OKUserModel.h"
#import "OKContactModel.h"
#import "OKUserManager.h"
#import "OKDashboardVC.h"
#import "OKAccessSettingsCCViewController.h"

@interface OKInstituteVC ()

@property (strong, nonatomic) IBOutlet OKCustomTextField *nameTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *streerAddressTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *cityTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *stateTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *zipTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *countryTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *emailTextField;
@property (strong, nonatomic) IBOutlet OKCustomTextField *faxTextField;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic) BOOL animatedKeyboard;
@property (strong, nonatomic)  NSArray *elements;
@property (nonatomic) UITextField *activeTextField;
@property (strong, nonatomic) NSString *contactRoleID;
@property (strong, nonatomic) NSString *updatedBy;
@property (strong, nonatomic) OKContactModel *contactInfo;

- (IBAction)stateButtonTapped:(id)sender;
@property (strong, nonatomic) UIPickerView *statesPicker;
@property (strong, nonatomic) UIView *pickerBGView;
@property (strong, nonatomic) NSArray *statesData;





@end

@implementation OKInstituteVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    [self setAllDesign];
    self.title = self.contactID;
    [self setPickerDesign];
    if (_selectedContact != nil) {
        _nameTextField.text = _selectedContact.name;
        _streerAddressTextField.text = _selectedContact.contactStreetAddress;
        _cityTextField.text = _selectedContact.contactCity;
        _stateTextField.text = _selectedContact.contactState;
        _zipTextField.text = _selectedContact.contactZip;
        _countryTextField.text = _selectedContact.contactCountry;
        _emailTextField.text = _selectedContact.contactEmail;
        _faxTextField.text = _selectedContact.contactFax;


    }
    
    if ([self.title isEqualToString:@"1"]) {
        self.title =@"Surgeon";
    }else if ([self.title isEqualToString:@"2"]){
        self.title =@"Assistant";
    }else if ([self.title isEqualToString:@"3"]){
        self.title =@"Anesthesiologist";
    }else if ([self.title isEqualToString:@"4"]){
        self.title =@"Institution";
    }else if ([self.title isEqualToString:@"5"]){
        self.title =@"Physician";
    }else if([self.title isEqualToString:@"6"]){
        self.title=@"Other";
    }
    
    _nameTextField.tag = 1;
    _streerAddressTextField.tag = 2;
    _cityTextField.tag = 3;
    _stateTextField.tag = 4;
    _zipTextField.tag = 5;
    _countryTextField.tag = 6;
    _emailTextField.tag = 7;
    _faxTextField.tag = 8;
    
    _statesData = [[NSArray alloc] initWithObjects:
                   @"Alabama",
                   @"Arkansas",
                   @"Arizona",
                   @"California",
                   @"Colorado",
                   @"Connecticut",
                   @"District of Columbia",
                   @"Delaware",
                   @"Florida",
                   @"Georgia",
                   @"Hawaii",
                   @"Iowa",
                   @"Idaho",
                   @"Illinois",
                   @"Indiana",
                   @"Kansas",
                   @"Kentucky",
                   @"Louisiana",
                   @"Massachusetts",
                   @"Maryland",
                   @"Maine",
                   @"Michigan",
                   @"Minnesota",
                   @"Missouri",
                   @"Mississippi",
                   @"Montana",
                   @"North Carolina",
                   @"North Dakota",
                   @"Nebraska",
                   @"New Hampshire",
                   @"New Jersey",
                   @"New Mexico",
                   @"Nevada",
                   @"New York",
                   @"Ohio",
                   @"Oklahoma",
                   @"Oregon",
                   @"Pennsylvania",
                   @"Rhode Island",
                   @"South Carolina",
                   @"South Dakota",
                   @"Tennessee",
                   @"Texas",
                   @"Utah",
                   @"Virginia",
                   @"Vermont",
                   @"Washington",
                   @"Wisconsin",
                   @"West Virginia",
                   @"Wyoming",
                   nil];
    self.elements = @[_nameTextField,_streerAddressTextField,_cityTextField ,_stateTextField,_zipTextField,_countryTextField,_emailTextField,_faxTextField,_saveButton];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    [self addBottomTabBar];
    if (self.contactInfo != nil) {
        if ([self.contactInfo identifier].length > 0) {
            
            [self.nameTextField setText:[self.contactInfo name]];
            [self.emailTextField setText:[self.contactInfo contactEmail]];
            [self.stateTextField setText:[self.contactInfo contactState]];
            [self.cityTextField setText:[self.contactInfo contactCity]];
            [self.countryTextField setText:[self.contactInfo contactCountry]];
            [self.faxTextField setText:[self.contactInfo contactFax]];
            [self.streerAddressTextField setText:[self.contactInfo contactStreetAddress]];
            [self.zipTextField setText:[self.contactInfo contactZip]];
            
        }
    }
    if (!IS_IOS7) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
}

-(void) setPickerDesign {
    float yPoint;
    if (IS_IPHONE_5 ) {
        yPoint = 355;
    } else {
        yPoint = 318;
    }
    
    _pickerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, yPoint, 320, 162)];
    _pickerBGView.backgroundColor = [UIColor colorWithRed:24/255. green:59/255. blue:85/255. alpha:.90];
    self.statesPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 162)];
    self.statesPicker.delegate = self;
    self.statesPicker.dataSource = self;
    [self.view addSubview:_pickerBGView];
    [_pickerBGView addSubview:_statesPicker];
    _pickerBGView.hidden = YES;
    
}


-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width+27, [UIImage imageNamed:@"back"].size.height );
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
        [self scrollViewToOptimalPosition:[self.elements indexOfObject:self.activeTextField]];    } completion:nil];
}


- (void)keyboardWillHide:(NSNotification *)n
{
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
    }];
}


#pragma mark - IBActions
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)saveButton:(id)sender
{
    if ([self.contactID isEqualToString:@"2"] || [self.contactID isEqualToString:@"3"]) {
        
        [[OKLoadingViewController instance] showWithText:@"Loading..."];
        
        if ([_nameTextField.text isEqual: @""] ){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please name field" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [[OKLoadingViewController instance] hide];
            
        }else{
            
            [[OKContactManager instance] addContactWithName:_nameTextField.text roleID:_contactID  email:_emailTextField.text steetAddress:_streerAddressTextField.text city:_cityTextField.text state:_stateTextField.text zip:_zipTextField.text country:_countryTextField.text fax:_faxTextField.text updatedBy:[OKUserManager instance].currentUser.identifier handler:^(NSString *error){
                
                if(error != nil){
                    
                    UIAlertView *addInstitutionFormErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Add contact error" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [addInstitutionFormErrorAlertView show];
                    _saveButton.enabled = YES;
                    [[OKLoadingViewController instance] hide];
                    
                }else{
                    if (_selectedContact != nil) {
                        UIAlertView *addInstitutionFormSuccessAlertView = [[UIAlertView alloc] initWithTitle:@"Update institution Success" message:@"Congratulations! Contact was updated successfully" delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
                        [addInstitutionFormSuccessAlertView show];
                        NSString *selectedContactID = _selectedContact.identifier;
                        OKContactManager *manager = [OKContactManager instance];
                        [manager deleteContactWithContactID:selectedContactID handler:^(NSString *errorMsg) {
                            if (!errorMsg) {
                                
                            }
                            
                        }];
                    } else {
                        UIAlertView *addInstitutionFormSuccessAlertView = [[UIAlertView alloc] initWithTitle:@"Add institution Success" message:@"Congratulations! You added new contact" delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
                        [addInstitutionFormSuccessAlertView show];
                    }

                    [self.view endEditing:YES];
                    _saveButton.enabled = YES;
                    [[OKLoadingViewController instance] hide];
                }
            }];
        }
             
    }else if ([self.contactID isEqualToString:@"4"]){
    
        [[OKLoadingViewController instance] showWithText:@"Loading..."];
        
        BOOL isEmailValidate = [OKInstituteVC validateEmail:_emailTextField.text];
        
        if ([_nameTextField.text isEqualToString: @""] || [_emailTextField.text isEqualToString:@""] || [_faxTextField.text isEqualToString:@""]){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill all fields" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [[OKLoadingViewController instance] hide];
        }else if (!isEmailValidate) {
            [OKInstituteVC showInfoAlertView:@"Error" withMessage:@"Please enter valid email"];
        }else if ([_faxTextField.text length]<5){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Fax-field should be at least 5 symbols" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [[OKLoadingViewController instance] hide];
        }else{
            [[OKContactManager instance] addContactWithName:_nameTextField.text roleID:_contactID  email:_emailTextField.text steetAddress:_streerAddressTextField.text city:_cityTextField.text state:_stateTextField.text zip:_zipTextField.text country:_countryTextField.text fax:_faxTextField.text updatedBy:[OKUserManager instance].currentUser.identifier handler:^(NSString *error){
                
                if(error != nil){
                    
                    UIAlertView *addInstitutionFormErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Add contact error" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [addInstitutionFormErrorAlertView show];
                    _saveButton.enabled = YES;
                    [[OKLoadingViewController instance] hide];
                    
                }else{
                    if (_selectedContact != nil) {
                        UIAlertView *addInstitutionFormSuccessAlertView = [[UIAlertView alloc] initWithTitle:@"Update institution Success" message:@"Congratulations! Contact was updated successfully" delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
                        [addInstitutionFormSuccessAlertView show];
                        NSString *selectedContactID = _selectedContact.identifier;
                        OKContactManager *manager = [OKContactManager instance];
                        [manager deleteContactWithContactID:selectedContactID handler:^(NSString *errorMsg) {
                            if (!errorMsg) {
                                
                            }
                            
                        }];
                    } else {
                        UIAlertView *addInstitutionFormSuccessAlertView = [[UIAlertView alloc] initWithTitle:@"Add institution Success" message:@"Congratulations! You added new contact" delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
                        [addInstitutionFormSuccessAlertView show];
                    }
                    
                    [self.view endEditing:YES];
                    _saveButton.enabled = YES;
                    [[OKLoadingViewController instance] hide];
                }
            }];
        }

    }else{
        
    [[OKLoadingViewController instance] showWithText:@"Loading..."];

    BOOL isEmailValidate = [OKInstituteVC validateEmail:_emailTextField.text];
        
    if ([_nameTextField.text isEqual: @""] || [_emailTextField.text isEqual: @""] || [_streerAddressTextField.text isEqual: @""] || [_cityTextField.text isEqual: @""] || [_stateTextField.text isEqual: @""] || [_zipTextField.text isEqual: @""] || [_countryTextField.text isEqual: @""] || [_faxTextField.text isEqual: @""]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill all fields" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [[OKLoadingViewController instance] hide];
    }else if (!isEmailValidate) {
        [OKInstituteVC showInfoAlertView:@"Error" withMessage:@"Please enter valid email"];
    }else if ([_faxTextField.text length]<5){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Fax-field should be at least 5 symbols" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [[OKLoadingViewController instance] hide];
    }else{
        [[OKContactManager instance] addContactWithName:_nameTextField.text roleID:_contactID  email:_emailTextField.text steetAddress:_streerAddressTextField.text city:_cityTextField.text state:_stateTextField.text zip:_zipTextField.text country:_countryTextField.text fax:_faxTextField.text updatedBy:[OKUserManager instance].currentUser.identifier handler:^(NSString *error){
            
            if(error != nil){
                
                UIAlertView *addInstitutionFormErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Add contact error" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [addInstitutionFormErrorAlertView show];
                _saveButton.enabled = YES;
                [[OKLoadingViewController instance] hide];
                
            }else{
                if (_selectedContact != nil) {
                    UIAlertView *addInstitutionFormSuccessAlertView = [[UIAlertView alloc] initWithTitle:@"Update institution Success" message:@"Congratulations! Contact was updated successfully" delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
                    [addInstitutionFormSuccessAlertView show];
                    NSString *selectedContactID = _selectedContact.identifier;
                    OKContactManager *manager = [OKContactManager instance];
                    [manager deleteContactWithContactID:selectedContactID handler:^(NSString *errorMsg) {
                        if (!errorMsg) {
                            
                        }
                        
                    }];
                } else {
                    UIAlertView *addInstitutionFormSuccessAlertView = [[UIAlertView alloc] initWithTitle:@"Add institution Success" message:@"Congratulations! You added new contact" delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
                    [addInstitutionFormSuccessAlertView show];
                }
               
                [self.view endEditing:YES];
                _saveButton.enabled = YES;
                [[OKLoadingViewController instance] hide];
            }
        }];
    }
    }
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
                [[OKLoadingViewController instance]hide];
                return TRUE;
            }
        }
    }
    [[OKLoadingViewController instance]hide];
    return FALSE;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([alertView.message isEqualToString:@"Congratulations! You added new contact"] || [alertView.message isEqualToString:@"Congratulations! Contact was updated successfully"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        if ([_cameFromVC isEqualToString:@"FacilityVC"]) {
//            [self.navigationController popViewControllerAnimated:YES ];
        } else if ([_cameFromVC isEqualToString:@"ContactsVC"]) {
            [self performSegueWithIdentifier:@"backToDashboard" sender:self];
        }else if ([_cameFromVC isEqualToString:@"AccessSettingsCCViewController"]){
//            [self.navigationController popViewControllerAnimated:YES];
        }else if ([_cameFromVC isEqualToString:@"ContactListVC"]){
//            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([_faxTextField.text length] > 9) {
        _faxTextField.text = [_faxTextField.text substringToIndex:9];
        return NO;
    }
    return YES;
}



#pragma mark  - textField delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self scrollViewToOptimalPosition:[self.elements indexOfObject:textField]];
    self.activeTextField = textField;
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UIResponder* nextResponder = [textField.superview viewWithTag:(textField.tag + 1)];
    if (textField.tag != _cityTextField.tag) {
        [textField resignFirstResponder];
        [nextResponder becomeFirstResponder];
    } else
        if (textField.tag == _cityTextField.tag){
        _pickerBGView.hidden = NO;
        [textField resignFirstResponder];
    } else {
        [textField resignFirstResponder];
        [self animateTextField: textField up: NO];
    }
    return YES;

}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up {
    
    int y;
    if (IS_IPHONE_5) {
        y = 70;
    }else {
        y = 158;
    }
    
    const int movementDistance = y;// tweak as needed
    
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

- (void)textFieldDidBeginEditing:(UITextField *)textField {

    if (textField.tag == _faxTextField.tag) {
        textField.returnKeyType = UIReturnKeyDone;
    } else {
        textField.returnKeyType = UIReturnKeyNext;
    }
    
    if(textField.tag == _stateTextField.tag) {
        [self.view endEditing:YES];
        _pickerBGView.hidden = NO;
        [_stateTextField resignFirstResponder];
    } else {
        _pickerBGView.hidden = YES;
    }
}


- (void)scrollViewToOptimalPosition:(NSInteger)index
{
    if ([[UIScreen mainScreen] bounds].size.height == 568) //iphone 5/5c/5s
    {
        [self.scrollView setContentSize:CGSizeMake(320, self.view.bounds.size.height-64)];
        self.scrollView.frame = CGRectMake(0, 64, 320, self.view.bounds.size.height-64);
       
        if([[UIDevice currentDevice].systemVersion hasPrefix:@"6"]){ //iOS 6.1 <
        
            self.scrollView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height-64);
        }
    }
    else //iphone 4/4s
    {
        [self.scrollView setContentSize:CGSizeMake(320, self.view.bounds.size.height+64)];
        if([[UIDevice currentDevice].systemVersion hasPrefix:@"7"]) //iOS 7.0 >
        {
            self.scrollView.frame = CGRectMake(0, 64, 320, self.view.bounds.size.height-64);
        }
        else //iOS 6.1 <
        {
            self.scrollView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height-64);
        }
    }
}

-(void) setAllDesign {
    
    _nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name:" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    _streerAddressTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Street Address:" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    _cityTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"City:" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    _stateTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"State:" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    _zipTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Zip:" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    _countryTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Country:" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    _emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email:" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    _faxTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Fax:" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    [_stateTextField setCustomTextFieldPlaceholder: @"State" Secured:NO DownArrow:YES];


    _saveButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _saveButton.layer.cornerRadius = 14;
    _saveButton.clipsToBounds = YES;    
}

#pragma mark - Picker methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSUInteger numRows=[_statesData count];
    return numRows;
    
}

-(NSAttributedString*) pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    UIColor *color = [UIColor whiteColor];
    if (IS_IOS6) {
        color = [UIColor blackColor];
    }
    NSString *pickerString = [NSString stringWithFormat:@"%@", [_statesData objectAtIndex:row]];
    NSAttributedString *pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: color}];
    return pickerAttributedString;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    _stateTextField.text = [NSString stringWithFormat:@"%@", [_statesData objectAtIndex:row]];
    _pickerBGView.hidden = YES;
    
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    [self.scrollView scrollsToTop];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


- (IBAction)stateButtonTapped:(id)sender {
    if (_pickerBGView.hidden) {
        [self.view endEditing:YES];
        if (_animatedKeyboard) {
            [self animateTextField: _zipTextField up: NO];
        }
    }
    _pickerBGView.hidden = !_pickerBGView.hidden;
    
}
@end
