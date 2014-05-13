//
//  UCTWTPPageTwoViewController.m
//  MZUroCapture
//
//  Created by Omer on 5/10/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCTWTPPageTwoViewController.h"
#import "UCSettingsViewController.h"
#import "CONSTANTS.h"
#import "UCSelectTimePointViewController.h"
#import "UCTimePointSummaryViewController.h"

@interface UCTWTPPageTwoViewController ()

@end

@implementation UCTWTPPageTwoViewController

@synthesize parent, t_toolbar, picker;
@synthesize NightTF, PostOpBUNTF, PostOpCreatinineTF, PreOpBUNTF, PreOpCreatinineTF, ComplicationsTF, AdditionalDiagTF;
@synthesize nightLbl, nightSelectLbl, postOPLbl, postOPSelectLbl, preOPLbl, preOPSelectLbl, complicationsLbl, complicationsSelectLbl, addDiagLbl, addSiagSelectLbl;

@synthesize nightsBtn, complicationsBtn;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



-(IBAction)update:(UIButton *)sender{
    
    if ([self.nightSelectLbl.text isEqualToString:@"Select"] || [self.complicationsSelectLbl.text isEqualToString:@"Select"] || self.PreOpBUNTF.text.length == 0 || self.PreOpCreatinineTF.text.length == 0 || self.PostOpBUNTF.text.length == 0 || self.PostOpCreatinineTF.text.length == 0) {
        
        [UCUtility showInfoAlertView:@"" withMessage:@"Please select all required fields to proceed."];
    }else{
        
        UCTimePointSummaryViewController *controller = [[UCTimePointSummaryViewController alloc] initWithNibName:@"UCTimePointSummaryViewController" bundle:nil];
        
        
        [self.parent.weeksDictionary setObject:self.nightSelectLbl.text forKey:NIGHTS_STAGE];
        [self.parent.SummaryDictionary setObject:self.nightSelectLbl.text forKey:self.nightLbl.text];
        
        [self.parent.weeksDictionary setObject:self.complicationsSelectLbl.text forKey:COMPLICATIONS_STAGE];
        [self.parent.SummaryDictionary setObject:self.complicationsSelectLbl.text forKey:self.complicationsLbl.text];
        
        [self.parent.weeksDictionary setObject:self.PreOpBUNTF.text forKey:PREOP_BUN_STAGE];
        [self.parent.SummaryDictionary setObject:self.PreOpBUNTF.text forKey:self.PreOpBUNTF.placeholder];
        
        
        [self.parent.weeksDictionary setObject:self.PreOpCreatinineTF.text forKey:PREOP_CRATININE_STAGE];
        [self.parent.SummaryDictionary setObject:self.PreOpCreatinineTF.text forKey:self.PreOpCreatinineTF.placeholder];
        
        [self.parent.weeksDictionary setObject:self.PostOpBUNTF.text forKey:POSTOP_BUN_STAGE];
        [self.parent.SummaryDictionary setObject:self.PostOpBUNTF.text forKey:self.PostOpBUNTF.placeholder];
        
        [self.parent.weeksDictionary setObject:self.PostOpCreatinineTF.text forKey:POSTOP_CREATININE_STAGE];
        [self.parent.SummaryDictionary setObject:self.PostOpCreatinineTF.text forKey:self.PostOpCreatinineTF.placeholder];
        
        
        [self.parent.weeksDictionary setObject:self.AdditionalDiagTF.text forKey:ADD_DIAGNOSIS_STAGE];
        [self.parent.SummaryDictionary setObject:self.AdditionalDiagTF.text forKey:self.AdditionalDiagTF.placeholder];
        
        controller.caseData = [self.parent.weeksDictionary mutableCopy];
        
        controller.caseID = [self.parent.caseData objectForKey:@"DetailID"];
        controller.timePointID = [self.parent.timePoint objectForKey:@"id"];
        
        controller.timePoint = @"Two";
        
        controller.summaryDictionary = [self.parent.SummaryDictionary mutableCopy];
        
        //[self.navigationController pushViewController:controller animated:YES];
        
        if (self.parent.isComingFromUrl) {
            
            [self.parent.weeksDictionary setObject:self.parent.urlProcedureID forKey:@"procedureID"];
            [UCUtility showBlockView];
            [UCWebServerHandler addTwoWeeksOngoingClinicalDetail:self.parent.urlCaseID withTimePointID:self.parent.urlTimepointID withDictionary:self.parent.weeksDictionary withUserID:self.parent.urlUserID withDelegate:self];
            
        }else{
            
            [self.parent.weeksDictionary setObject:[UCAppDelegate sharedObject].selectedProcedure.procedureID forKey:@"procedureID"];
            
            [UCUtility showBlockView];
            if([UCAppDelegate sharedObject].selectedUser!=nil)
            {
                
                [UCWebServerHandler addTwoWeeksOngoingClinicalDetail:[self.parent.caseData objectForKey:@"DetailID"] withTimePointID:[self.parent.timePoint objectForKey:@"id"] withDictionary:self.parent.weeksDictionary withUserID:[[UCAppDelegate sharedObject].selectedUser userID] withDelegate:self];
            }
            else
            {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [UCWebServerHandler addTwoWeeksOngoingClinicalDetail:[self.parent.caseData objectForKey:@"DetailID"] withTimePointID:[self.parent.timePoint objectForKey:@"id"] withDictionary:self.parent.weeksDictionary withUserID:[defaults objectForKey:UD_USERID] withDelegate:self];
            }
            
        }
        
        
        
    }
}


- (void)AddOnGoingDetailsSuccessHandler:(ASIHTTPRequest *)request {
    [UCUtility hideBlockView];
    
    NSString *response = [request responseString];
    NSLog(@"%@",response);
    
    id result = [response JSONValue];
    
    if ([[result objectForKey:@"status"] isEqualToString:@"true"]) {
        
        [UCUtility showInfoAlertView:@"" withMessage:[result objectForKey:@"msg"]];
        
        if (self.parent.isComingFromUrl) {
            [self dismissModalViewControllerAnimated:YES];
        }else{
            
            int countValue = [self.navigationController.viewControllers count];
            UCSelectTimePointViewController *controller = (UCSelectTimePointViewController *)[self.navigationController.viewControllers objectAtIndex:countValue-3];
            
            [self.navigationController popToViewController:controller animated:YES];
        }
        
    }
    else {
        [UCUtility showInfoAlertView:@"Error" withMessage:[result objectForKey:@"msg"]];
    }
    
    result = nil;
    response = nil;
}

- (void)AddOnGoingDetailsErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [headerLbl_ setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    isUp = NO;
    [self setValues];
}

-(void)setValues{
    
    NSDictionary *dict = [[self.parent.onGoingData objectForKey:@"clinicalData"] objectAtIndex:0];
    NSLog(@"%@",dict);
    
    NSString *str;
    str = [dict objectForKey:NIGHTS_STAGE];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.nightSelectLbl setText:str];
    }
    
    str = [dict objectForKey:COMPLICATIONS_STAGE];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.complicationsSelectLbl setText:str];
    }
    
    str = [dict objectForKey:PREOP_BUN_STAGE];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.PreOpBUNTF setText:str];
    }
    
    str = [dict objectForKey:PREOP_CRATININE_STAGE];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.PreOpCreatinineTF setText:str];
    }
    
    str = [dict objectForKey:POSTOP_BUN_STAGE];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.PostOpBUNTF setText:str];
    }
    
    str = [dict objectForKey:POSTOP_CREATININE_STAGE];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.PostOpCreatinineTF setText:str];
    }
    
    str = [dict objectForKey:ADD_DIAGNOSIS_STAGE];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.AdditionalDiagTF setText:str];
    }
    
}


-(IBAction)expandNights:(UIButton *)sender{
    
    self.parent.pickerCheck = @"Nights";
    [self.picker setHidden:NO];
    [self.t_toolbar setHidden:NO];
    
    [self.complicationsBtn setEnabled:NO];
    
    [self.parent.pickerArray removeAllObjects];
    self.parent.pickerArray = nil;
    self.parent.pickerArray = [[NSMutableArray alloc] initWithCapacity:30];
    
    for (int i = 1; i < 31; i++) {
        [self.parent.pickerArray addObject:[NSString stringWithFormat:@"%i Night(s)",i]];
    }
        
    [self.picker reloadAllComponents];
    
    if (self.nightSelectLbl.text.length > 0 && ![self.nightSelectLbl.text isEqualToString:@"Select"]) {
        for (int i = 0; i < [self.parent.pickerArray count]; i++) {
            NSString *str = [self.parent.pickerArray objectAtIndex:i];
            if ([self.nightSelectLbl.text isEqualToString:str]) {
                [self.picker selectRow:i inComponent:0 animated:YES];
                break;
            }
        }
    }else{
        [self.picker selectRow:0 inComponent:0 animated:YES];
    }
}

-(IBAction)expandComplications:(UIButton *)sender{
    
    if (isUp) {
        [self animateTextField:self.PreOpCreatinineTF up:NO];
        isUp = NO;
    }
    
    if ([self.PreOpBUNTF isFirstResponder] || [self.PreOpCreatinineTF isFirstResponder]|| [self.PostOpBUNTF isFirstResponder]|| [self.PostOpCreatinineTF isFirstResponder]|| [self.AdditionalDiagTF isFirstResponder]) {
        
        [self.PreOpBUNTF resignFirstResponder];
        [self.PreOpCreatinineTF resignFirstResponder];
        [self.PostOpBUNTF resignFirstResponder];
        [self.PostOpCreatinineTF resignFirstResponder];
        [self.AdditionalDiagTF resignFirstResponder];
        
    }
    
    self.parent.pickerCheck = @"Complications";
    [self.picker setHidden:NO];
    [self.t_toolbar setHidden:NO];
    
    [self.nightsBtn setEnabled:NO];
    [self.ComplicationsTF setEnabled:YES];
    
    [self.parent.pickerArray removeAllObjects];
    self.parent.pickerArray = nil;
    self.parent.pickerArray = [[NSMutableArray alloc] initWithCapacity:11];
    
    [self.parent.pickerArray addObject:@"Ileus"];
    [self.parent.pickerArray addObject:@"Bowel injury"];
    [self.parent.pickerArray addObject:@"Infection"];
    [self.parent.pickerArray addObject:@"Urine leak"];
    [self.parent.pickerArray addObject:@"DVT"];
    [self.parent.pickerArray addObject:@"PE"];
    [self.parent.pickerArray addObject:@"Cardiac event"];
    [self.parent.pickerArray addObject:@"Hernia"];
    [self.parent.pickerArray addObject:@"Transfusion"];
    [self.parent.pickerArray addObject:@"Death"];
    [self.parent.pickerArray addObject:@"Other"];
    
    [self.picker reloadAllComponents];
    
    if (self.complicationsSelectLbl.text.length > 0 && ![self.complicationsSelectLbl.text isEqualToString:@"None"]) {
        for (int i = 0; i < [self.parent.pickerArray count]; i++) {
            NSString *str = [self.parent.pickerArray objectAtIndex:i];
            if ([self.complicationsSelectLbl.text isEqualToString:str]) {
                [self.picker selectRow:i inComponent:0 animated:YES];
                break;
            }
        }
    }else{
        [self.picker selectRow:0 inComponent:0 animated:YES];
    }
}


- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    if (IS_IPHONE_5) {
        
        if (isUp) {
            const int movementDistance = 125; // tweak as needed
            const float movementDuration = 0.3f; // tweak as needed
            int movement = (up ? -movementDistance : movementDistance);
            
            CGRect toolbarRect = t_toolbar.frame;
            toolbarRect.origin.y = toolbarRect.origin.y - movement;
            t_toolbar.frame = toolbarRect;
            
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            self.view.frame = CGRectOffset(self.view.frame, 0, movement);
            [UIView commitAnimations];
        }
        
    }else{
        
        if (isUp) {
            const int movementDistance = 150; // tweak as needed
            const float movementDuration = 0.3f; // tweak as needed
            int movement = (up ? -movementDistance : movementDistance);
            
            CGRect toolbarRect = t_toolbar.frame;
            toolbarRect.origin.y = toolbarRect.origin.y - movement;
            t_toolbar.frame = toolbarRect;
            
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            self.view.frame = CGRectOffset(self.view.frame, 0, movement);
            [UIView commitAnimations];
        }
        
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [t_toolbar setHidden:YES];
    [self.picker setHidden:YES];
    
    
    if (textField == self.PreOpBUNTF || textField == self.PostOpBUNTF || textField == self.PreOpCreatinineTF || textField == self.PostOpCreatinineTF) {
        [t_toolbar setHidden:NO];
    }
    
    if (textField == self.PostOpBUNTF || textField == self.AdditionalDiagTF || textField == self.PostOpCreatinineTF || textField == self.PostOpCreatinineTF) {
        if (!isUp) {
            isUp = YES;
            [self animateTextField:textField up:YES];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.PostOpBUNTF || textField == self.AdditionalDiagTF || textField == self.PostOpCreatinineTF) {
        
        [self animateTextField:textField up:NO];
        if (isUp) {
            isUp = NO;
        }
        
    }else if (textField == self.ComplicationsTF){
        
        [self.complicationsLbl setHidden:NO];
        [self.complicationsSelectLbl setHidden:NO];
        [self.nightsBtn setEnabled:YES];
        [self.ComplicationsTF setEnabled:NO];
        
        if (self.ComplicationsTF.text.length > 0) {
            [self.complicationsSelectLbl setText:self.ComplicationsTF.text];
        }
        [self.ComplicationsTF setText:@""];
        
    }
    
    if (isUp){
        [self animateTextField:textField up:NO];
        isUp = NO;
    }
    
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)pickerDonePressed:(id)sender {
    
    if ([self.PreOpBUNTF isFirstResponder]) {
        if (isUp){
            [self animateTextField:self.PostOpBUNTF up:NO];
            isUp = NO;
        }
        
        [self.PreOpBUNTF resignFirstResponder];
        
    }else if ([self.PostOpBUNTF isFirstResponder]){
        
        [self animateTextField:self.PostOpBUNTF up:NO];
        isUp = NO;
        [self.PostOpBUNTF resignFirstResponder];
        
    }else if ([self.PreOpCreatinineTF isFirstResponder]){
        
        [self.PreOpCreatinineTF resignFirstResponder];
        
    }else if ([self.PostOpCreatinineTF isFirstResponder]){
        
        [self animateTextField:self.PostOpBUNTF up:NO];
        isUp = NO;
        [self.PostOpCreatinineTF resignFirstResponder];
        
    }else{
        
        int row = [self.picker selectedRowInComponent:0];
        
        if ([self.parent.pickerCheck isEqualToString:@"Nights"]) {
            
            [self.complicationsBtn setEnabled:YES];
            [self.nightSelectLbl setText:[self.parent.pickerArray objectAtIndex:row]];
            
        }else if ([self.parent.pickerCheck isEqualToString:@"Complications"]){
            
            NSString *tempStr = [self.parent.pickerArray objectAtIndex:row];
            if ([tempStr isEqualToString:@"Other"]) {
                
                [self.complicationsLbl setHidden:YES];
                [self.complicationsSelectLbl setHidden:YES];
                [self.ComplicationsTF becomeFirstResponder];
                
            }else{
                [self.nightsBtn setEnabled:YES];
                [self.complicationsSelectLbl setText:[self.parent.pickerArray objectAtIndex:row]];
            }
            
        }
    }
    
    [self.t_toolbar setHidden:YES];
    [self.picker setHidden:YES];
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSUInteger numRows=self.parent.pickerArray.count;
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *title = @"";
    title = (NSString*)[self.parent.pickerArray objectAtIndex:row];
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}





@end
