//
//  UCLRPNPageThreeViewController.m
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/20/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCLRPNPageThreeViewController.h"
#import "CONSTANTS.h"
#import "UCSettingsViewController.h"
#import "UCLRPNPageFourViewController.h"
#import "UCContactsListViewController.h"

#import "OKUserManager.h"
#import "OKProceduresManager.h"

@interface UCLRPNPageThreeViewController ()

@end

@implementation UCLRPNPageThreeViewController
@synthesize parent;
@synthesize assisantSelected;
@synthesize isAssistantSelection;
@synthesize isAnesthesiologistSelection;
@synthesize anesthesiologistSelected;
@synthesize selecting;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (self.isAssistantSelection == YES) {
        
        self.isAssistantSelection = NO;
        assistantTxt_.text = [self.assisantSelected contactName];
        
    }else if (self.isAnesthesiologistSelection == YES){
        
        self.isAnesthesiologistSelection = NO;
        anestTxt_.text = [self.anesthesiologistSelected contactName];
        
    }else{
        if ([selecting isEqualToString:@"Assistant"]) {
            
            if (anestTxt_.text.length == 0) {
                anestLbl_.hidden = NO;
            }
            
            
        }else if ([selecting isEqualToString:@"Anesthesiologist"]){
            
            if (assistantTxt_.text.length == 0) {
                 assistantLbl_.hidden = NO;
            }
           
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.assisantSelected = [[UCContactInfoModel alloc] init];
    self.anesthesiologistSelected = [[UCContactInfoModel alloc] init];
    
    UIColor *background;
    
    if(IS_IPHONE_5)
    {
        l_Header.frame=CGRectMake(l_Header.frame.origin.x, l_Header.frame.origin.y+5, l_Header.frame.size.width, l_Header.frame.size.height);
    }
    [l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    l_Header.text=[OKProceduresManager instance].selectedProcedure.procedureText;
    
    if(IS_IPHONE_5)
    {
        background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"1-1_menuBG@2x.png"]];
        
    }
    else
    {
        background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"proceduresBG.png"]];
        
    }
    self.view.backgroundColor = background;
    
    surgeonTxt_.tag = 1;
    assistantTxt_.tag = 2;
    anestTxt_.tag = 3;
    
    NSString *name = [NSString stringWithFormat:@"%@ %@, %@", [OKUserManager instance].currentUser.firstName, [OKUserManager instance].currentUser.lastName, [OKUserManager instance].currentUser.title];
    
    surgeonTxt_.text = name;
    surgeonLbl_.hidden = YES;
}


- (void)didReceiveMemoryWarning
{
    surgeonTxt_ = nil;
    surgeonLbl_ = nil;
    assistantTxt_ = nil;
    assistantLbl_ = nil;
    anestTxt_ = nil;
    anestLbl_ = nil;
    t_toolbar = nil;
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)forwardButtonPressed:(id)sender {
    
    if (([surgeonTxt_.text length] == 0) || ([assistantTxt_.text length] == 0) || ([anestTxt_.text length] == 0)) {
        [UCUtility showInfoAlertView:@"Error" withMessage:@"Please complete all required fields."];
    }
    else {
        self.parent.parentModel.var_surgeon = surgeonTxt_.text;
        NSLog(@"%@",[self.assisantSelected contactName]);
        NSLog(@"%@",[self.anesthesiologistSelected contactName]);
        self.parent.parentModel.var_assistant = self.assisantSelected;
        self.parent.parentModel.var_anesthesiologist = self.anesthesiologistSelected;
        
        NSLog(@"%@",[self.parent.parentModel.var_assistant contactName]);
        NSLog(@"%@",[self.parent.parentModel.var_anesthesiologist contactName]);
        
        UCLRPNPageFourViewController *homeScreenTemp;
        if(IS_IPHONE_5) {
            homeScreenTemp = [[UCLRPNPageFourViewController alloc] initWithNibName:@"UCLRPNPageFourViewController" bundle:nil];
        }
        else {
            homeScreenTemp = [[UCLRPNPageFourViewController alloc] initWithNibName:@"UCLRPNPageFourViewController" bundle:nil];
        }
        
        homeScreenTemp.parent = parent;
        [self.navigationController pushViewController:homeScreenTemp animated:NO];
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)expandAnesthes:(id)sender {
    
    if (surgeonTxt_.isFirstResponder) {
        [surgeonTxt_ resignFirstResponder];
    }
    
    anestLbl_.hidden = TRUE;
    selecting = @"Assistant";
    UCContactsListViewController * setting =nil;
    if(!IS_IPHONE_5) {
        setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController" bundle:nil];
    }
    else {
        setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController_iPhone" bundle:nil];
    }
    setting.selectedCat = 5;
    [self.navigationController pushViewController:setting animated:YES];
 
}

- (IBAction)expandAssistant:(id)sender {
    
    if (surgeonTxt_.isFirstResponder) {
        [surgeonTxt_ resignFirstResponder];
    }
    
    assistantLbl_.hidden = TRUE;
    selecting = @"Anesthesiologist";
    UCContactsListViewController * setting =nil;
    if(!IS_IPHONE_5) {
        setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController" bundle:nil];
    }
    else {
        setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController_iPhone" bundle:nil];
    }
    setting.selectedCat = [ROLE_ASSISTANT_ID intValue];
    [self.navigationController pushViewController:setting animated:YES];
    setting = nil;
}


- (IBAction)homeButtonPressed:(id)sender {
    if (DELEGATE.isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag == 1) {
        surgeonLbl_.hidden=true;
    }
    else if(textField.tag == 2) {
        assistantLbl_.hidden = true;
    }
    else if(textField.tag == 3) {
        anestLbl_.hidden = true;
    }
    
    if(textField == anestTxt_) {
        [self animateTextField: textField up: YES];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(textField.tag == 1)
    {
        if(textField.text.length <1)
            surgeonLbl_.hidden=false;
    }
    else if(textField.tag == 2)
    {
        if(textField.text.length <1)
                assistantLbl_.hidden=false;
    }
    else if(textField.tag == 3)
    {
        if(textField.text.length <1)
                anestLbl_.hidden=false;
    }
    if(textField==anestTxt_) {
        [self animateTextField: textField up: NO];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up {
    if (IS_IPHONE_5) {
        
        const int movementDistance = 130; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        int movement = (up ? -movementDistance : movementDistance);
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
        
    }else{
        
        const int movementDistance = 180; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        int movement = (up ? -movementDistance : movementDistance);
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
        
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /*
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    if ([textField.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        NSString *newString = [textField.text substringToIndex:[textField.text length]-1];
        
        textField.text=newString;
        
        NSLog(@"This string contains illegal characters%@ %i",string,range.length);;
        
    }
     */
    return TRUE;
}

- (IBAction)SettingsView:(id)sender {
    UCSettingsViewController *setting = nil;
    if(IS_IPHONE_5) {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController" bundle:nil];
    }
    else {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController_iphone" bundle:nil];
    }
    //UCSettingsViewController * setting =[[UCSettingsViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}
@end
