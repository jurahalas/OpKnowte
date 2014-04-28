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
@property (nonatomic,retain) NSString *contactRoleID;
@property (nonatomic,retain) NSString *contactID;
@property (nonatomic,retain) NSString *updatedBy;
@property (nonatomic,retain) OKContactModel *contactInfo;



@end

@implementation OKInstituteVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    [self setAllDesign];
    
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
        if ([self.contactInfo contactID].length > 0) {
            
            [self.nameTextField setText:[self.contactInfo contactName]];
            [self.emailTextField setText:[self.contactInfo contactEmail]];
            [self.stateTextField setText:[self.contactInfo contactState]];
            [self.cityTextField setText:[self.contactInfo contactCity]];
            [self.countryTextField setText:[self.contactInfo contactCountry]];
            [self.faxTextField setText:[self.contactInfo contactFax]];
            [self.streerAddressTextField setText:[self.contactInfo contactStreetAddress]];
            [self.zipTextField setText:[self.contactInfo contactZip]];
            
        }
    }

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
    [[OKLoadingViewController instance] showWithText:@"Loading..."];

    [[OKContactManager instance] addContactWithName:_nameTextField.text roleID:@"4"  email:_emailTextField.text steetAddress:_streerAddressTextField.text city:_cityTextField.text state:_stateTextField.text zip:_zipTextField.text country:_countryTextField.text fax:_faxTextField.text updatedBy:[[OKUserManager instance] currentUser].userID handler:^(NSString *error){
        
        if (error != nil) {
            UIAlertView *addInstitutionFormErrorAlertView = [[UIAlertView alloc] initWithTitle:@"Add contact error" message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [addInstitutionFormErrorAlertView show];
            _saveButton.enabled = YES;
        } else {
            UIAlertView *addInstitutionFormSuccessAlertView = [[UIAlertView alloc] initWithTitle:@"Add institution Success" message:@"Congratulations! You added institution" delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
            [addInstitutionFormSuccessAlertView show];
            [self.view endEditing:YES];
            _saveButton.enabled = YES;
            [[OKLoadingViewController instance] hide];
        }
    }];

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
    NSInteger index = [self.elements indexOfObject:textField];
    [self scrollViewToOptimalPosition:index+1];
    if(index != self.elements.count-2){
        UITextField *nextField = (UITextField*)[self.elements objectAtIndex:index+1];
        [nextField becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}


- (void)scrollViewToOptimalPosition:(NSInteger)index
{
    CGRect scrollFrame = CGRectZero;
    
    if(index < self.elements.count-1){
        scrollFrame = ((UIView*)[self.elements objectAtIndex:2]).superview.frame;
    }else{
        scrollFrame = ((UIView*)[self.elements lastObject]).frame;
    }
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize: scrollFrame.size];
}

-(void) setAllDesign {
    
    [_nameTextField setCustomTextFieldPlaceholder: @"Name:" Secured:NO DownArrow:NO];
    [_streerAddressTextField setCustomTextFieldPlaceholder: @"Street Address:" Secured:NO DownArrow:NO];
    [_cityTextField setCustomTextFieldPlaceholder: @"City:" Secured:NO DownArrow:NO];
    [_stateTextField setCustomTextFieldPlaceholder: @"State:" Secured:NO DownArrow:NO];
    [_zipTextField setCustomTextFieldPlaceholder: @"Zip:" Secured:NO DownArrow:NO];
    [_countryTextField setCustomTextFieldPlaceholder: @"Country:" Secured:NO DownArrow:NO];
    [_emailTextField setCustomTextFieldPlaceholder: @"Email:" Secured:NO DownArrow:NO];
    [_faxTextField setCustomTextFieldPlaceholder: @"Fax:" Secured:NO DownArrow:NO];

    _saveButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _saveButton.layer.cornerRadius = 14;
    _saveButton.clipsToBounds = YES;
    
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


@end
