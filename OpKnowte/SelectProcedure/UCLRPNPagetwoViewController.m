//
//  UCLRPNPagetwoViewController.m
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/14/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCLRPNPagetwoViewController.h"
#import "CONSTANTS.h"
#import "UCLRPNPageThreeViewController.h"
#import "RCSwitchOnOff.h"
#import "UCAppDelegate.h"
#import "UCSettingsViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface UCLRPNPagetwoViewController ()

@end

@implementation UCLRPNPagetwoViewController
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
    
    PreArray =[[NSMutableArray alloc]init];
    [PreArray addObject:@"Right renal mass"];
    [PreArray addObject:@"Left renal mass"];
    
    // Do any additional setup after loading the view from its nib.
    
    if(IS_IPHONE_5) {
        l_Header.frame=CGRectMake(l_Header.frame.origin.x, l_Header.frame.origin.y+5, l_Header.frame.size.width, l_Header.frame.size.height);
    }
    
    [l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    l_Header.text=[UCAppDelegate sharedObject].selectedProcedure.procedureText;
    
    cytoswitch = [[RCSwitchOnOff alloc] initWithFrame:CGRectMake(225, 250, 63, 26)];
    [cytoswitch setOn:NO];
    [self.view addSubview:cytoswitch];
}

- (void)didReceiveMemoryWarning
{
    postOxTxt_ = nil;
    postOxLbl_ = nil;
    t_toolbar = nil;
    picker_ = nil;
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donePressed:(id)sender {
    [picker_ setHidden:YES];
    [t_toolbar setHidden:YES];
    [cytoswitch setHidden:NO];
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)forwardButtonPressed:(id)sender {
    
    if (cytoswitch.on) {
        cyto = YES;
    }
    else {
        cyto = NO;
    }
    
    if (cyto) {
        parent.parentModel.var_cysto = @"YES";
    }
    else {
        parent.parentModel.var_cysto = @"No";
    }
    
    parent.parentModel.var_preOp = preOxTxt_.text;
    if ([parent.parentModel.var_preOp isEqualToString:@"Left renal mass"]) {
        parent.parentModel.var_preOp = [NSString stringWithFormat:@"Left"];
        parent.parentModel.var_preSide = [NSString stringWithFormat:@"left"];
    }else if ([parent.parentModel.var_preOp isEqualToString:@"Right renal mass"]){
        parent.parentModel.var_preOp = [NSString stringWithFormat:@"Right"];
        parent.parentModel.var_preSide = [NSString stringWithFormat:@"right"];
    }
    
    parent.parentModel.var_postOp = postOxTxt_.text;
    
    UCLRPNPageThreeViewController *homeScreenTemp;
    if(IS_IPHONE_5)
    {
        homeScreenTemp = [[UCLRPNPageThreeViewController alloc] initWithNibName:@"UCLRPNPageThreeViewController" bundle:nil];
    }
    else
    {
        homeScreenTemp = [[UCLRPNPageThreeViewController alloc] initWithNibName:@"UCLRPNPageThreeViewController" bundle:nil];
        
    }
    
    if (parent.parentModel.var_preOp.length <= 0 || (postOxTxt_.text.length <= 0))  {
        [UCUtility showInfoAlertView:@"Error" withMessage:@"Please complete all required fields."];
    }
    else {
        homeScreenTemp.parent = parent;
        [self.navigationController pushViewController:homeScreenTemp animated:NO];
        homeScreenTemp = nil;
    }
}

- (IBAction)homeButtonPressed:(id)sender {
    if ([UCAppDelegate sharedObject].isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}

- (IBAction)postButtonPressed:(id)sender {
    
    if (!IS_IPHONE_5) {
        [cytoswitch setHidden:YES];
    }
    
    UIAlertView *alertForPostOp = [[UIAlertView alloc] initWithTitle: @"Post-op Diagnosis"
                                                             message: @"\n\n\n\n\n"
                                                            delegate: self
                                                   cancelButtonTitle: @"Cancel"
                                                   otherButtonTitles: @"OK",nil];
    [alertForPostOp setTag:202];
	UITextView *textView = [[UITextView alloc] initWithFrame: CGRectMake(12.0, 45.0, 260.0, 112.0)];
    textView.tag = 10;
	textView.font = [UIFont boldSystemFontOfSize:15];
	textView.layer.cornerRadius = 6;
	textView.layer.masksToBounds = YES;
	[alertForPostOp setTransform: CGAffineTransformMakeTranslation(0.0, -100)];
    textView.text = postOxTxt_.text;
	[alertForPostOp addSubview: textView];
	[alertForPostOp show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 202) {
        if (buttonIndex == 0) {
            
        }else if (buttonIndex == 1){
            //postOxTxt_.text
            [cytoswitch setHidden:NO];
            for (UIView *tf in alertView.subviews) {
                NSString *str = [NSString stringWithFormat:@"%@",[tf class]];
                if ([str isEqualToString:@"UITextView"]) {
                    [((UITextView *)tf) text];
                    
                    if ([((UITextView *)tf) tag] == 10) {
                        postOxTxt_.text = [((UITextField *)tf) text];
                    }
                }
            }
        }
    }
}

- (IBAction)preButtonPressed:(id)sender {
    [picker_ setHidden:NO];
    [t_toolbar setHidden:NO];
    [preOxLbl_ setHidden:YES];
    if (!IS_IPHONE_5) {
        [cytoswitch setHidden:YES];
    }
    picker_.tag=22;
    [picker_ reloadAllComponents];
    
    if(preOxTxt_.text.length<2) {
        preOxTxt_.text =[PreArray objectAtIndex:0];
    }
    
    if([preOxTxt_.text isEqualToString:[PreArray objectAtIndex:0]]) {
        [picker_ selectRow:0 inComponent:0 animated:NO];
    }
    else {
        [picker_ selectRow:1 inComponent:0 animated:NO];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    postOxLbl_.hidden = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if(textField.text.length < 1) {
        postOxLbl_.hidden = NO;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    if(picker_.tag==22) {
        preOxTxt_.text=[PreArray objectAtIndex:row];
    }
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSUInteger numRows=1;
    if(pickerView.tag==22)
    {
        return [PreArray count];
    }
    else
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = @"Same as Pre-Diagnosis";
    
    if(picker_.tag==22) {
      return [PreArray objectAtIndex:row];
    }
    else
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

-(IBAction)SettingsView:(id)sender {
    UCSettingsViewController *setting = nil;
    //if(IS_IPHONE_5) {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController" bundle:nil];
    /*}
    else {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController_iphone" bundle:nil];
    }*/
    [self.navigationController pushViewController:setting animated:YES];
    setting = nil;
}

@end
