//
//  UCTWTPPageOneViewController.m
//  MZUroCapture
//
//  Created by Omer on 5/9/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCTWTPPageOneViewController.h"
#import "UCSettingsViewController.h"
#import "CONSTANTS.h"
#import "UCTimePointSummaryViewController.h"
#import "UCUtility.h"

#import "OKClinicalManager.h"
#import "OKProceduresManager.h"


@interface UCTWTPPageOneViewController ()

@end

@implementation UCTWTPPageOneViewController

@synthesize caseData, timePoint, onGoingData, picker, t_toolbar, pickerArray;
@synthesize TtextField, NtextField, MtextField, TCtextField, FGtextField, MargintextField, DMtextField;
@synthesize tcLbl, tcSelectLbl, tSelectLbl, tLbl, fgLbl, fgSelectLbl, marginLbl, marginSelectLbl, dmLbl, dmSelectLbl, nLbl,nSelectLbl, mLbl, mSelectLbl;
@synthesize SummaryDictionary;
@synthesize isComingFromUrl, urlCaseID, urlTimepointID, urlUserID, urlProcedureID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.caseData = [[NSMutableDictionary alloc] init];
        self.timePoint = [[NSDictionary alloc] init];
        self.SummaryDictionary = [[NSMutableDictionary alloc] init];
        self.weeksDictionary = [[NSMutableDictionary alloc] init];
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

- (IBAction)homeButtonPressed:(id)sender {
    if (DELEGATE.isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}
- (IBAction)backButtonPressed:(id)sender {
    //if (self.isComingFromUrl) {
      //  [self dismissModalViewControllerAnimated:YES];
    //}else{
        [self.navigationController popViewControllerAnimated:YES];
    //}
    
}

- (IBAction)FWDButtonPressed:(id)sender {
    
    if ([self.tSelectLbl.text isEqualToString:@"Select"] || [self.nSelectLbl.text isEqualToString:@"Select"] || [self.mSelectLbl.text isEqualToString:@"Select"] || [self.tcSelectLbl.text isEqualToString:@"Select"] || [self.fgSelectLbl.text isEqualToString:@"Select"] || [self.marginSelectLbl.text isEqualToString:@"Select"] || [self.dmSelectLbl.text isEqualToString:@"Select"]) {
        
        [UCUtility showInfoAlertView:@"" withMessage:@"Please fill all required fields to proceed"];
    }else{
        
        if (self.weeksDictionary == nil) {
            self.weeksDictionary = [[NSMutableDictionary alloc] init];
        }
        [self.weeksDictionary removeAllObjects];
        
        [self.weeksDictionary setObject:self.tSelectLbl.text forKey:T_STAGE];
        [self.SummaryDictionary setObject:self.tSelectLbl.text forKey:tLbl.text];
        
        [self.weeksDictionary setObject:self.nSelectLbl.text forKey:N_STAGE];
        [self.SummaryDictionary setObject:self.nSelectLbl.text forKey:nLbl.text];
        
        [self.weeksDictionary setObject:self.mSelectLbl.text forKey:M_STAGE];
        [self.SummaryDictionary setObject:self.mSelectLbl.text forKey:mLbl.text];
        
        [self.weeksDictionary setObject:self.tcSelectLbl.text forKey:TUMOR_CHAR_STAGE];
        [self.SummaryDictionary setObject:self.tcSelectLbl.text forKey:tcLbl.text];
        
        [self.weeksDictionary setObject:self.fgSelectLbl.text forKey:FUHRMAN_GRAGE_STAGE];
        [self.SummaryDictionary setObject:self.fgSelectLbl.text forKey:fgLbl.text];
        
        [self.weeksDictionary setObject:self.marginSelectLbl.text forKey:MARGIN_STAGE];
        [self.SummaryDictionary setObject:self.marginSelectLbl.text forKey:marginLbl.text];
        
        [self.weeksDictionary setObject:self.dmSelectLbl.text forKey:DEEP_MARGIN_STAGE];
        [self.SummaryDictionary setObject:self.dmSelectLbl.text forKey:dmLbl.text];
        
        UCTWTPPageTwoViewController *controller = [[UCTWTPPageTwoViewController alloc] initWithNibName:@"UCTWTPPageTwoViewController" bundle:nil];
        controller.parent = self;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}


- (IBAction)pickerDonePressed:(id)sender {
    
    int row = [self.picker selectedRowInComponent:0];
    
    if ([self.pickerCheck isEqualToString:@"T"]) {
        
        [self.tSelectLbl setText:[self.pickerArray objectAtIndex:row]];
        
    }else if ([self.pickerCheck isEqualToString:@"N"]){
        
        [self.nSelectLbl setText:[self.pickerArray objectAtIndex:row]];
        
    }else if ([self.pickerCheck isEqualToString:@"M"]){
        
        [self.mSelectLbl setText:[self.pickerArray objectAtIndex:row]];
        
    }else if ([self.pickerCheck isEqualToString:@"TC"]){
        
        [self.tcSelectLbl setText:[self.pickerArray objectAtIndex:row]];
        
    }else if ([self.pickerCheck isEqualToString:@"FG"]){
        
        [self.fgSelectLbl setText:[self.pickerArray objectAtIndex:row]];
        
    }else if ([self.pickerCheck isEqualToString:@"Margin"]){
        
        [self.marginSelectLbl setText:[self.pickerArray objectAtIndex:row]];
        
    }else if ([self.pickerCheck isEqualToString:@"DM"]){
        
        [self.dmSelectLbl setText:[self.pickerArray objectAtIndex:row]];
        
    }
    
    [self.t_toolbar setHidden:YES];
    [self.picker setHidden:YES];
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
    if(IS_IPHONE_5)
    {
        headerLbl_.frame=CGRectMake(headerLbl_.frame.origin.x, headerLbl_.frame.origin.y+5, headerLbl_.frame.size.width, headerLbl_.frame.size.height);
    }
    [headerLbl_ setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    [self.marginSelectLbl setText:@"Negative"];
    [self.dmSelectLbl setText:@"Negative"];
    [self.nSelectLbl setText:@"N0"];
    [self.mSelectLbl setText:@"M0"];
     NSLog(@"^^^^^^^  BEFORE CALL");
    
    if (self.isComingFromUrl) {
        
        [UCUtility showBlockView];
        [OKClinicalManager getOngoingClinicalDetail:self.urlCaseID withTimePointID:self.urlTimepointID withUserID:urlUserID withProcedureID:self.urlProcedureID handler:^(NSString *errorMsg, id responseJSON) {

            [UCUtility hideBlockView];
            if(!errorMsg)
                [self OnGoingDetailSuccessHandler:responseJSON];
            else
                [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
        }];
        
    }else{
        
        [UCUtility showBlockView];
        [OKClinicalManager getOngoingClinicalDetail:[self.caseData objectForKey:@"DetailID"] withTimePointID:[self.timePoint objectForKey:@"id"] withUserID:[OKUserManager instance].currentUser.userID withProcedureID:[OKProceduresManager instance].selectedProcedure.procedureID handler:^(NSString *errorMsg, id responseJSON) {
            
            if(!errorMsg)
                [self OnGoingDetailSuccessHandler:responseJSON];
            else
                [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
        }];
    }
}


- (void)OnGoingDetailSuccessHandler:(id)result
{
    
    if (result && [[result objectForKey:@"status"] isEqualToString:@"true"] > 0) {
        
        if (self.onGoingData == nil) {
            self.onGoingData = [[NSMutableDictionary alloc] init];
        }
        [self.onGoingData removeAllObjects];
        self.onGoingData = [result mutableCopy];
        [self setValues];
        
        /*
        NSString *caseID = [[[self.onGoingData objectForKey:@"clinicalData"] objectAtIndex:0] objectForKey:@"caseID"];
        if (caseID.length > 0) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Do you want to edit details or want to view Summary" delegate:self cancelButtonTitle:@"Edit" otherButtonTitles:@"View Summary", nil];
            alert.tag = 101;
            [alert show];
        }else{
            //
        }
         
         */
    }else{
    }
}


-(void)setValues{
    
    NSDictionary *dict = [[self.onGoingData objectForKey:@"clinicalData"] objectAtIndex:0];
    NSLog(@"%@",dict);
    
    NSString *str = [NSString stringWithFormat:@"%@",[dict objectForKey:T_STAGE]];
    
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.tSelectLbl setText:str];
    }
    
    str = [dict objectForKey:N_STAGE];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.nSelectLbl setText:str];
    }
    
    str = [dict objectForKey:M_STAGE];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.mSelectLbl setText:str];
    }
    
    str = [dict objectForKey:TUMOR_CHAR_STAGE];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.tcSelectLbl setText:str];
    }
    
    str = [dict objectForKey:FUHRMAN_GRAGE_STAGE];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.fgSelectLbl setText:str];
    }
    
    str = [dict objectForKey:MARGIN_STAGE];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.marginSelectLbl setText:str];
    }
    
    str = [dict objectForKey:DEEP_MARGIN_STAGE];
    NSLog(@"%@",str);
    if (str.length > 0) {
        [self.dmSelectLbl setText:str];
    }
}


-(IBAction)expandT:(UIButton *)sender{
    
    self.pickerCheck = @"T";
    [self.picker setHidden:NO];
    [self.t_toolbar setHidden:NO];
    
    [self.pickerArray removeAllObjects];
    self.pickerArray = nil;
    self.pickerArray = [[NSMutableArray alloc] initWithCapacity:13];
    
    [self.pickerArray addObject:@"TX"];
    [self.pickerArray addObject:@"T0"];
    [self.pickerArray addObject:@"T1"];
    [self.pickerArray addObject:@"T1a"];
    [self.pickerArray addObject:@"T1b"];
    [self.pickerArray addObject:@"T2"];
    [self.pickerArray addObject:@"T2a"];
    [self.pickerArray addObject:@"T2b"];
    [self.pickerArray addObject:@"T3"];
    [self.pickerArray addObject:@"T3a"];
    [self.pickerArray addObject:@"T3b"];
    [self.pickerArray addObject:@"T3c"];
    [self.pickerArray addObject:@"T4"];
    
    [self.picker reloadAllComponents];
    
    
    if (self.tSelectLbl.text.length > 0 && ![self.tSelectLbl.text isEqualToString:@"Select"]) {
        for (int i = 0; i < [self.pickerArray count]; i++) {
            NSString *str = [self.pickerArray objectAtIndex:i];
            if ([self.tSelectLbl.text isEqualToString:str]) {
                [self.picker selectRow:i inComponent:0 animated:YES];
                break;
            }
        }
    }else{
        [self.picker selectRow:0 inComponent:0 animated:YES];
    }
}

-(IBAction)expandN:(UIButton *)sender{
    
    self.pickerCheck = @"N";
    [self.picker setHidden:NO];
    [self.t_toolbar setHidden:NO];
    
    
    [self.pickerArray removeAllObjects];
    self.pickerArray = nil;
    self.pickerArray = [[NSMutableArray alloc] initWithCapacity:4];
    
    [self.pickerArray addObject:@"N"];
    [self.pickerArray addObject:@"NX"];
    [self.pickerArray addObject:@"N0"];
    [self.pickerArray addObject:@"N1"];
    
    [self.picker reloadAllComponents];
    
    
    if (self.nSelectLbl.text.length > 0 && ![self.nSelectLbl.text isEqualToString:@"Select"]) {
        for (int i = 0; i < [self.pickerArray count]; i++) {
            NSString *str = [self.pickerArray objectAtIndex:i];
            if ([self.nSelectLbl.text isEqualToString:str]) {
                [self.picker selectRow:i inComponent:0 animated:YES];
                break;
            }
        }
    }else{
        [self.picker selectRow:0 inComponent:0 animated:YES];
    }
    
}

-(IBAction)expandM:(UIButton *)sender{
    
    self.pickerCheck = @"M";
    [self.picker setHidden:NO];
    [self.t_toolbar setHidden:NO];
    
    
    [self.pickerArray removeAllObjects];
    self.pickerArray = nil;
    self.pickerArray = [[NSMutableArray alloc] initWithCapacity:3];
    
    [self.pickerArray addObject:@"M"];
    [self.pickerArray addObject:@"M0"];
    [self.pickerArray addObject:@"M1"];
    
    [self.picker reloadAllComponents];
    
    if (self.mSelectLbl.text.length > 0 && ![self.mSelectLbl.text isEqualToString:@"Select"]) {
        for (int i = 0; i < [self.pickerArray count]; i++) {
            NSString *str = [self.pickerArray objectAtIndex:i];
            if ([self.mSelectLbl.text isEqualToString:str]) {
                [self.picker selectRow:i inComponent:0 animated:YES];
                break;
            }
        }
    }else{
        [self.picker selectRow:0 inComponent:0 animated:YES];
    }
    
}

-(IBAction)expandTumorCharacteristics:(UIButton *)sender{
    
    self.pickerCheck = @"TC";
    [self.picker setHidden:NO];
    [self.t_toolbar setHidden:NO];
    
    [self.pickerArray removeAllObjects];
    self.pickerArray = nil;
    self.pickerArray = [[NSMutableArray alloc] initWithCapacity:7];
    
    [self.pickerArray addObject:@"Clear Cell"];
    [self.pickerArray addObject:@"Papillary"];
    [self.pickerArray addObject:@"Chromophobe"];
    [self.pickerArray addObject:@"Sarcomatoid"];
    [self.pickerArray addObject:@"angiomyolipoma"];
    [self.pickerArray addObject:@"oncocytoma"];
    [self.pickerArray addObject:@"other"];
    
    [self.picker reloadAllComponents];
    
    
    if (self.tcSelectLbl.text.length > 0 && ![self.tcSelectLbl.text isEqualToString:@"Select"]) {
        for (int i = 0; i < [self.pickerArray count]; i++) {
            NSString *str = [self.pickerArray objectAtIndex:i];
            if ([self.tcSelectLbl.text isEqualToString:str]) {
                [self.picker selectRow:i inComponent:0 animated:YES];
                break;
            }
        }
    }else{
        [self.picker selectRow:0 inComponent:0 animated:YES];
    }
}


-(IBAction)expandFuhrmanGrade:(UIButton *)sender{
    
    self.pickerCheck = @"FG";
    [self.picker setHidden:NO];
    [self.t_toolbar setHidden:NO];
    
    [self.pickerArray removeAllObjects];
    self.pickerArray = nil;
    self.pickerArray = [[NSMutableArray alloc] initWithCapacity:4];
    
    [self.pickerArray addObject:@"1/4"];
    [self.pickerArray addObject:@"2/4"];
    [self.pickerArray addObject:@"3/4"];
    [self.pickerArray addObject:@"4/4"];
    
    [self.picker reloadAllComponents];
    
    
    if (self.fgSelectLbl.text.length > 0 && ![self.fgSelectLbl.text isEqualToString:@"Select"]) {
        for (int i = 0; i < [self.pickerArray count]; i++) {
            NSString *str = [self.pickerArray objectAtIndex:i];
            if ([self.fgSelectLbl.text isEqualToString:str]) {
                [self.picker selectRow:i inComponent:0 animated:YES];
                break;
            }
        }
    }else{
        [self.picker selectRow:0 inComponent:0 animated:YES];
    }
}

-(IBAction)expandMargin:(UIButton *)sender{
    
    self.pickerCheck = @"Margin";
    [self.picker setHidden:NO];
    [self.t_toolbar setHidden:NO];
    
    [self.pickerArray removeAllObjects];
    self.pickerArray = nil;
    self.pickerArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    [self.pickerArray addObject:@"Positive"];
    [self.pickerArray addObject:@"Negative"];
    
    [self.picker reloadAllComponents];
    
    if (self.marginSelectLbl.text.length > 0 && ![self.marginSelectLbl.text isEqualToString:@"Select"]) {
        for (int i = 0; i < [self.pickerArray count]; i++) {
            NSString *str = [self.pickerArray objectAtIndex:i];
            if ([self.marginSelectLbl.text isEqualToString:str]) {
                [self.picker selectRow:i inComponent:0 animated:YES];
                break;
            }
        }
    }else{
        [self.picker selectRow:0 inComponent:0 animated:YES];
    }
}

-(IBAction)expandDeepMarging:(UIButton *)sender{
    
    self.pickerCheck = @"DM";
    [self.picker setHidden:NO];
    [self.t_toolbar setHidden:NO];
    
    [self.pickerArray removeAllObjects];
    self.pickerArray = nil;
    self.pickerArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    [self.pickerArray addObject:@"Positive"];
    [self.pickerArray addObject:@"Negative"];
    
    [self.picker reloadAllComponents];
    
    if (self.dmSelectLbl.text.length > 0 && ![self.dmSelectLbl.text isEqualToString:@"Select"]) {
        for (int i = 0; i < [self.pickerArray count]; i++) {
            NSString *str = [self.pickerArray objectAtIndex:i];
            if ([self.dmSelectLbl.text isEqualToString:str]) {
                [self.picker selectRow:i inComponent:0 animated:YES];
                break;
            }
        }
    }else{
        [self.picker selectRow:0 inComponent:0 animated:YES];
    }
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
            //NSLog(@"%@",dict);
            
            if (self.weeksDictionary == nil) {
                self.weeksDictionary = [[NSMutableDictionary alloc] init];
            }
            [self.weeksDictionary removeAllObjects];
            
            [self.weeksDictionary setObject:[dict objectForKey:T_STAGE] forKey:T_STAGE];
            [self.SummaryDictionary setObject:[dict objectForKey:T_STAGE] forKey:tLbl.text];
            
            [self.weeksDictionary setObject:[dict objectForKey:N_STAGE] forKey:N_STAGE];
            [self.SummaryDictionary setObject:[dict objectForKey:N_STAGE] forKey:nLbl.text];
            
            [self.weeksDictionary setObject:[dict objectForKey:M_STAGE] forKey:M_STAGE];
            [self.SummaryDictionary setObject:[dict objectForKey:M_STAGE] forKey:mLbl.text];
            
            [self.weeksDictionary setObject:[dict objectForKey:TUMOR_CHAR_STAGE] forKey:TUMOR_CHAR_STAGE];
            [self.SummaryDictionary setObject:[dict objectForKey:TUMOR_CHAR_STAGE] forKey:tcLbl.text];
            
            [self.weeksDictionary setObject:[dict objectForKey:FUHRMAN_GRAGE_STAGE] forKey:FUHRMAN_GRAGE_STAGE];
            [self.SummaryDictionary setObject:[dict objectForKey:FUHRMAN_GRAGE_STAGE] forKey:fgLbl.text];
            
            [self.weeksDictionary setObject:[dict objectForKey:MARGIN_STAGE] forKey:MARGIN_STAGE];
            [self.SummaryDictionary setObject:[dict objectForKey:MARGIN_STAGE] forKey:marginLbl.text];
            
            [self.weeksDictionary setObject:[dict objectForKey:DEEP_MARGIN_STAGE] forKey:DEEP_MARGIN_STAGE];
            [self.SummaryDictionary setObject:[dict objectForKey:DEEP_MARGIN_STAGE] forKey:dmLbl.text];
            
            //////////////////////////////////////////
            
            
            [self.weeksDictionary setObject:[dict objectForKey:NIGHTS_STAGE] forKey:NIGHTS_STAGE];
            [self.SummaryDictionary setObject:[dict objectForKey:NIGHTS_STAGE] forKey:@"Post-Op Hospital Stay"];
            
            [self.weeksDictionary setObject:[dict objectForKey:COMPLICATIONS_STAGE] forKey:COMPLICATIONS_STAGE];
            [self.SummaryDictionary setObject:[dict objectForKey:COMPLICATIONS_STAGE] forKey:@"Complications"];
            
            [self.weeksDictionary setObject:[dict objectForKey:PREOP_BUN_STAGE] forKey:PREOP_BUN_STAGE];
            [self.SummaryDictionary setObject:[dict objectForKey:PREOP_BUN_STAGE] forKey:@"Pre-operative Bun"];
            
            
            [self.weeksDictionary setObject:[dict objectForKey:PREOP_CRATININE_STAGE] forKey:PREOP_CRATININE_STAGE];
            [self.SummaryDictionary setObject:[dict objectForKey:PREOP_CRATININE_STAGE] forKey:@"Pre-operative Creatinine"];
            
            [self.weeksDictionary setObject:[dict objectForKey:POSTOP_BUN_STAGE] forKey:POSTOP_BUN_STAGE];
            [self.SummaryDictionary setObject:[dict objectForKey:POSTOP_BUN_STAGE] forKey:@"Post-operative Bun"];
            
            [self.weeksDictionary setObject:[dict objectForKey:POSTOP_CREATININE_STAGE] forKey:POSTOP_CREATININE_STAGE];
            [self.SummaryDictionary setObject:[dict objectForKey:POSTOP_CREATININE_STAGE] forKey:@"Post-operative Creatinine"];
            
            
            [self.weeksDictionary setObject:[dict objectForKey:ADD_DIAGNOSIS_STAGE] forKey:ADD_DIAGNOSIS_STAGE];
            [self.SummaryDictionary setObject:[dict objectForKey:ADD_DIAGNOSIS_STAGE] forKey:@"Additional Diagnosis"];
            
            
            UCTimePointSummaryViewController *controller = [[UCTimePointSummaryViewController alloc] initWithNibName:@"UCTimePointSummaryViewController" bundle:nil];
            
            controller.caseData = [self.weeksDictionary mutableCopy];
            
            controller.caseID = [self.caseData objectForKey:@"DetailID"];
            controller.timePointID = [self.timePoint objectForKey:@"id"];
            
            controller.timePoint = @"Two";
            
            controller.summaryDictionary = [self.SummaryDictionary mutableCopy];
            
            isSummary = YES;
            
            [self.navigationController pushViewController:controller animated:YES];
            
        }
        
    }
}




@end
