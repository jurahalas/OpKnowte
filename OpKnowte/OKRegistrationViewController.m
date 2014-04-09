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
@property (strong, nonatomic) NSDictionary *MDDictionary;

@end

@implementation OKRegistrationViewController

#pragma mark - View methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
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




-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //t_field=textField;
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    if (nextTag ==3 )
    {
        ////  dropDownTable.hidden = FALSE;
        
        picker_.hidden=NO;
        
        [textField resignFirstResponder];
        return NO;
    }
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        
        
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO;
}



#pragma mark - Picker methods

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 0;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 0;
}





#pragma mark - IBActions
- (IBAction)continueButton:(id)sender {
}

@end
