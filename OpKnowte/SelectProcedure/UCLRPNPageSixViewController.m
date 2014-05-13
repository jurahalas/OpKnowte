//
//  UCLRPNPageSixViewController.m
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/21/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCLRPNPageSixViewController.h"
#import "CONSTANTS.h"
#import "UCLRPNSevenViewController.h"
#import "UCAppDelegate.h"
#import "UCSettingsViewController.h"
@interface UCLRPNPageSixViewController ()

@end

@implementation UCLRPNPageSixViewController
@synthesize parent, congTF, scroller;
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
    // Do any additional setup after loading the view from its nib.
    
    if(IS_IPHONE_5)
    {
        l_Header.frame=CGRectMake(l_Header.frame.origin.x, l_Header.frame.origin.y+5, l_Header.frame.size.width, l_Header.frame.size.height);
    }
    [l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    l_Header.text=[UCAppDelegate sharedObject].selectedProcedure.procedureText;
    
    
    //CGRect congulantsFrame = CGRectMake(225, 187, 63, 26);
    CGRect congulantsFrame = CGRectMake(225, 242, 63, 26);
    
    if (IS_IPHONE_5) {
        congulantsFrame = CGRectMake(225, 242, 63, 26);
        [self.scroller setScrollEnabled:NO];
    }else{
        [self.scroller setScrollEnabled:YES];
        [self.scroller setContentSize:CGSizeMake(320, 430)];
    }
    
    ultraSound = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(225, 25,63 , 26)];
    [ultraSound setOn:NO];
    [self.scroller addSubview:ultraSound];
    
    margin = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(225, 80, 63, 26)];
    [margin setOn:NO];
    [self.scroller addSubview:margin];
    
    rentalCollection = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(225, 134, 63, 26)];
    [rentalCollection setOn:NO];
    [self.scroller addSubview:rentalCollection];
    
    congulants = [[RCSwitchOnOff alloc] initWithFrame:congulantsFrame];
    [congulants setOn:NO];
    [congulants addTarget:self action:@selector(congulantsEdit) forControlEvents:UIControlEventTouchUpInside];
    [self.scroller addSubview:congulants];
    
    clampTxt_.tag = 4;
    
    clampTxt_.keyboardType = UIKeyboardTypeDecimalPad;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    clampTxt_.inputAccessoryView = numberToolbar;
    
    estimatedBloodLossTxt_.tag = 6;
    estimatedBloodLossTxt_.keyboardType = UIKeyboardTypeDecimalPad;
    estimatedBloodLossTxt_.inputAccessoryView = numberToolbar;
    
    
}

-(void)congulantsEdit{
    if(congulants.on){
        [self.congTF setEnabled:NO];
        [congulants setOn:NO];
        congulantsFlag = NO;
    }
    else{
        [self.congTF setEnabled:YES];
        [congulants setOn:YES];
        congulantsFlag = YES;
    }
}

-(void)cancelNumberPad{
    [clampTxt_ resignFirstResponder];
    clampTxt_.text = @"";
    [estimatedBloodLossTxt_ resignFirstResponder];
}

-(void)doneWithNumberPad{    
    [clampTxt_ resignFirstResponder];
    [estimatedBloodLossTxt_ resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)forwardButtonPressed:(id)sender {
    
    if (([clampTxt_.text length] == 0) || ([estimatedBloodLossTxt_.text length] == 0) || ((congulants.on) && ([congTF.text length] == 0))) {
        [UCUtility showInfoAlertView:@"Error" withMessage:@"Please complete all required fields."];
    }
    else {
        UCLRPNSevenViewController *homeScreenTemp;
        
        parent.parentModel.var_clamp = [clampTxt_.text stringByAppendingFormat:@" minutes"];
        parent.parentModel.var_bloodLoss = [estimatedBloodLossTxt_.text stringByAppendingFormat:@" ml"];
        
        if(ultraSound.on){
            parent.parentModel.var_renalUltraSound = @"Intraoperative ultrasound was performed to aid in detection and isolation of the mass";
        }
        else{
            parent.parentModel.var_renalUltraSound = @"No";
        }
        
        if(margin.on){
            parent.parentModel.var_margin = @"A deep margin was taken and sent for frozen section";
        }
        else{
            parent.parentModel.var_margin = @"No";
        }
        
        if(congulants.on){
            parent.parentModel.var_coagulant = congTF.text;
        }
        else{
            parent.parentModel.var_coagulant = @"No coagulants";
        }
        
        if(rentalCollection.on){
            parent.parentModel.var_RCSRepair = @"The collecting system was entered and was repaired with 2-0 v-lock suture";
        }
        else{
            parent.parentModel.var_RCSRepair = @"No";
        }
        
        if(IS_IPHONE_5) {
            homeScreenTemp = [[UCLRPNSevenViewController alloc] initWithNibName:@"UCLRPNSevenViewController" bundle:nil];
        }
        else {
            homeScreenTemp = [[UCLRPNSevenViewController alloc] initWithNibName:@"UCLRPNSevenViewController" bundle:nil];
        }
        
        homeScreenTemp.parent = parent;
        [self.navigationController pushViewController:homeScreenTemp animated:NO];
        homeScreenTemp = nil;
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewDidUnload {
    clampTxt_ = nil;
    clampLbl_ = nil;
    clampSelectLbl_ = nil;
    estimatedBloodLossTxt_ = nil;
    estimatedBloodLossLbl_ = nil;
    estimatedBloodLossSelectLbl_ = nil;
    [super viewDidUnload];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag == 4)
    {
        clampLbl_.hidden = true;
        clampSelectLbl_.hidden= true;
        [self animateTextField:textField up:YES];
    }
    else if(textField.tag == 6)
    {
        estimatedBloodLossLbl_.hidden = true;
        estimatedBloodLossSelectLbl_.hidden= true;
        [self animateTextField:textField up:YES];
    }else if (textField == congTF){
        [self animateTextField:textField up:YES];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(textField.tag == 4)
    {
        if(textField.text.length <1 || [textField.text floatValue] <=0)
        {
            textField.text = @"";
            clampSelectLbl_.hidden = NO;
            clampLbl_.hidden = NO;
        }
        [self animateTextField:textField up:NO];
    }
    else if(textField.tag == 6)
    {
        if(textField.text.length <1 || [textField.text floatValue] <=0)
        {
            textField.text = @"";
            estimatedBloodLossSelectLbl_.hidden = NO;
            estimatedBloodLossLbl_.hidden = NO;
        }
        [self animateTextField:textField up:NO];
        
    }else if (textField == congTF){
        [self animateTextField:textField up:NO];
    }
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    if (IS_IPHONE_5) {
        
        const int movementDistance = 150; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        int movement = (up ? -movementDistance : movementDistance);
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
        
    }else{
        
        const int movementDistance = 200; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        int movement = (up ? -movementDistance : movementDistance);
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
        
    }
}
- (IBAction)homeButtonPressed:(id)sender {
    if ([UCAppDelegate sharedObject].isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /*
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    if ([textField.text rangeOfCharacterFromSet:set].location != NSNotFound)
    {
        
        // NSString *text;
        // text =[[textField text] stringByAppendingString:string];
        NSString *newString = [textField.text substringToIndex:[textField.text length]-1];
        
        // newString=[newString stringByAppendingString:string];
        
        textField.text=newString;
        
        
        
        NSLog(@"This string contains illegal characters%@ %i",string,range.length);;
        
    }
     */
    return TRUE;
}
-(IBAction)SettingsView:(id)sender
{
    UCSettingsViewController *setting = nil;
    //if(IS_IPHONE_5) {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController" bundle:nil];
    /*}
    else {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController_iphone" bundle:nil];
    }*/
    //UCSettingsViewController * setting =[[UCSettingsViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}
@end
