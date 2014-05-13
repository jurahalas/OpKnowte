//
//  UCSurgeonPerformanceFilter.m
//  MZUroCapture
//
//  Created by Atif Joyia on 18/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSurgeonPerformanceFilter.h"
#import "UCSurgeonPerformanceCaseList.h"
#import "UCSelectProcedureViewController.h"
#import "UCNationalPerformanceCaseList.h"

#import "OKWebServerManager.h"


@interface UCSurgeonPerformanceFilter ()

@end

@implementation UCSurgeonPerformanceFilter

@synthesize scroller, procedureID, fromCase, fromDate, toCase, toDate, fromDateBtn, toDateBtn;
@synthesize procedureLbl, toCaseTF, toDateLbl, fromCaseTF, fromDateLbl, labelName, caseNumLbl, parent;


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

-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)search:(id)sender{
    //SurgeonLog
    if ([self.parent isEqualToString:@"SurgeonPerformance"] || [self.parent isEqualToString:@"SurgeonLog"] || [self.parent isEqualToString:@"SurgeonPostOpData"]) {
        
        if (self.procedureLbl.text.length == 0 || [self.procedureLbl.text isEqualToString:@"Select"] || self.fromDateLbl.text.length == 0 || [self.fromDateLbl.text isEqualToString:@"Select"] || self.toDateLbl.text.length == 0 || [self.toDateLbl.text isEqualToString:@"Select"] || self.fromCaseTF.text.length == 0 || self.toDateLbl.text.length == 0) {
            
            [UCUtility showInfoAlertView:@"" withMessage:@"Please select all required fields"];
        }else{
            
            if ([self.fromCase intValue] > 0 && [self.toCase intValue] > 0) {
                if ([self.fromCase intValue] < [self.toCase intValue]) {
                    [UCUtility showBlockView];
                    [OKWebServerManager  getSurgeonPerformanceData:self.procedureID fromTime:self.fromDate toTime:self.toDate fromRecordNum:self.fromCase toRecordNum:self.toCase handler:^(NSString *errorMsg, id responseJSON) {
                        [UCUtility hideBlockView];
                        if(!errorMsg)
                            [self surgeonPerformanceSucceded:responseJSON];
                        else
                            [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
                    }];
                }else{
                    [UCUtility showInfoAlertView:@"" withMessage:@"To case must be greater than from case"];
                }
            }else{
                [UCUtility showInfoAlertView:@"" withMessage:@"Case numbers must be greater than 0."];
            }
        }
        
    }else if ([self.parent isEqualToString:@"NationalDataComparison"]){
        
        if (self.procedureLbl.text.length == 0 || [self.procedureLbl.text isEqualToString:@"Select"] || self.fromDateLbl.text.length == 0 || [self.fromDateLbl.text isEqualToString:@"Select"] || self.toDateLbl.text.length == 0 || [self.toDateLbl.text isEqualToString:@"Select"]) {
            
            [UCUtility showInfoAlertView:@"" withMessage:@"Please select all required fields"];
        }else{
            
            [UCUtility showBlockView];
            [OKWebServerManager getNationalPerformancData:self.procedureID fromTime:self.fromDate toTime:self.toDate handler:^(NSString *errorMsg, id responseJSON) {
                [UCUtility hideBlockView];
                if(!errorMsg)
                    [self surgeonPerformanceSucceded:responseJSON];
                else
                    [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
            }];
        }
        
    }
    
}


- (void)surgeonPerformanceSucceded:(id)response
{
    id result = response;
    if (result && [[result objectForKey:@"status"] isEqualToString:@"true"] > 0) {
        
        if ([self.parent isEqualToString:@"SurgeonPerformance"] || [self.parent isEqualToString:@"SurgeonLog"] || [self.parent isEqualToString:@"SurgeonPostOpData"]) {
            
            NSArray *data = [result objectForKey:@"contacts"];
            
            UCSurgeonPerformanceCaseList *controller = [[UCSurgeonPerformanceCaseList alloc] initWithNibName:@"UCSurgeonPerformanceCaseList" bundle:nil];
            
            controller.cases = [self getFilterArray:data];
           // NSLog(@"%i",[controller.cases count]);
            
            controller.procedureName = self.procedureLbl.text;
            controller.fromDate = self.fromDate;
            controller.fromCase = self.fromCase;
            controller.toDate = self.toDate;
            controller.toCase = self.toCase;
            controller.parent =self.parent;
            
            [self.navigationController pushViewController:controller animated:YES];
            
        }else if ([self.parent isEqualToString:@"NationalDataComparison"]){
            
            //NSArray *data = [result objectForKey:@"sharedCases"];
            
            UCNationalPerformanceCaseList *controller = [[UCNationalPerformanceCaseList alloc] initWithNibName:@"UCNationalPerformanceCaseList" bundle:nil];
            //controller.cases = [data mutableCopy];
            controller.procedureName = self.procedureLbl.text;
            controller.fromDate = self.fromDate;
            controller.toDate = self.toDate;
            [self.navigationController pushViewController:controller animated:YES];
            
        }
        
    }else{
    }
}


-(NSMutableArray *)getFilterArray:(NSArray *)data{
    NSMutableArray *filtered = [[NSMutableArray alloc] init];
    
   // NSLog(@"%i",[data count]);
   // NSLog(@"%i",[self.fromCase intValue]);
   // NSLog(@"%i",[self.toCase intValue]);
    
    int total = [data count];
    int to = [self.toCase intValue];
    int from = [self.fromCase intValue];
    if (from>0) {
        from = from-1;
    }
    int filter = to - from;
    
    if (filter >= total) {
        
        if (from >= total) {
            
        }else{
            if (to >= total) {
                for (int i = total-1; i>=from; i--) {
                    [filtered addObject:[data objectAtIndex:i]];
                }
            }else{
                for (int i = to-1; i>=from; i--) {
                    [filtered addObject:[data objectAtIndex:i]];
                }
            }
        }
        
    }else{
        if (from >= total) {
            
        }else{
            if (to >= total) {
                
                for (int i = total-1; i>=from; i--) {
                    [filtered addObject:[data objectAtIndex:i]];
                }
                
            }else{
                
                for (int i = to-1; i>=from; i--) {
                    [filtered addObject:[data objectAtIndex:i]];
                }
            }
        }
    }
    
    //NSLog(@"%i",[filtered count]);
    
    return filtered;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (IS_IPHONE_5) {
        l_Header.frame=CGRectMake(l_Header.frame.origin.x, l_Header.frame.origin.y+5, l_Header.frame.size.width, l_Header.frame.size.height);
    }
    [l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    
    self.labelName = @"";
    dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"MM-dd-yyyy"];
    [self.datePicker setMaximumDate:[NSDate date]];
    
}

-(void)viewWillAppear:(BOOL)animated{
    if ([self.parent isEqualToString:@"SurgeonPerformance"] || [self.parent isEqualToString:@"SurgeonPostOpData"]) {
        
        //[UCUtility showBlockView];
        [OKWebServerManager getSurgeonDates:^(NSString *errorMsg, id responseJSON) {
            [UCUtility hideBlockView];
            if(!errorMsg)
               [self datesSucceded:responseJSON];
            else
                [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
        }];
        
    }else if ([self.parent isEqualToString:@"NationalDataComparison"]){
        
        [l_Header setText:@"NATIONAL DATA COMPARISON"];
        [self.caseNumLbl setHidden:YES];
        [self.fromCaseTF setHidden:YES];
        [self.toCaseTF setHidden:YES];
        
        //[UCUtility showBlockView];
        [OKWebServerManager getNationalDates:^(NSString *errorMsg, id responseJSON) {
            [UCUtility hideBlockView];
            if(!errorMsg)
                [self datesSucceded:responseJSON];
            else
                [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
        }];
        
    }else if ([self.parent isEqualToString:@"SurgeonLog"]){
        
        [l_Header setText:@"SURGEONS LOG"];
        
        //[UCUtility showBlockView];
        [OKWebServerManager getSurgeonDates:^(NSString *errorMsg, id responseJSON) {
            [UCUtility hideBlockView];
            if(!errorMsg)
                [self datesSucceded:responseJSON];
            else
                [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
        }];
    }
}


- (void)datesSucceded:(id)response
{
    id result = [UCUtility getEmailsArray:response];
    
    NSLog(@"%@",result);
    
    if ((result) && ([result count] > 0)) {
        
        int count = [result count];
        [self.fromDateLbl setText:[result objectAtIndex:0]];
        [self.toDateLbl setText:[result objectAtIndex:count-1]];
        
        self.fromDate = [NSString stringWithFormat:@"%@",[result objectAtIndex:0]];
        self.toDate = [NSString stringWithFormat:@"%@",[result objectAtIndex:count-1]];
        
    }
    else {
        
    }
    
    result = nil;
    response = nil;
}


-(IBAction)selectProcedure:(id)sender{
    UCSelectProcedureViewController *controller = [[UCSelectProcedureViewController alloc] initWithNibName:@"UCSelectProcedureViewController" bundle:nil];
    controller.filter = self;
    controller.isFilter = YES;
    [self.navigationController pushViewController:controller animated:YES];
}


- (IBAction)dateExpand:(UIButton *)sender {
    
    [self.fromCaseTF setEnabled:NO];
    [self.toCaseTF setEnabled:NO];
    
    if (sender.tag == 1) {
        self.labelName = @"From Date";
        
        if ((self.fromDateLbl.text.length > 0) && (![self.fromDateLbl.text isEqualToString:@"Select"])) {
            
            [self.datePicker setDate:[dateformater dateFromString:self.fromDateLbl.text]];
        }
        else {
            NSString *str = @"01-01-1950";
            [self.datePicker setDate:[dateformater dateFromString:str]];
        }
        
    }else if (sender.tag == 2){
        self.labelName = @"To Date";
        
        if ((self.toDateLbl.text.length > 0) && (![self.toDateLbl.text isEqualToString:@"Select"])) {
            
            [self.datePicker setDate:[dateformater dateFromString:self.toDateLbl.text]];
        }
        else {
            [self.datePicker setDate:[NSDate date]];
        }
    }
    
    
    
    
    self.datePicker.hidden = FALSE;
    t_toolbar.hidden = FALSE;
}


- (IBAction)datePickerDone:(id)sender {
    
    if ([self.fromCaseTF isFirstResponder]) {
        t_toolbar.hidden = YES;
        [self.fromCaseTF resignFirstResponder];
        [self animateTextField:self.fromCaseTF up:NO];
        
        [self.fromDateBtn setEnabled:YES];
        [self.toDateBtn setEnabled:YES];
        [self.toCaseTF setEnabled:YES];
        
        if (self.fromCaseTF.text.length > 0) {
            self.fromCase = self.fromCaseTF.text;
        }
        
    }else if ([self.toCaseTF isFirstResponder]){
        t_toolbar.hidden = YES;
        [self.toCaseTF resignFirstResponder];
        [self animateTextField:self.toCaseTF up:NO];
        
        [self.fromDateBtn setEnabled:YES];
        [self.toDateBtn setEnabled:YES];
        [self.fromCaseTF setEnabled:YES];
        
        if (self.toCaseTF.text.length > 0) {
            self.toCase = self.toCaseTF.text;
        }
        
    }else{
        
        [self.fromCaseTF setEnabled:YES];
        [self.toCaseTF setEnabled:YES];
        
        NSString *date = [dateformater stringFromDate:self.datePicker.date];
        
        if(![self isDateValid]) {
            [UCUtility showInfoAlertView:@"Error" withMessage:@"You cant select a date from future"];
        } else {
            
            if ([self.labelName isEqualToString:@"From Date"]) {
                [self.fromDateLbl setText:date];
                self.fromDate = [NSString stringWithFormat:@"%@",date];
            }else if ([self.labelName isEqualToString:@"To Date"]){
                [self.toDateLbl setText:date];
                self.toDate = [NSString stringWithFormat:@"%@",date];
            }
            
            self.datePicker.hidden = YES;
            t_toolbar.hidden = YES;
        }
        
    }
    
   
}

- (BOOL)isDateValid {
    NSDate *today = [NSDate date];
    NSDate *yesterday = [today dateByAddingTimeInterval: 86400.0];
    
    NSComparisonResult result = [[self.datePicker date] compare:yesterday];
    
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

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    t_toolbar.hidden = NO;
    [self animateTextField:textField up:YES];
    [self.fromDateBtn setEnabled:NO];
    [self.toDateBtn setEnabled:NO];
    
    if (textField == fromCaseTF) {
        [self.toCaseTF setEnabled:NO];
    }else if (textField == toCaseTF){
         [self.fromCaseTF setEnabled:NO];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    t_toolbar.hidden = YES;
    
    [self.fromDateBtn setEnabled:YES];
    [self.toDateBtn setEnabled:YES];
    
    if (textField == fromCaseTF) {
        [self.toCaseTF setEnabled:YES];
    }else if (textField == toCaseTF){
        [self.fromCaseTF setEnabled:YES];
    }
    
    return YES;
}


- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    if (IS_IPHONE_5) {
        
        if (textField == self.fromCaseTF) {
            
            const int movementDistance = 25; // tweak as needed
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
            
        }else if (textField == self.toCaseTF){
            
            const int movementDistance = 75; // tweak as needed
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
        
        if (textField == self.fromCaseTF) {
            
            const int movementDistance = 105; // tweak as needed
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
            
        }else if (textField == self.toCaseTF){
            
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





@end
