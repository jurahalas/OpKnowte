//
//  UCLRPNPageOneViewController.m
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/13/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCLRPNPageOneViewController.h"
#import "UCLRPNPagetwoViewController.h"
#import "UCSettingsViewController.h"
#import "UCESWLDataPointsPageOne.h"
#import "UCTWTPPageOneViewController.h"
#import "UCSixMonthTimePointViewController.h"
#import "UCESWLTimePoint.h"


@interface UCLRPNPageOneViewController ()

@end


NSString *dateOfService;
BOOL MRCheckExist;

@implementation UCLRPNPageOneViewController
@synthesize parentModel,home, ESWLparentModel;

@synthesize sex;
@synthesize sexPicker;
@synthesize patientNameTitle, txtPatientName;
@synthesize txtMedicalRecordNo, lblDateOfService;
@synthesize lblPatientDOB, lblSex, bgSex, disclosoryBtnSex;
@synthesize datePicker;
@synthesize timePoint, isComingFromUrl, urlCaseID, urlPatientDOB, urlPatientDOS, urlPatientGender, urlPatientMR, urlPatientName, urlTimepointID, urlUserID, urlProcedureID, urlStonesCount;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.parentModel = [[UCLRPNModel alloc] init];
        self.ESWLparentModel = [[ESWLModel alloc] init];
        MRCheckExist = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"MM-dd-yyyy"];
    [datePicker setMaximumDate:[NSDate date]];
    isDOBSelected = NO;
    isRecordSelection = NO;
    
    if (IS_IPHONE_5) {
         l_Header.frame=CGRectMake(l_Header.frame.origin.x, l_Header.frame.origin.y+5, l_Header.frame.size.width, l_Header.frame.size.height);
    }
    [l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    l_Header.text=[UCAppDelegate sharedObject].selectedProcedure.procedureText;
    
    [self.txtPatientName setAutocapitalizationType:UITextAutocapitalizationTypeWords];
    
    if (self.isComingFromUrl) {
        l_Header.text = @"ONGOING CLINICAL DETAILS";
        
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *dos = [dateformatter dateFromString:self.urlPatientDOS];
        [dateformatter setDateFormat:@"MM-dd-yyyy"];
        self.urlPatientDOS = [dateformatter stringFromDate:dos];
        
        self.txtPatientName.text = self.urlPatientName;
        self.txtPatientName.enabled = NO;
        
        lblPatientDOB.text = self.urlPatientDOB;
        
        txtMedicalRecordNo.text = self.urlPatientMR;
        txtMedicalRecordNo.enabled = NO;
        
        [lblDateOfService setText:self.urlPatientDOS];
        
        lblSex.text = self.urlPatientGender;
        
        [self.lblSex setHidden:YES];
        [self.bgSex setHidden:YES];
        [self.disclosoryBtnSex setHidden:YES];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    
}


- (void)didReceiveMemoryWarning
{
    [self setDatePicker:nil];
    [self setPatientNameTitle:nil];
    [self setTxtPatientName:nil];
    [self setTxtMedicalRecordNo:nil];
    [self setLblDateOfService:nil];
    [self setLblPatientDOB:nil];
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    t_textField=textField;
    t_toolbar.hidden = YES;
    datePicker.hidden = YES;
    [self.sexPicker removeFromSuperview];
    
    if ([textField tag] == 1) {
        isRecordSelection = YES;
        [t_toolbar setHidden:NO];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == txtMedicalRecordNo) {
        if (textField.text.length > 0) {
            NSLog(@"%@",textField.text);
            [UCUtility showBlockView];
            [UCWebServerHandler checkMRNuber:textField.text withDelegate:self];
        }
    }
}

- (void)CheckMRSuccessHandler:(ASIHTTPRequest *)request {
    [UCUtility hideBlockView];
    NSString *response = [request responseString];
    NSLog(@"%@",response);
    
    id result = [response JSONValue];
    if ([[result objectForKey:@"status"] isEqualToString:@"true"]) {
        MRCheckExist = NO;
    }
    else {
        MRCheckExist = YES;
        [UCUtility showInfoAlertView:@"" withMessage:@"Medical record number already exists. Please change it."];
    }
    
    result = nil;
    response = nil;
}

- (void)CheckMRErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}





- (void)animateTextField:(BOOL)up {
    const int movementDistance = 40; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (BOOL)verifyData {
    
    if(self.txtPatientName.text.length > 0 && lblPatientDOB.text.length > 0 && ![lblPatientDOB.text isEqualToString:@"Patient DOB"] && txtMedicalRecordNo.text.length > 0 && lblDateOfService.text.length > 0 && lblSex.text.length > 0 && ![lblSex.text isEqualToString:@"Sex"] && [self isValidText:self.txtPatientName.text] && [self isValidText:txtMedicalRecordNo.text]) {
        return TRUE;
    }
    else
        return FALSE;
}

- (BOOL)isDateValid {
    NSDate *today = [NSDate date];
    NSDate *yesterday = [today dateByAddingTimeInterval: 86400.0];
    
    NSComparisonResult result = [[datePicker date] compare:yesterday];
    
    switch (result)
    {
        case NSOrderedAscending:
        {
            return TRUE;
        }
        case NSOrderedDescending:
        {
            return FALSE;
        }
        case NSOrderedSame:
        {
            return FALSE;
        }
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789  "] invertedSet];
    
    if ([textField.text rangeOfCharacterFromSet:set].location != NSNotFound) {
        
        if(![string isEqualToString:@" "]) {
            NSString *newString = [textField.text substringToIndex:[textField.text length]-1];
            textField.text=newString;
        }
        
        NSLog(@"This string contains illegal characters%@ %i",string,range.length);;
        
    }
    return TRUE;
}

- (BOOL)isValidText:(NSString *)text {
    
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    
    if ([text rangeOfCharacterFromSet:set].location != NSNotFound) {
        return TRUE;
    }
    else
        return TRUE;
}

- (IBAction)datePickerDone:(id)sender {
    
    [t_textField resignFirstResponder];
    
    if (isSexSelection == YES) {
        isSexSelection = NO;
        [self.sexPicker removeFromSuperview];
        t_toolbar.hidden = true;
        
    } else if (isRecordSelection) {
        isRecordSelection = NO;
        t_toolbar.hidden = YES;
    }
    else {
        NSString *date = [dateformater stringFromDate:datePicker.date];
        
        if(![self isDateValid]) {
            [UCUtility showInfoAlertView:@"Error" withMessage:@"You cant select a date from future"];
        }
        else {
            if (isDOBSelected) {
                [lblPatientDOB setText:date];
            }
            else {
                [lblDateOfService setText:date];
                
                NSDateFormatter *formater = [[NSDateFormatter alloc] init];
                [formater setDateFormat:@"yyyy-MM-dd"];
                dateOfService = [NSString stringWithFormat:@"%@",[formater stringFromDate:datePicker.date]];
               // NSLog(@"%@",dateOfService);
                
            }
            
            datePicker.hidden = YES;
            t_toolbar.hidden = YES;
            
            isDOBSelected = FALSE;
        }
    }
}

- (IBAction)patientDOBExpandPressed:(id)sender {
    
    if (!self.isComingFromUrl) {
        [t_textField resignFirstResponder];
        isDOBSelected = YES;
        
        if ((lblPatientDOB.text.length > 2) && (![lblPatientDOB.text isEqualToString:@"Patient DOB"])) {
            
            [datePicker setDate:[dateformater dateFromString:lblPatientDOB.text]];
        }
        else {
            NSString *str = @"01-01-1950";
            [datePicker setDate:[dateformater dateFromString:str]];
        }
        
        datePicker.hidden = FALSE;
        t_toolbar.hidden = FALSE;
    }
    
}

- (IBAction)dateOfServiceExpandPressed:(id)sender {
    
    if (!self.isComingFromUrl) {
        [t_textField resignFirstResponder];
        isDOBSelected = NO;
        
        if ((lblDateOfService.text.length > 2) && (![lblDateOfService.text isEqualToString:@"Date Of Service"])) {
            [datePicker setDate:[dateformater dateFromString:lblDateOfService.text]];
        }
        else {
            [datePicker setDate:[NSDate date]];
        }
        
        datePicker.hidden = FALSE;
        t_toolbar.hidden = FALSE;
    }
    
}

- (IBAction)backButtonPressed:(id)sender {
    [UCAppDelegate sharedObject].selectedUser = nil;
    if (self.isComingFromUrl) {
        [self dismissModalViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:NO];
    }
    
}

- (IBAction)homeButtonPressed:(id)sender {
    if ([UCAppDelegate sharedObject].isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}

- (IBAction)forwardButtonPressed:(id)sender {
    
    if (self.isComingFromUrl) {
        
        if ([self.urlProcedureID intValue] == 2) {
            if ([self.timePoint intValue] == 1) {
                
                UCTWTPPageOneViewController *controller = [[UCTWTPPageOneViewController alloc] initWithNibName:@"UCTWTPPageOneViewController" bundle:nil];
                controller.isComingFromUrl = YES;
                controller.urlCaseID = self.urlCaseID;
                controller.urlTimepointID = self.urlTimepointID;
                controller.urlUserID = self.urlUserID;
                controller.urlProcedureID = self.urlProcedureID;
                [self.navigationController pushViewController:controller animated:YES];
                
            }else if ([self.timePoint intValue] >1 && [self.timePoint intValue] <12) {
                
                UCSixMonthTimePointViewController *controller = [[UCSixMonthTimePointViewController alloc] initWithNibName:@"UCSixMonthTimePointViewController" bundle:nil];
                controller.isComingFromUrl = YES;
                controller.urlCaseID = self.urlCaseID;
                controller.urlTimepointID = self.urlTimepointID;
                controller.urlUserID = self.urlUserID;
                controller.urlProcedureID = self.urlProcedureID;
                [self.navigationController pushViewController:controller animated:YES];
            }
        }else if ([self.urlProcedureID intValue] == 10){
            
            UCESWLTimePoint *controller = [[UCESWLTimePoint alloc] initWithNibName:@"UCESWLTimePoint" bundle:nil];
            
            controller.stonesCount = self.urlStonesCount;
            controller.caseID = self.urlCaseID;
            controller.urlUserID = self.urlUserID;
            controller.urlProcedureID = self.urlProcedureID;
            controller.isComingFromURL = YES;
            
            [self.navigationController pushViewController:controller animated:YES];
            
        }
        
    }else{
        
        NSLog(@"%@",[[UCAppDelegate sharedObject].selectedProcedure procedureID]);
        if ([self verifyData]) {
            
            if (MRCheckExist) {
                
                [UCUtility showInfoAlertView:@"" withMessage:@"Medical record number already exists. Please change it."];
            }else{
                
                if ([[[UCAppDelegate sharedObject].selectedProcedure procedureID] intValue] == 2) {
                    self.parentModel = [[UCLRPNModel alloc] init];
                    self.parentModel.var_patientName = self.txtPatientName.text;
                    self.parentModel.var_patientDOB = lblPatientDOB.text;
                    self.parentModel.var_age = [UCUtility getAge:lblPatientDOB.text];
                    self.parentModel.var_MRNumber = txtMedicalRecordNo.text;
                    self.parentModel.var_sex = lblSex.text;
                    self.parentModel.var_DOS = dateOfService;
                    
                    if ([self varifyDates]) {
                        UCLRPNPagetwoViewController *homeScreenTemp;
                        if(IS_IPHONE_5)
                        {
                            homeScreenTemp = [[UCLRPNPagetwoViewController alloc] initWithNibName:@"UCLRPNPagetwoViewController" bundle:nil];
                        }
                        else
                        {
                            homeScreenTemp = [[UCLRPNPagetwoViewController alloc] initWithNibName:@"UCLRPNPagetwoViewController" bundle:nil];
                            
                        }
                        homeScreenTemp.parent = self;
                        [self.navigationController pushViewController:homeScreenTemp animated:NO];
                        
                    }else{
                        [UCUtility showInfoAlertView:@"" withMessage:@"Date of Birth cannot be in future of Date of Service"];
                    }
                    
                    
                }
                else if ([[[UCAppDelegate sharedObject].selectedProcedure procedureID] intValue] == 10){
                    
                    if (self.ESWLparentModel == nil) {
                        self.ESWLparentModel = [[ESWLModel alloc] init];
                    }
                    self.ESWLparentModel.var_patientName = self.txtPatientName.text;
                    self.ESWLparentModel.var_patientDOB = lblPatientDOB.text;
                    self.ESWLparentModel.var_age = [UCUtility getAge:lblPatientDOB.text];
                    self.ESWLparentModel.var_MRNumber = txtMedicalRecordNo.text;
                    self.ESWLparentModel.var_sex = lblSex.text;
                    self.ESWLparentModel.var_DOS = dateOfService;
                    
                    UCESWLDataPointsPageOne *controller = [[UCESWLDataPointsPageOne alloc] initWithNibName:@"UCESWLDataPointsPageOne" bundle:nil];
                    controller.parent = self;
                    [self.navigationController pushViewController:controller animated:YES];
                    
                }
                
            }
        }
        else{
            [UCUtility showInfoAlertView:@"Error" withMessage:@"Please complete all required fields."];
        }

    }
    
}


-(BOOL)varifyDates{
    NSDate *d1;
    NSDate *d2;
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"MM-dd-yyyy"];
    d1 = [dateFormat1 dateFromString:lblPatientDOB.text];
    d2 = [dateFormat1 dateFromString:lblDateOfService.text];
    
    NSComparisonResult result = [d2 compare:d1];
    
    switch (result)
    {
        case NSOrderedAscending: NSLog(@"%@ is in future from %@", d1, d2);
            return NO;
            break;
        case NSOrderedDescending: NSLog(@"%@ is in past from %@", d1, d2);
            return YES;
            break;
        case NSOrderedSame: NSLog(@"%@ is the same as %@", d1, d2);
            return YES;
            break;
        default: NSLog(@"erorr dates %@, %@", d1, d2);
            return NO;
            break;
    }
}

- (IBAction)SettingsView:(id)sender {
    UCSettingsViewController *setting = nil;
    if(IS_IPHONE_5) {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController" bundle:nil];
    }
    else {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController_iphone" bundle:nil];
    }
    [self.navigationController pushViewController:setting animated:YES];
    setting = nil;
}


- (IBAction)expandSex:(id)sender {
    
    if (!self.isComingFromUrl) {
        self.sex = [[NSMutableArray alloc] initWithObjects:@"Male",@"Female", nil];
        
        t_toolbar.hidden = false;
        isSexSelection = YES;
        
        self.sexPicker = [[UIPickerView alloc] initWithFrame:datePicker.frame];
        [self.sexPicker setDelegate:self];
        [self.sexPicker setDataSource:self];
        [self.sexPicker setShowsSelectionIndicator:YES];
        [self.view addSubview:self.sexPicker];
        
        [self.sexPicker reloadAllComponents];
        
        if([self.lblSex.text isEqualToString:@"Male"]) {
            [self.sexPicker selectRow:0 inComponent:0 animated:NO];
        }else if([self.lblSex.text isEqualToString:@"Female"]) {
            [self.sexPicker selectRow:1 inComponent:0 animated:NO];
        }else {
            self.lblSex.text = (NSString*)[sex objectAtIndex:0];
        }
    }
}


#pragma mark - Picker View Delegate Method

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.lblSex setText:[self.sex objectAtIndex:row]];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.sex count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.sex objectAtIndex:row];
}

#pragma mark - End


@end
