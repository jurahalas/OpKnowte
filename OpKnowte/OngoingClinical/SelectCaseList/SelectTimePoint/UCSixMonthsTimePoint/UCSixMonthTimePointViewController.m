//
//  UCSixMonthTimePointViewController.m
//  MZUroCapture
//
//  Created by Atif Joyia on 13/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSixMonthTimePointViewController.h"
#import "UCSettingsViewController.h"
#import "UCTimePointSummaryViewController.h"

@interface UCSixMonthTimePointViewController ()

@end

BOOL isUP;

@implementation UCSixMonthTimePointViewController

@synthesize caseData, timePoint, onGoingData, scroller;
@synthesize picker, pickerArray, pickerCheck, t_toolbar;
@synthesize XRayTF, HerniaTF, LiverTF, OtherTF, BunTF, CTScanTF;
@synthesize xrayLbl, xraySelectLbl, bunLbl, bunSelectLbl, liverLbl, liverSelectLbl, herniaLbl, herniaSelectLbl, ctScanLbl, ctScanSelectLbl, otherLbl, otherSelectLbl;
@synthesize isComingFromUrl, urlUserID, urlTimepointID, urlCaseID, urlProcedureID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.caseData = [[NSMutableDictionary alloc] init];
        self.timePoint = [[NSDictionary alloc] init];
        self.onGoingData = [[NSMutableDictionary alloc] init];
        isSummary = NO;
        self.isComingFromUrl = NO;
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

- (IBAction)pickerDonePressed:(id)sender {
    
    int row = [self.picker selectedRowInComponent:0];
    
    if ([self.pickerCheck isEqualToString:@"CXRay"]){
        
        [self.xraySelectLbl setText:[self.pickerArray objectAtIndex:row]];
        if ([self.xraySelectLbl.text isEqualToString:@"Positive"]) {
            [self.XRayTF setEnabled:YES];
        }else if ([self.xraySelectLbl.text isEqualToString:@"Negative"]){
            [self.XRayTF setText:@""];
            [self.XRayTF setEnabled:NO];
        }
        
    }else if ([self.pickerCheck isEqualToString:@"Liver"]){
        
        [self.liverSelectLbl setText:[self.pickerArray objectAtIndex:row]];
        
        if ([self.liverSelectLbl.text isEqualToString:@"Normal"]) {
            [self.LiverTF setText:@""];
            [self.LiverTF setEnabled:NO];
        }else if ([self.liverSelectLbl.text isEqualToString:@"Abnormal"]) {
            [self.LiverTF setEnabled:YES];
        }
        
    }else if ([self.pickerCheck isEqualToString:@"Hernia"]){
        
        [self.herniaSelectLbl setText:[self.pickerArray objectAtIndex:row]];
        
    }else if ([self.pickerCheck isEqualToString:@"CTScan"]){
        
        [self.ctScanSelectLbl setText:[self.pickerArray objectAtIndex:row]];
        
    }
    
    //CTScan
    [self.t_toolbar setHidden:YES];
    [self.picker setHidden:YES];
    
    [self.BunTF resignFirstResponder];
    [self.CreatinineTF resignFirstResponder];
    [self.LiverTF resignFirstResponder];
    [self.XRayTF resignFirstResponder];
}


-(IBAction)update:(UIButton *)sender{
    
    if ([self.xraySelectLbl.text isEqualToString:@"Select"] || self.BunTF.text.length == 0 || self.CreatinineTF.text.length == 0 || [self.liverSelectLbl.text isEqualToString:@"Select"] || [self.herniaSelectLbl.text isEqualToString:@"Select"] || [self.ctScanSelectLbl.text isEqualToString:@"Select"]) {
        
        [UCUtility showInfoAlertView:@"" withMessage:@"Please select all required fields to proceed."];
    }else{
        
        
        UCTimePointSummaryViewController *controller = [[UCTimePointSummaryViewController alloc] initWithNibName:@"UCTimePointSummaryViewController" bundle:nil];
        
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
        
        if ([self.xraySelectLbl.text isEqualToString:@"Positive"] && self.XRayTF.text.length == 0) {
                
                [UCUtility showInfoAlertView:@"" withMessage:@"Please enter some description for Positive Chest x-ray"];
            
        }else if ([self.liverSelectLbl.text isEqualToString:@"Abnormal"] && self.LiverTF.text.length == 0){
            
            [UCUtility showInfoAlertView:@"" withMessage:@"Please enter some description for Abnormal Liver Enzymez"];
            
        }else{
            
            if ([self.xraySelectLbl.text isEqualToString:@"Positive"]){
                [tempDictionary setObject:self.XRayTF.text forKey:XRAY_STAGE];
                [controller.summaryDictionary setObject:self.XRayTF.text forKey:XRAY_STAGE];
            }else{
                [tempDictionary setObject:self.xraySelectLbl.text forKey:XRAY_STAGE];
                [controller.summaryDictionary setObject:self.xraySelectLbl.text forKey:XRAY_STAGE];
            }
            
            
            if ([self.liverSelectLbl.text isEqualToString:@"Abnormal"]) {
                
                [tempDictionary setObject:self.LiverTF.text forKey:LIVER_ENZYMES_STAGE];
                [controller.summaryDictionary setObject:self.LiverTF.text forKey:self.liverLbl.text];
            }else{
                
                [tempDictionary setObject:self.liverSelectLbl.text forKey:LIVER_ENZYMES_STAGE];
                [controller.summaryDictionary setObject:self.liverSelectLbl.text forKey:self.liverLbl.text];
            }
            
            
            [tempDictionary setObject:self.BunTF.text forKey:BUN_STAGE];
            [controller.summaryDictionary setObject:self.BunTF.text forKey:self.BunTF.placeholder];
            
            [tempDictionary setObject:self.CreatinineTF.text forKey:CREATININE_STAGE];
            [controller.summaryDictionary setObject:self.CreatinineTF.text forKey:self.CreatinineTF.placeholder];
            
            [tempDictionary setObject:self.herniaSelectLbl.text forKey:HERNIA_STAGE];
            [controller.summaryDictionary setObject:self.herniaSelectLbl.text forKey:self.herniaLbl.text];
            
            [tempDictionary setObject:self.OtherTF.text forKey:OTHER_STAGE];
            [controller.summaryDictionary setObject:self.OtherTF.text forKey:self.OtherTF.placeholder];
            
            [tempDictionary setObject:self.ctScanSelectLbl.text forKey:CT_SCAN_STAGE];
            [controller.summaryDictionary setObject:self.ctScanSelectLbl.text forKey:self.ctScanLbl.text];
            
            
            controller.sixMonthsDict = [tempDictionary mutableCopy];
            
            controller.caseData = self.caseData;
            controller.caseID = [self.caseData objectForKey:@"DetailID"];
            controller.timePointID = [self.timePoint objectForKey:@"id"];
            controller.timePoint = @"Six";
            
            if (self.isComingFromUrl){
                
                [UCUtility showBlockView];
                
                [tempDictionary setObject:self.urlProcedureID forKey:@"procedureID"];
                [UCWebServerHandler addSixWeeksOngoingClinicalDetail:self.urlCaseID withTimePointID:self.urlTimepointID withDictionary:tempDictionary withUserID:self.urlUserID withDelegate:self];
                
            }else{
                [UCUtility showBlockView];
                
                [tempDictionary setObject:[UCAppDelegate sharedObject].selectedProcedure.procedureID forKey:@"procedureID"];
                
                if([UCAppDelegate sharedObject].selectedUser!=nil)
                {
                    [UCWebServerHandler addSixWeeksOngoingClinicalDetail:[self.caseData objectForKey:@"DetailID"] withTimePointID:[self.timePoint objectForKey:@"id"] withDictionary:tempDictionary withUserID:[[UCAppDelegate sharedObject].selectedUser userID] withDelegate:self];
                }
                else
                {
                    
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [UCWebServerHandler addSixWeeksOngoingClinicalDetail:[self.caseData objectForKey:@"DetailID"] withTimePointID:[self.timePoint objectForKey:@"id"] withDictionary:tempDictionary withUserID:[defaults objectForKey:UD_USERID] withDelegate:self];
                }
            
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
        
        if (self.isComingFromUrl) {
            [self dismissModalViewControllerAnimated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
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


-(void)viewWillAppear:(BOOL)animated{
    if (isSummary) {
        isSummary = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    isUP = NO;
    
    if(IS_IPHONE_5)
    {
        headerLbl_.frame=CGRectMake(headerLbl_.frame.origin.x, headerLbl_.frame.origin.y+5, headerLbl_.frame.size.width, headerLbl_.frame.size.height);
    }
    [self.scroller setContentSize:CGSizeMake(320, 438)];
    [headerLbl_ setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    [self.herniaSelectLbl setText:@"No"];
    [self.ctScanSelectLbl setText:@"No evidence of metastatic disease"];
    [self.xraySelectLbl setText:@"Negative"];
    [self.liverSelectLbl setText:@"Normal"];
    
    if (self.isComingFromUrl) {
        
        [UCUtility showBlockView];
        [UCWebServerHandler getOngoingClinicalDetail:self.urlCaseID withTimePointID:self.urlTimepointID withUserID:urlUserID withProcedureID:self.urlProcedureID withDelegate:self];
        
    }else{
        [UCUtility showBlockView];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [UCWebServerHandler getOngoingClinicalDetail:[self.caseData objectForKey:@"DetailID"] withTimePointID:[self.timePoint objectForKey:@"id"] withUserID:[defaults objectForKey:UD_USERID] withProcedureID:[UCAppDelegate sharedObject].selectedProcedure.procedureID withDelegate:self];
    }
    
    
    
}


- (void)OnGoingDetailSuccessHandler:(ASIHTTPRequest *)request {
    
    [UCUtility hideBlockView];
    NSString *response = [request responseString];
    NSLog(@"%@",response);
    id result = [response JSONValue];
    if (result && [[result objectForKey:@"status"] isEqualToString:@"true"] > 0) {
        
        if (self.onGoingData == nil) {
            self.onGoingData = [[NSMutableDictionary alloc] init];
        }
        [self.onGoingData removeAllObjects];
        self.onGoingData = [result mutableCopy];
        
        [self setValues];
        
    }else{
    }
    
    response = nil;
    
}

- (void)OnGoingDetailErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}


-(void)setValues{
    
    NSDictionary *dict = [[self.onGoingData objectForKey:@"clinicalData"] objectAtIndex:0];
    
    NSString *str;// = [[NSString alloc] init];
    str = [dict objectForKey:XRAY_STAGE];
    
    if (str.length > 0) {
        if ([str isEqualToString:@"Negative"]) {
            [self.xraySelectLbl setText:str];
        }else{
            [self.xraySelectLbl setText:@"Positive"];
            [self.XRayTF setText:str];
            [self.XRayTF setEnabled:YES];
        }
        
    }
    
    str = [dict objectForKey:@"Bun"];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.BunTF setText:str];
    }
    
    str = [dict objectForKey:@"Creatinine"];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.CreatinineTF setText:str];
    }
    
    str = [dict objectForKey:LIVER_ENZYMES_STAGE];
    NSLog(@"%@",str);
    if (str.length > 0) {
        
        if ([str isEqualToString:@"Normal"]) {
            [self.liverSelectLbl setText:str];
        }else{
            [self.liverSelectLbl setText:@"Abnormal"];
            [self.LiverTF setText:str];
            [self.LiverTF setEnabled:YES];
        }
    }
    
    str = [dict objectForKey:HERNIA_STAGE];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.herniaSelectLbl setText:str];
    }
    
    str = [dict objectForKey:CT_SCAN_STAGE];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.ctScanSelectLbl setText:str];
    }
    
    str = [dict objectForKey:@"other"];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.otherSelectLbl setText:str];
    }
}


-(IBAction)expandChestXray:(id)sender{
    
    [self.BunTF resignFirstResponder];
    [self.CreatinineTF resignFirstResponder];
    [self.LiverTF resignFirstResponder];
    [self.XRayTF resignFirstResponder];
    
    if (isUP) {
        [self animateTextField:self.OtherTF up:NO];
        [self.OtherTF resignFirstResponder];
        isUP = NO;
    }
    
    self.pickerCheck = @"CXRay";
    [self.picker setHidden:NO];
    [self.t_toolbar setHidden:NO];
    
    
    [self.pickerArray removeAllObjects];
    self.pickerArray = nil;
    self.pickerArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    [self.pickerArray addObject:@"Positive"];
    [self.pickerArray addObject:@"Negative"];
    
    [self.picker reloadAllComponents];
    
    if (self.xraySelectLbl.text.length > 0) {
        for (int i = 0; i < [self.pickerArray count]; i++) {
            NSString *str = [self.pickerArray objectAtIndex:i];
            if ([self.xraySelectLbl.text isEqualToString:str]) {
                [self.picker selectRow:i inComponent:0 animated:YES];
                break;
            }
        }
    }else{
        [self.picker selectRow:0 inComponent:0 animated:YES];
    }
    
}


-(IBAction)expandLiver:(id)sender{
    
    [self.BunTF resignFirstResponder];
    [self.CreatinineTF resignFirstResponder];
    [self.LiverTF resignFirstResponder];
    [self.XRayTF resignFirstResponder];
    
    if (isUP) {
        [self animateTextField:self.OtherTF up:NO];
        [self.OtherTF resignFirstResponder];
        isUP = NO;
    }
    
    self.pickerCheck = @"Liver";
    [self.picker setHidden:NO];
    [self.t_toolbar setHidden:NO];
    
    
    [self.pickerArray removeAllObjects];
    self.pickerArray = nil;
    self.pickerArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    [self.pickerArray addObject:@"Normal"];
    [self.pickerArray addObject:@"Abnormal"];
    
    [self.picker reloadAllComponents];
    
    if (self.LiverTF.text.length > 0) {
        for (int i = 0; i < [self.pickerArray count]; i++) {
            NSString *str = [self.pickerArray objectAtIndex:i];
            if ([self.LiverTF.text isEqualToString:str]) {
                [self.picker selectRow:i inComponent:0 animated:YES];
                break;
            }
        }
    }else{
        [self.picker selectRow:0 inComponent:0 animated:YES];
    }
    
}

-(IBAction)expandHernia:(id)sender{
    
    [self.BunTF resignFirstResponder];
    [self.CreatinineTF resignFirstResponder];
    [self.LiverTF resignFirstResponder];
    [self.XRayTF resignFirstResponder];
    
    if (isUP) {
        [self animateTextField:self.OtherTF up:NO];
        [self.OtherTF resignFirstResponder];
        isUP = NO;
    }
    
    self.pickerCheck = @"Hernia";
    [self.picker setHidden:NO];
    [self.t_toolbar setHidden:NO];
    
    
    [self.pickerArray removeAllObjects];
    self.pickerArray = nil;
    self.pickerArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    [self.pickerArray addObject:@"Yes"];
    [self.pickerArray addObject:@"No"];
    
    [self.picker reloadAllComponents];
    
    if (self.herniaSelectLbl.text.length > 0) {
        for (int i = 0; i < [self.pickerArray count]; i++) {
            NSString *str = [self.pickerArray objectAtIndex:i];
            if ([self.herniaSelectLbl.text isEqualToString:str]) {
                [self.picker selectRow:i inComponent:0 animated:YES];
                break;
            }
        }
    }else{
        [self.picker selectRow:0 inComponent:0 animated:YES];
    }
}


-(IBAction)expandCTScan:(id)sender{
    
    [self.BunTF resignFirstResponder];
    [self.CreatinineTF resignFirstResponder];
    [self.LiverTF resignFirstResponder];
    [self.XRayTF resignFirstResponder];
    
    if (isUP) {
        [self animateTextField:self.OtherTF up:NO];
        [self.OtherTF resignFirstResponder];
        isUP = NO;
    }
    
    self.pickerCheck = @"CTScan";
    [self.picker setHidden:NO];
    [self.t_toolbar setHidden:NO];
    
    
    [self.pickerArray removeAllObjects];
    self.pickerArray = nil;
    self.pickerArray = [[NSMutableArray alloc] init];
    
    [self.pickerArray addObject:@"No evidence of metastatic disease"];
    [self.pickerArray addObject:@"Local recurrence"];
    [self.pickerArray addObject:@"Lymphadenopathy"];
    [self.pickerArray addObject:@"Liver metastasis"];
    [self.pickerArray addObject:@"Bone metastasis"];
    [self.pickerArray addObject:@"Brain metastasis"];
    [self.pickerArray addObject:@"Not performed"];
    //Not performed
    
    [self.picker reloadAllComponents];
    
    if (self.ctScanSelectLbl.text.length > 0) {
        for (int i = 0; i < [self.pickerArray count]; i++) {
            NSString *str = [self.pickerArray objectAtIndex:i];
            if ([self.ctScanSelectLbl.text isEqualToString:str]) {
                [self.picker selectRow:i inComponent:0 animated:YES];
                break;
            }
        }
    }else{
        [self.picker selectRow:0 inComponent:0 animated:YES];
    }
    
}


-(IBAction)expandBUN:(id)sender{
    
    [self.bunLbl setHidden:YES];
    [self.bunSelectLbl setHidden:YES];
    [self.BunTF becomeFirstResponder];
    
}

-(IBAction)expandOther:(id)sender{
    
    [self.BunTF resignFirstResponder];
    [self.CreatinineTF resignFirstResponder];
    [self.LiverTF resignFirstResponder];
    [self.XRayTF resignFirstResponder];
    
    [self.OtherTF setEnabled:YES];
    [self.otherLbl setHidden:YES];
    [self.otherSelectLbl setHidden:YES];
    [self.OtherTF becomeFirstResponder];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    if (IS_IPHONE_5) {
        if (isUP) {
            if (textField == self.OtherTF) {
                const int movementDistance = 150; // tweak as needed
                const float movementDuration = 0.3f; // tweak as needed
                int movement = (up ? -movementDistance : movementDistance);
                
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                self.view.frame = CGRectOffset(self.view.frame, 0, movement);
                [UIView commitAnimations];
            }
        }
        
    }else{
        
        if ([self.OtherTF isFirstResponder]) {
            const int movementDistance = 140; // tweak as needed
            const float movementDuration = 0.3f; // tweak as needed
            int movement = (up ? -movementDistance : movementDistance);
            
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
    
    if (isUP) {
        [self animateTextField:self.OtherTF up:NO];
        [self.OtherTF resignFirstResponder];
        isUP = NO;
    }
    
    if (textField == self.BunTF) {
        [t_toolbar setHidden:NO];
        if (![self.bunSelectLbl.text isEqualToString:@"Select"]) {
            [self.BunTF setText:self.bunSelectLbl.text];
        }
    }else if (textField == self.OtherTF){
        isUP = YES;
        [self animateTextField:textField up:YES];
        if (![self.otherSelectLbl.text isEqualToString:@"Select"]) {
            [self.OtherTF setText:self.otherSelectLbl.text];
        }
    }else if (textField == self.CreatinineTF){
        [t_toolbar setHidden:NO];
    }
   
    //[self animateTextField:textField up:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.BunTF) {
        //[self animateTextField:textField up:NO];
        [self.bunLbl setHidden:NO];
        [self.bunSelectLbl setHidden:NO];
        if (textField.text.length > 0) {
            [self.bunSelectLbl setText:textField.text];
        }else{
            [self.bunSelectLbl setText:@"Select"];
        }
        
        textField.text = @"";
        
    }else if (textField == self.OtherTF){
        
        [self animateTextField:textField up:NO];
        isUP = NO;
        [self.otherLbl setHidden:NO];
        [self.otherSelectLbl setHidden:NO];
        if (textField.text.length > 0) {
            [self.otherSelectLbl setText:textField.text];
        }else{
            [self.otherSelectLbl setText:@"Select"];
        }
        //textField.text = @"";
        
    }
    [textField resignFirstResponder];
    return YES;
}




// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSUInteger numRows=self.pickerArray.count;
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *title = @"";
    title = (NSString*)[self.pickerArray objectAtIndex:row];
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 101) {
        
        if (buttonIndex == 0) {
            
            [self setValues];
            
        }else if (buttonIndex == 1){
            
            NSDictionary *dict = [[self.onGoingData objectForKey:@"clinicalData"] objectAtIndex:0];
            NSLog(@"%@",dict);
            
            UCTimePointSummaryViewController *controller = [[UCTimePointSummaryViewController alloc] initWithNibName:@"UCTimePointSummaryViewController" bundle:nil];
            
            NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
            
            [tempDictionary setObject:[dict objectForKey:XRAY_STAGE] forKey:XRAY_STAGE];
            [controller.summaryDictionary setObject:[dict objectForKey:XRAY_STAGE] forKey:self.xrayLbl.text];
            
            [tempDictionary setObject:[dict objectForKey:BUN_STAGE] forKey:BUN_STAGE];
            [controller.summaryDictionary setObject:[dict objectForKey:BUN_STAGE] forKey:self.BunTF.placeholder];
            
            [tempDictionary setObject:[dict objectForKey:CREATININE_STAGE] forKey:CREATININE_STAGE];
            [controller.summaryDictionary setObject:[dict objectForKey:CREATININE_STAGE] forKey:self.CreatinineTF.placeholder];
            
            [tempDictionary setObject:[dict objectForKey:LIVER_ENZYMES_STAGE] forKey:LIVER_ENZYMES_STAGE];
            [controller.summaryDictionary setObject:[dict objectForKey:LIVER_ENZYMES_STAGE] forKey:self.liverLbl.text];
            
            [tempDictionary setObject:[dict objectForKey:HERNIA_STAGE] forKey:HERNIA_STAGE];
            [controller.summaryDictionary setObject:[dict objectForKey:HERNIA_STAGE] forKey:self.herniaLbl.text];
            
            [tempDictionary setObject:[dict objectForKey:OTHER_STAGE] forKey:OTHER_STAGE];
            [controller.summaryDictionary setObject:[dict objectForKey:OTHER_STAGE] forKey:self.OtherTF.placeholder];
            
            [tempDictionary setObject:[dict objectForKey:CT_SCAN_STAGE] forKey:CT_SCAN_STAGE];
            [controller.summaryDictionary setObject:[dict objectForKey:CT_SCAN_STAGE] forKey:self.ctScanLbl.text];
            
            controller.sixMonthsDict = [tempDictionary mutableCopy];
            
            controller.caseData = self.caseData;
            controller.caseID = [self.caseData objectForKey:@"DetailID"];
            controller.timePointID = [self.timePoint objectForKey:@"id"];
            controller.timePoint = @"Six";
            
            isSummary = YES;
            [self.navigationController pushViewController:controller animated:YES];
            
        }
        
    }
}


@end
