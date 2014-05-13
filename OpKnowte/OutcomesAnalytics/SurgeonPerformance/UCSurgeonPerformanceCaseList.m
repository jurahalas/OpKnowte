//
//  UCSurgeonPerformanceCaseList.m
//  MZUroCapture
//
//  Created by Atif Joyia on 19/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSelectTimePointViewController.h"
#import "UCSurgeonPerformanceCaseList.h"
#import "UCSurgeonsLogPDFCaseList.h"
#import "UCSurgeonPostOpData.h"
#import "UCProcedureDetailSummaryPage.h"
#import "UCSelectProcedureViewController.h"
#import "UCNationalPerformanceCaseList.h"

#import "OKProceduresManager.h"
#import "OKWebServerManager.h"
#import "OKClinicalManager.h"

@interface UCSurgeonPerformanceCaseList ()

@end

@implementation UCSurgeonPerformanceCaseList

@synthesize procedureLbl, fromCaseNumLbl, fromDateLbl, toCaseNumLbl, toDateLbl;
@synthesize procedureName, fromCase, fromDate, toCase, toDate, selectedCases;
@synthesize parent, doneBtn;
@synthesize datePicker,fromCaseTF,toCaseTF,fromDateBtn,toDateBtn,labelName,procedureID;
@synthesize sortedArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.cases = [[NSMutableArray alloc] init];
        self.selectedCases = [[NSMutableArray alloc] init];
        self.sortedArray = [[NSMutableArray alloc] init];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (IS_IPHONE_5) {
        l_Header.frame=CGRectMake(l_Header.frame.origin.x, l_Header.frame.origin.y+5, l_Header.frame.size.width, l_Header.frame.size.height);
    }
    [l_Header setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    
    
    if ([self.parent isEqualToString:@"SurgeonLog"]) {
        [l_Header setText:@"SURGEONS LOG"];
        [self.doneBtn setTitle:@"GENERATE NOTE" forState:UIControlStateNormal];
    }
    
    [self.procedureLbl setTextColor:[UIColor orangeColor]];
    [self.fromDateLbl setTextColor:[UIColor orangeColor]];
    [self.toDateLbl setTextColor:[UIColor orangeColor]];
    [self.fromCaseTF setTextColor:[UIColor orangeColor]];
    [self.toCaseTF setTextColor:[UIColor orangeColor]];
    
    [self.procedureLbl setText:self.procedureName];
    [self.fromDateLbl setText:self.fromDate];
    [self.toDateLbl setText:self.toDate];
    [self.fromCaseTF setText:self.fromCase];
    [self.toCaseTF setText:self.toCase];
    
    self.labelName = @"";
    dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"MM-dd-yyyy"];
    [self.datePicker setMaximumDate:[NSDate date]];
//    self.procedureID = @"2";
//    self.procedureName = @"Laparoscopic Robotic Partial Nephrectomy";
   // self.procedureLbl.text = self.procedureName;
    
}

-(void)viewWillAppear:(BOOL)animated{
    if ([self.parent isEqualToString:@"SurgeonPerformance"] || [self.parent isEqualToString:@"SurgeonPostOpData"]) {
        
        
        if ([OKProceduresManager instance].selectedProcedure != nil) {
            [UCUtility showBlockView];
            [OKWebServerManager getSurgeonDates:^(NSString *errorMsg, id responseJSON) {
                [UCUtility hideBlockView];
                if(!errorMsg)
                   [self datesSucceded:responseJSON];
                else
                    [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
            }];
        }
        
    }else if ([self.parent isEqualToString:@"NationalDataComparison"]){
        
        [l_Header setText:@"NATIONAL DATA COMPARISON"];
        //[self.caseNumLbl setHidden:YES];
        [self.fromCaseTF setHidden:YES];
        [self.toCaseTF setHidden:YES];
        
        [UCUtility showBlockView];
        [OKWebServerManager getNationalDates:^(NSString *errorMsg, id responseJSON) {
            [UCUtility hideBlockView];
            if(!errorMsg)
                [self datesSucceded:responseJSON];
            else
                [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
        }];
        
    }else if ([self.parent isEqualToString:@"SurgeonLog"]){
        
        [l_Header setText:@"SURGEONS LOG"];
        
        if ([OKProceduresManager instance].selectedProcedure != nil) {
            [OKWebServerManager getSurgeonDates:^(NSString *errorMsg, id responseJSON) {
                [UCUtility hideBlockView];
                if(!errorMsg)
                    [self datesSucceded:responseJSON];
                else
                    [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
            }];
        }
    }
}

- (void)datesSucceded:(id)response
{
    id result = [UCUtility getEmailsArray:response];
    
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


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cases count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"UCSelectProcedureCell";
    cellIdentifier = [cellIdentifier stringByAppendingFormat:@"%i",indexPath.row];
     //NSLog(@"%@",cellIdentifier);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    UIImageView *checkImageView;
    UIButton *checkButton;
    UILabel *nameLbl, *emailLbl;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        checkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 14, 15)];
        [cell.contentView addSubview:checkImageView];
        
        checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [checkButton setFrame:CGRectMake(5, 7, 30, 30)];
        [checkButton setBackgroundColor:[UIColor clearColor]];
        [cell.contentView addSubview:checkButton];
        
        nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 2, 250, 20)];
        [nameLbl setBackgroundColor:[UIColor clearColor]];
        [nameLbl setTextColor:[UIColor darkGrayColor]];
        [cell.contentView addSubview:nameLbl];
        
        emailLbl = [[UILabel alloc] initWithFrame:CGRectMake(42, 22, 248, 20)];
        [emailLbl setBackgroundColor:[UIColor clearColor]];
        [emailLbl setTextColor:[UIColor colorWithRed:227.0/255.0 green:92.0/255.0 blue:23.0/255.0 alpha:1.0]];
        [cell.contentView addSubview:emailLbl];
        
    }
    else {
        checkImageView = [cell.contentView.subviews objectAtIndex:0];
        checkButton = [cell.contentView.subviews objectAtIndex:1];
        nameLbl = [cell.contentView.subviews objectAtIndex:2];
        emailLbl = [cell.contentView.subviews objectAtIndex:3];
    }
    
    NSString *temp = [[self.cases objectAtIndex:indexPath.row] objectForKey:@"DetailID"];
    
    BOOL found = NO;
    for (int i = 0; i < self.selectedCases.count; i++) {
        NSDictionary *model = [self.selectedCases objectAtIndex:i];
        NSLog(@"%@",[model objectForKey:@"DetailID"]);
        if ([temp isEqualToString:[model objectForKey:@"DetailID"]]) {
            found = YES;
            break;
        }
    }
    
    if (found == YES) {
        [checkImageView setImage:[UIImage imageNamed:@"proceduresCheck.png"]];
        [checkImageView setAccessibilityIdentifier:@"proceduresCheck.png"];
    } else{
        [checkImageView setImage:[UIImage imageNamed:@"proceduresUnCheck.png"]];
        [checkImageView setAccessibilityIdentifier:@"proceduresUnCheck.png"];
    }
    
    [checkButton setTag:indexPath.row];
    [checkButton addTarget:self action:@selector(checkButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    [nameLbl setText:[[self.cases objectAtIndex:indexPath.row] objectForKey:@"Patient_Name"]];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSDate *d1 = [formater dateFromString:[[self.cases objectAtIndex:indexPath.row] objectForKey:@"DateOfService"]];
    [formater setDateFormat:@"MM-dd-yyyy"];
    NSString *str = [formater stringFromDate:d1];
    
    [emailLbl setText:str];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UCProcedureDetailSummaryPage *controller = [[UCProcedureDetailSummaryPage alloc] initWithNibName:@"UCProcedureDetailSummaryPage" bundle:nil];
    controller.caseData = [self.cases objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
    
}


-(IBAction)allChecked:(id)sender{
    [self.selectedCases removeAllObjects];
    self.selectedCases = [self.cases mutableCopy];
    [self.casesTable reloadData];
}

-(IBAction)noChecked:(id)sender{
    [self.selectedCases removeAllObjects];
    [self.casesTable reloadData];
}



-(IBAction)compare:(id)sender{
    
    //NSLog(@"%i",[self.selectedCases count]);
    
    if ([self.selectedCases count] == 0) {
        [UCUtility showInfoAlertView:@"" withMessage:@"Please select atleast one case."];
    }else{
        NSString *list = [[NSString alloc] init];
        
        for (int i = 0; i < [self.selectedCases count]; i++) {
            list = [list stringByAppendingString:[[self.selectedCases objectAtIndex:i] objectForKey:@"DetailID"]];
            if (i != self.selectedCases.count - 1) {
                list = [list stringByAppendingString:@","];
            }
        }
        
        if ([self.parent isEqualToString:@"SurgeonLog"]) {
            
            UCSurgeonsLogPDFCaseList *controller = [[UCSurgeonsLogPDFCaseList alloc] initWithNibName:@"UCSurgeonsLogPDFCaseList" bundle:nil];
            
            controller.selectedCases = [self.selectedCases mutableCopy];
            controller.procedureName = self.procedureLbl.text;
            controller.fromDate = self.fromDate;
            controller.fromCase = self.fromCase;
            controller.toDate = self.toDate;
            controller.toCase = self.toCase;
            [self.navigationController pushViewController:controller animated:YES];
            
        }else if([self.parent isEqualToString:@"SurgeonPostOpData"]){
        
            UCSurgeonPostOpData *controller = [[UCSurgeonPostOpData alloc] initWithNibName:@"UCSurgeonPostOpData" bundle:nil];
            NSLog(@"%i",self.selectedCases.count);
            controller.totalSurgeonCount = [self.selectedCases count];
            controller.selectedCases = [self.selectedCases mutableCopy];
            [self.navigationController pushViewController:controller animated:YES];
            
        }else{
            [UCUtility showBlockView];
            [OKClinicalManager getClinicalDetails:list handler:^(NSString *errorMsg, id responseJSON) {
                [UCUtility hideBlockView];
                if(!errorMsg)
                   [self clinicalDetailsSucceded:responseJSON];
                else
                    [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
            }];
        }
    }
}


- (void)clinicalDetailsSucceded:(id)response
{
    id result = response;
    
    if ([[result objectForKey:@"status"] isEqualToString:@"true"]) {
        
        UCSelectTimePointViewController *controller = [[UCSelectTimePointViewController alloc] initWithNibName:@"UCSelectTimePointViewController" bundle:nil];
        controller.isFilter = YES;
        controller.performanceCases = [[result objectForKey:@"clinicalData"] mutableCopy];
        controller.totalCount = self.selectedCases.count;
        [self.navigationController pushViewController:controller animated:YES];
        
    }
    else {
        [UCUtility showInfoAlertView:@"Error" withMessage:[result objectForKey:@"msg"]];
    }
}


-(IBAction)checkButtonPressed:(UIButton *)sender{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    UITableViewCell *cell = [self.casesTable cellForRowAtIndexPath:indexPath];
    
    for (UIView *view in cell.contentView.subviews) {
        
        NSString *viewClass = [NSString stringWithFormat:@"%@",view.class];
        if ([viewClass isEqualToString:@"UIImageView"]) {
            UIImageView *imageView = (UIImageView *)view;
            if ([imageView.accessibilityIdentifier isEqualToString:@"proceduresUnCheck.png"]) {
                
                [imageView setImage:[UIImage imageNamed:@"proceduresCheck.png"]];
                [imageView setAccessibilityIdentifier:@"proceduresCheck.png"];
                [self.selectedCases addObject:[self.cases objectAtIndex:indexPath.row]];
                
            }else{
                
                [imageView setImage:[UIImage imageNamed:@"proceduresUnCheck.png"]];
                [imageView setAccessibilityIdentifier:@"proceduresUnCheck.png"];
                
                NSString *temp = [[self.cases objectAtIndex:indexPath.row] objectForKey:@"DetailID"];
                
                for (int i = 0; i < self.selectedCases.count; i++) {
                    NSDictionary *model = [self.selectedCases objectAtIndex:i];
                    
                    if ([temp isEqualToString:[model objectForKey:@"DetailID"]]) {
                        [self.selectedCases removeObjectAtIndex:i];
                        break;
                    }
                }
            }
            
            break;
        }
        
    }
}


-(IBAction)selectProcedure:(id)sender{
    UCSelectProcedureViewController *controller = [[UCSelectProcedureViewController alloc] initWithNibName:@"UCSelectProcedureViewController" bundle:nil];
    controller.surgeonFilter = self;
    controller.isSurgeonFilter = YES;
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
        //[self animateTextField:self.fromCaseTF up:NO];
        
        [self.fromDateBtn setEnabled:YES];
        [self.toDateBtn setEnabled:YES];
        [self.toCaseTF setEnabled:YES];
        
        if (self.fromCaseTF.text.length > 0) {
            self.fromCase = self.fromCaseTF.text;
        }
        
    }else if ([self.toCaseTF isFirstResponder]){
        t_toolbar.hidden = YES;
        [self.toCaseTF resignFirstResponder];
        //[self animateTextField:self.toCaseTF up:NO];
        
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


-(IBAction)search:(id)sender{
    //SurgeonLog
    self.fromDate = self.fromDateLbl.text;
    self.toDate = self.toDateLbl.text;
    self.fromCase = self.fromCaseTF.text;
    self.toCase = self.toCaseTF.text;
    
    if ([self.parent isEqualToString:@"SurgeonPerformance"] || [self.parent isEqualToString:@"SurgeonLog"] || [self.parent isEqualToString:@"SurgeonPostOpData"]) {
        
        if (self.procedureLbl.text.length == 0 || [self.procedureLbl.text isEqualToString:@"Select"] || self.fromDateLbl.text.length == 0 || [self.fromDateLbl.text isEqualToString:@"Select"] || self.toDateLbl.text.length == 0 || [self.toDateLbl.text isEqualToString:@"Select"]) {
            
            [UCUtility showInfoAlertView:@"" withMessage:@"Please select all required fields"];
        }else{
            
            if (self.fromCase.length == 0 || self.toCase.length == 0) {
                self.fromCase = @"";
                self.toCase = @"";
            }
            
            if ([self varifyDates]) {
                
                [UCUtility showBlockView];
                [OKWebServerManager getSurgeonPerformanceData:self.procedureID fromTime:self.fromDate toTime:self.toDate fromRecordNum:self.fromCase toRecordNum:self.toCase handler:^(NSString *errorMsg, id responseJSON) {
                    [UCUtility hideBlockView];
                    if(!errorMsg)
                       [self surgeonPerformanceSucceded:responseJSON];
                    else
                        [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
                }];
                
            }else{
                
                [UCUtility showInfoAlertView:@"" withMessage:@"From time cannot be in future of To time"];
            }
        }
        
    }else if ([self.parent isEqualToString:@"NationalDataComparison"]){
        
        if (self.procedureLbl.text.length == 0 || [self.procedureLbl.text isEqualToString:@"Select"] || self.fromDateLbl.text.length == 0 || [self.fromDateLbl.text isEqualToString:@"Select"] || self.toDateLbl.text.length == 0 || [self.toDateLbl.text isEqualToString:@"Select"]) {
            
            [UCUtility showInfoAlertView:@"" withMessage:@"Please select all required fields"];
        }else{
            
            if ([self varifyDates]) {
                
                [UCUtility showBlockView];
                [OKWebServerManager getNationalPerformancData:self.procedureID fromTime:self.fromDate toTime:self.toDate handler:^(NSString *errorMsg, id responseJSON) {
                    [UCUtility hideBlockView];
                    if(!errorMsg)
                        [self surgeonPerformanceSucceded:responseJSON];
                    else
                        [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
                }];
                
            }else{
                
                [UCUtility showInfoAlertView:@"" withMessage:@"From time cannot be in future of To time"];
            }
            
        }
        
    }
    
}


-(BOOL)varifyDates{
    NSDate *d1;
    NSDate *d2;
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"MM-dd-yyyy"];
    d1 = [dateFormat1 dateFromString:self.fromDate];
    d2 = [dateFormat1 dateFromString:self.toDate];
    
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


-(void)sortCasesAccordingToDate:(NSArray *)data{
    NSArray *newArray = [data sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *c1, NSDictionary *c2)
                         {
                             NSString *date1 = [c1 objectForKey:@"DateOfService"];
                             NSString *date2 = [c2 objectForKey:@"DateOfService"];
                             NSDate *d1;
                             NSDate *d2;
                             NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
                             [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
                             d1 = [dateFormat1 dateFromString:date1];
                             d2 = [dateFormat1 dateFromString:date2];
                             return [d2 compare:d1];
                         } ];
    
    self.sortedArray = [newArray mutableCopy];
}


- (void)surgeonPerformanceSucceded:(id)response
{
    id result = response;
    if (result && [[result objectForKey:@"status"] isEqualToString:@"true"] > 0) {
        
        
        if ([self.parent isEqualToString:@"SurgeonPerformance"] || [self.parent isEqualToString:@"SurgeonLog"] || [self.parent isEqualToString:@"SurgeonPostOpData"]) {
            
            NSArray *data = [result objectForKey:@"contacts"];
            
            if ([data count] == 0) {
                
                [UCUtility showInfoAlertView:@"" withMessage:@"No data found"];
                
            }else{
                [self sortCasesAccordingToDate:data];
                
                self.cases = [self getFilterArray:self.sortedArray];
                [self.casesTable reloadData];
            }
            
            
//            UCSurgeonPerformanceCaseList *controller = [[UCSurgeonPerformanceCaseList alloc] initWithNibName:@"UCSurgeonPerformanceCaseList" bundle:nil];
//            
//            controller.cases = [self getFilterArray:data];
//            // NSLog(@"%i",[controller.cases count]);
//            
//            controller.procedureName = self.procedureLbl.text;
//            controller.fromDate = self.fromDate;
//            controller.fromCase = self.fromCase;
//            controller.toDate = self.toDate;
//            controller.toCase = self.toCase;
//            controller.parent =self.parent;
//            
//            [self.navigationController pushViewController:controller animated:YES];
            
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
    
    response = nil;
    
}


-(NSMutableArray *)getFilterArray:(NSArray *)data{
    NSMutableArray *filtered = [[NSMutableArray alloc] init];
    
    // NSLog(@"%i",[data count]);
    // NSLog(@"%i",[self.fromCase intValue]);
    // NSLog(@"%i",[self.toCase intValue]);
    
    if ([self.fromCase isEqualToString:@""] || [self.fromCase isEqualToString:@""]) {
        for (int i = 0; i <[data count]; i++) {
            [filtered addObject:[data objectAtIndex:i]];
        }
        return filtered;
    }
    
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
                for (int i = from; i<total; i++) {
                    [filtered addObject:[data objectAtIndex:i]];
                }
            }else{
                for (int i = from; i<to; i++) {
                    [filtered addObject:[data objectAtIndex:i]];
                }
            }
        }
        
    }else{
        if (from >= total) {
            
        }else{
            if (to >= total) {
                
                for (int i = from; i<total; i++) {
                    [filtered addObject:[data objectAtIndex:i]];
                }
                
            }else{
                
                for (int i = from; i<to; i++) {
                    [filtered addObject:[data objectAtIndex:i]];
                }
            }
        }
    }
    
    //NSLog(@"%i",[filtered count]);
    
    return filtered;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    t_toolbar.hidden = NO;
   // [self animateTextField:textField up:YES];
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
    [textField resignFirstResponder];
    return YES;
}


@end
