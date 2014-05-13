//
//  UCLRPNSevenViewController.m
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/21/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCLRPNSevenViewController.h"
#import "CONSTANTS.h"
#import "UCAppDelegate.h"
#import "UCOperativeNoteViewController.h"
#import "UCSettingsViewController.h"
#import "UCContactsListViewController.h"

@interface UCLRPNSevenViewController ()

@end

BOOL keyboardUP;

@implementation UCLRPNSevenViewController
@synthesize parent, ccTxt_, contactInfo, ccLbl_, selectedContacts;
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
    keyboardUP = NO;
    if(IS_IPHONE_5)
    {
        l_Header.frame=CGRectMake(l_Header.frame.origin.x, l_Header.frame.origin.y+5, l_Header.frame.size.width, l_Header.frame.size.height);
    }
    [l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    l_Header.text=[UCAppDelegate sharedObject].selectedProcedure.procedureText;
    
    if (IS_IPHONE_5) {
        [self.scroller setScrollEnabled:NO];
    }else{
        [self.scroller setScrollEnabled:YES];
        [self.scroller setContentSize:CGSizeMake(320, 430)];
    }

    
    transfusion = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(225, 250, 63, 26)];
    [transfusion setOn:NO];
    [transfusion addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:transfusion];
    
    counslTxt_.tag= 1;
    counslTxt_.keyboardType = UIKeyboardTypeDecimalPad;
    
    roomTimeTxt_.tag = 2;
    roomTimeTxt_.keyboardType = UIKeyboardTypeDecimalPad;
    
    complationsTxt_.tag = 3;
    self.ccTxt_.tag = 4;
    
    faxTxt_.tag = 5;
    faxTxt_.keyboardType = UIKeyboardTypeDecimalPad;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    counslTxt_.inputAccessoryView = numberToolbar;
    roomTimeTxt_.inputAccessoryView = numberToolbar;
    faxTxt_.inputAccessoryView = numberToolbar;
}
-(void)cancelNumberPad{
    [counslTxt_ resignFirstResponder];
    [roomTimeTxt_ resignFirstResponder];
    [faxTxt_ resignFirstResponder];
}

-(void)doneWithNumberPad{
    [counslTxt_ resignFirstResponder];
    [roomTimeTxt_ resignFirstResponder];
    [faxTxt_ resignFirstResponder];
}
-(void) flip:(id)sender
{
    if(transfusion.on)
    {
        transfusionFlag = YES;
        transfusionDetailLbl_.hidden = YES;
        transfusionDetailTxt_.enabled = YES;
    }
    else {
        transfusionFlag = NO;
        transfusionDetailLbl_.hidden = NO;
        transfusionDetailTxt_.enabled = NO;
        transfusionDetailTxt_.text= @"";
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)forwardButtonPressed:(id)sender {
    
    
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)createOperativeNote:(id)sender {
    
    if (([counslTxt_.text length] == 0) || ([roomTimeTxt_.text length] == 0) || ((transfusion.on) && ([transfusionDetailTxt_.text length] == 0))) {
        
        [UCUtility showInfoAlertView:@"Error" withMessage:@"Please complete all required fields."];
    }
    else {
        
            self.parent.parentModel.var_counselTime = [counslTxt_.text stringByAppendingFormat:@" mins"];
            self.parent.parentModel.var_roomTime = [roomTimeTxt_.text stringByAppendingFormat:@" mins"];
            
            if([complationsTxt_.text length] == 0) {
                parent.parentModel.var_complation = @"None";
            }
            else {
                self.parent.parentModel.var_complation = complationsTxt_.text;
            }
            
            if (transfusion.on) {
                self.parent.parentModel.var_transfusion = transfusionDetailTxt_.text;
            }
            else {
                self.parent.parentModel.var_transfusion = @"No";
            }
        
        NSLog(@"%@",self.selectedContacts);
        if (self.ccTxt_.text.length == 0) {
            self.parent.parentModel.var_cc = [self.selectedContacts mutableCopy];
        }else{
            self.parent.parentModel.var_cc = [self getEmailsArray:self.selectedContacts];
        }
        
        self.parent.parentModel.var_Fax = faxTxt_.text;
        
        NSLog(@"%@",self.parent.parentModel.var_cc);
        UCOperativeNoteViewController *homeScreenTemp;
        if(IS_IPHONE_5) {
            homeScreenTemp = [[UCOperativeNoteViewController alloc] initWithNibName:@"UCOperativeNoteViewController" bundle:nil];
        }
        else {
            homeScreenTemp = [[UCOperativeNoteViewController alloc] initWithNibName:@"UCOperativeNoteViewController" bundle:nil];
        }
        homeScreenTemp.CCContacts = [self.selectedContacts mutableCopy];
        homeScreenTemp.parent = self.parent;
        [self.navigationController pushViewController:homeScreenTemp animated:NO];
        homeScreenTemp = nil;
        
    }
}

- (void)viewDidUnload {
    transfusionDetailTxt_ = nil;
    transfusionDetailLbl_ = nil;
    couslLbl_ = nil;
    counslTxt_ = nil;
    counslSelectLbl_ = nil;
    roomTimeTxt_ = nil;
    roomTimeLbl_ = nil;
    roomTimeSelectLbl_ = nil;
    complationsTxt_ = nil;
    complationsSelectLbl_ = nil;
    complationsLbl_ = nil;
    ccLbl_ = nil;
    self.ccTxt_ = nil;
    ccSelectLbl_ = nil;
    [super viewDidUnload];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag == 1)
    {
        couslLbl_.hidden = YES;
        counslSelectLbl_.hidden = YES;
    }
    else if(textField.tag == 2)
    {
        roomTimeLbl_.hidden = YES;
        roomTimeSelectLbl_.hidden = YES;
    }
    else if(textField.tag == 3)
    {
        complationsLbl_.hidden = YES;
        complationsTxt_.textAlignment = NSTextAlignmentLeft;
        complationsTxt_.placeholder = @"";
        complationsSelectLbl_.hidden = YES;
    }
    else if(textField.tag == 4)
    {
        ccLbl_.hidden = YES;
        ccSelectLbl_.hidden = YES;
        keyboardUP = YES;
        [self animateTextField:textField up:YES];
        
    }
    else if (textField == transfusionDetailTxt_ || textField == faxTxt_){
        keyboardUP = YES;
        [self animateTextField:textField up:YES];
        
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(textField.tag ==1)
    {
        if(textField.text.length <1 || [textField.text floatValue] <= 0)
        {
            textField.text = @"";
            counslSelectLbl_.hidden = NO;
            couslLbl_.hidden = NO;
        }
    }
    else if(textField.tag ==2)
    {
        if(textField.text.length <1 || [textField.text floatValue] <= 0)
        {
            textField.text = @"";
            roomTimeLbl_.hidden = NO;
            roomTimeSelectLbl_.hidden = NO;
        }
    }
    else if(textField.tag ==3)
    {
        if(textField.text.length <1)
        {
            complationsLbl_.hidden = NO;
            complationsTxt_.textAlignment = NSTextAlignmentRight;
            complationsTxt_.placeholder = @"none";
            complationsSelectLbl_.hidden = NO;
        }
    }
    else if(textField.tag ==4)
    {
        if(textField.text.length <1)
        {
            ccSelectLbl_.hidden = NO;
            ccLbl_.hidden = NO;
        }
        keyboardUP = NO;
        [self animateTextField:textField up:NO];
    }
    else if (textField == transfusionDetailTxt_ || textField == faxTxt_){
        keyboardUP = NO;
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


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    /*
    if (textField != self.ccTxt_) {
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
    }*/
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

-(IBAction)expandCC:(id)sender{
    if (!keyboardUP) {
        UCContactsListViewController * setting =nil;
        if(!IS_IPHONE_5) {
            setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController" bundle:nil];
        }
        else {
            setting = [[UCContactsListViewController alloc] initWithNibName:@"UCContactsListViewController_iPhone" bundle:nil];
        }
        setting.selectedCat = 21;
        setting.selectedList = [self.selectedContacts mutableCopy];
        
        [self.navigationController pushViewController:setting animated:YES];
        setting = nil;
    }
    
}

- (NSArray *)getEmailsArray:(NSArray *)ContactsArray
{
    NSMutableArray *emails = [[NSMutableArray alloc] init];
    for(int i=0;i<ContactsArray.count;i++)
    {
        UCContactInfoModel *contact = [ContactsArray objectAtIndex:i];
        [emails addObject:contact.contactEmail];
    
    }
    
    return emails;
}

@end
