//
//  UCLRPNPageFiveViewController.m
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/20/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCLRPNPageFiveViewController.h"
#import "CONSTANTS.h"
#import "UCAppDelegate.h"
#import "UCSettingsViewController.h"
#import "UCLRPNPageSixViewController.h"
#import "UCSettingsViewController.h"
@interface UCLRPNPageFiveViewController ()

@end

@implementation UCLRPNPageFiveViewController
@synthesize parent;
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
    
    intraAbdominal = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(225, 80, 63, 26)];
    [intraAbdominal addTarget: self action: @selector(flip:) forControlEvents:UIControlEventValueChanged];
    [intraAbdominal setOn:NO];
    [self.view addSubview:intraAbdominal];
    
    vascular = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(225, 220, 63, 26)];
    [vascular addTarget: self action: @selector(flipVascular:) forControlEvents:UIControlEventValueChanged];
    [vascular setOn:NO];
    [self.view addSubview:vascular];
    
    intraAbdominalDescTxt_.tag = 1;
    vascularDescTxt_.tag = 2;
}
-(void) flip:(id)sender
{
    if(intraAbdominal.on)
    {
        intraAbdominalDescTxt_.enabled = true;
        //intraAbdominalLbl.hidden = TRUE;
    }
    else{
        intraAbdominalDescTxt_.enabled = false;
        intraAbdominalDescTxt_.text = @"";
        adhesiolysis.text = @"Select";
        //intraAbdominalLbl.hidden = FALSE;
    }
}

-(void) flipVascular:(id)sender
{
    if(vascular.on)
    {
        vascularDescTxt_.enabled = true;
        vascularDescLbl.hidden = TRUE;
    }
    else{
        vascularDescTxt_.enabled = false;
        vascularDescLbl.hidden = FALSE;
        vascularDescTxt_.text = @"";
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeButtonPressed:(id)sender {
    if ([UCAppDelegate sharedObject].isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}

- (IBAction)pickerDonePressed:(id)sender {
    picker_.hidden = YES;
    t_toolbar.hidden = YES;
    vascular.hidden = NO;
}

- (IBAction)forwardButtonPressed:(id)sender {
    
    //(((intraAbdominal.on) && ([intraAbdominalDescTxt_.text length] == 0)) || ([adhesiolysis.text length] == 0) || ((vascular.on) && ([vascularDescTxt_.text length] == 0)))
    
    if (((vascular.on) && ([vascularDescTxt_.text length] == 0))) {
        [UCUtility showInfoAlertView:@"Error" withMessage:@"Please complete all required fields."];
    }
    else {
        UCLRPNPageSixViewController *homeScreenTemp;
        
        if (intraAbdominal.on) {
            
            if ([adhesiolysis.text length] == 0 || [adhesiolysis.text isEqualToString:@"Select"]) {
                [UCUtility showInfoAlertView:@"Error" withMessage:@"Please complete all required fields."];
            }else{
                parent.parentModel.var_adhesions = @"Yes";
                
                if([adhesiolysis.text isEqualToString:@"Greater than 30 mins"]){
                    parent.parentModel.var_adhTook = @"greater";
                }
                else {
                    parent.parentModel.var_adhTook = @"less";
                }
                
                
                if(vascular.on){
                    parent.parentModel.var_vasAnomolies = vascularDescTxt_.text;
                }
                else{
                    parent.parentModel.var_vasAnomolies = @"No";
                }
                
                if(IS_IPHONE_5) {
                    homeScreenTemp = [[UCLRPNPageSixViewController alloc] initWithNibName:@"UCLRPNPageSixViewController" bundle:nil];
                }
                else {
                    homeScreenTemp = [[UCLRPNPageSixViewController alloc] initWithNibName:@"UCLRPNPageSixViewController" bundle:nil];
                }
                
                homeScreenTemp.parent = parent;
                [self.navigationController pushViewController:homeScreenTemp animated:NO];
                homeScreenTemp = nil;
                
            }
            //if ([intraAbdominalDescTxt_.text length] == 0) {
                
            //}else{
                //parent.parentModel.var_adhesions = intraAbdominalDescTxt_.text;
            //}
            
        }
        else {
            parent.parentModel.var_adhesions = @"No";
            parent.parentModel.var_adhTook = @"";
            
            if(vascular.on){
                parent.parentModel.var_vasAnomolies = vascularDescTxt_.text;
            }
            else{
                parent.parentModel.var_vasAnomolies = @"No";
            }
            
            if(IS_IPHONE_5) {
                homeScreenTemp = [[UCLRPNPageSixViewController alloc] initWithNibName:@"UCLRPNPageSixViewController" bundle:nil];
            }
            else {
                homeScreenTemp = [[UCLRPNPageSixViewController alloc] initWithNibName:@"UCLRPNPageSixViewController" bundle:nil];
            }
            
            homeScreenTemp.parent = parent;
            [self.navigationController pushViewController:homeScreenTemp animated:NO];
            homeScreenTemp = nil;
        }
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}



- (IBAction)adhesiolysisExpandPressed:(id)sender {
    
    if (intraAbdominal.on) {
        adhesiolysisSelectLbl_.hidden = YES;
        adhesiolysisArray = [[NSMutableArray alloc] init ];
        [adhesiolysisArray addObject:@"Less than 30 mins"];
        [adhesiolysisArray addObject:@"Greater than 30 mins"];
        picker_.hidden  = NO;
        t_toolbar.hidden = NO;
        adhesiolysis.text = @"Less than 30 mins";
        
        if (IS_IPHONE_5) {
            vascular.hidden = NO;
        }else{
            vascular.hidden = YES;
        }
        
        [picker_ reloadAllComponents];
    }
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    adhesiolysis.text = (NSString *)[adhesiolysisArray objectAtIndex:row];
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSUInteger numRows=[adhesiolysisArray count];
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = (NSString*)[adhesiolysisArray objectAtIndex:row];
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    return sectionWidth;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag == 2)
    {
        [self animateTextField:textField up:YES];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(textField.tag ==1)
    {
        if(textField.text.length < 1)
        {
            //intraAbdominalLbl.hidden = NO;
        }
    }
    else if(textField.tag == 2)
    {
        if(textField.text.length < 1)
        {
            vascularDescLbl.hidden = NO;
        }
        [self animateTextField: textField up: NO];
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
- (void)viewDidUnload {
    intraAbdominalDescTxt_ = nil;
    vascularDescTxt_ = nil;
    intraAbdominalLbl = nil;
    vascularDescLbl = nil;
    adhesiolysis = nil;
    adhesiolysisSelectLbl_ = nil;
    picker_ = nil;
    t_toolbar = nil;
    [super viewDidUnload];
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









