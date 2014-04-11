//
//  OKRegistrationViewController.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/9/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKRegistrationViewController.h"

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

- (IBAction)continueButton:(id)sender {
}
- (IBAction)navBarBackButton:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
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
