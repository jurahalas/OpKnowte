//
//  OKRegistrationViewController.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/9/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKRegistrationViewController.h"

@interface OKRegistrationViewController ()
@property (strong, nonatomic) IBOutlet OKCustomTextField *nameTextField;
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    
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
    UIColor *pickerFontColor = [[UIColor alloc] init];
    if (IS_IOS7) {
        pickerFontColor = [UIColor whiteColor];
    } else {
        pickerFontColor = [UIColor blackColor];
    }
    NSString *pickerString = [NSString stringWithFormat:@"%@", [_MDPickerData objectAtIndex:row]];
    NSAttributedString *pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: pickerFontColor}];
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

- (IBAction)continueButton:(id)sender {
}
- (IBAction)navBarBackButton:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - design
-(void) setAllDesign {
    
    [_nameTextField setCustomTextFieldPlaceholder: @"your name..." Secured:NO DownArrow:NO];
    [_emailTextField setCustomTextFieldPlaceholder: @"your email..." Secured:NO DownArrow:NO];
    [_MDTextField setCustomTextFieldPlaceholder: @"MD" Secured:NO DownArrow:YES];
    [_passwordTextField setCustomTextFieldPlaceholder:@"your password..." Secured:YES DownArrow:NO];
    [_confirmPasswordField setCustomTextFieldPlaceholder:@"once again..." Secured:YES DownArrow:NO];
    

    
    
    _continueButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:74/255.0 blue:89/255.0 alpha:1];
    _continueButton.layer.cornerRadius = 14;
    _continueButton.clipsToBounds = YES;
    
}



@end
