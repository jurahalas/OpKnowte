//
//  UCNationalPerformanceCaseList.m
//  MZUroCapture
//
//  Created by Atif Joyia on 24/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCNationalPerformanceCaseList.h"
#import "UCSelectTimePointViewController.h"
#import "UCSelectProcedureViewController.h"
@interface UCNationalPerformanceCaseList ()

@end

@implementation UCNationalPerformanceCaseList

@synthesize procedureLbl, fromDateLbl, toDateLbl;
@synthesize procedureName, fromCase, fromDate, toCase, toDate, selectedCases;
@synthesize procedureID,fromDateBtn,toDateBtn,datePicker,labelName;
@synthesize surgeonFromDate,surgeonToDate,isNational,surgeonClicicalDatas, surgeonCasesDatas,nationalCaseDatas, nationalClinicalDatas;
@synthesize sortedArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.cases = [[NSMutableArray alloc] init];
        self.selectedCases = [[NSMutableArray alloc] init];
        self.sortedArray = [[NSMutableArray alloc] init];
        self.surgeonCasesDatas = [[NSMutableArray alloc] init];
        self.nationalCaseDatas = [[NSMutableArray alloc] init];
        self.surgeonClicicalDatas = [[NSMutableArray alloc] init];
        self.nationalClinicalDatas = [[NSMutableArray alloc] init];
        
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
    
    [self.procedureLbl setTextColor:[UIColor orangeColor]];
    [self.fromDateLbl setTextColor:[UIColor orangeColor]];
    [self.toDateLbl setTextColor:[UIColor orangeColor]];
    
    [self.procedureLbl setText:self.procedureName];
    [self.fromDateLbl setText:self.fromDate];
    [self.toDateLbl setText:self.toDate];
    
    self.labelName = @"";
    dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"MM-dd-yyyy"];
    [self.datePicker setMaximumDate:[NSDate date]];
    self.isNational = YES;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    if ([UCAppDelegate sharedObject].selectedProcedure != nil) {
        [UCUtility showBlockView];
        [UCWebServerHandler getNationalDates:self];
    }
    
}

- (void)DatesSuccessHandler:(ASIHTTPRequest *)request {
    [UCUtility hideBlockView];
    NSString *response = [request responseString];
    NSLog(@"%@",response);
    id result = [UCUtility getEmailsArray:response];
    NSLog(@"%@",result);
    
    if ((result) && ([result count] > 0)) {
        
        int count = [result count];
        if(isNational){
            isNational = NO;
            [self.fromDateLbl setText:[result objectAtIndex:0]];
            [self.toDateLbl setText:[result objectAtIndex:count-1]];
            
            self.fromDate = [NSString stringWithFormat:@"%@",[result objectAtIndex:0]];
            self.toDate = [NSString stringWithFormat:@"%@",[result objectAtIndex:count-1]];
            
        }else{
            self.surgeonFromDate = [NSString stringWithFormat:@"%@",[result objectAtIndex:0]];
            self.surgeonToDate = [NSString stringWithFormat:@"%@",[result objectAtIndex:count-1]];
        }
        
        
    }
    else {
        
    }
    
    result = nil;
    response = nil;
}

- (void)DatesErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.surgeonCasesDatas count];
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
        [checkButton setFrame:CGRectMake(0, 0, 320, 44)];
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
    
    NSString *temp = [[self.surgeonCasesDatas objectAtIndex:indexPath.row] objectForKey:@"DetailID"];
    
    BOOL found = NO;
    for (int i = 0; i < self.selectedCases.count; i++) {
        NSDictionary *model = [self.selectedCases objectAtIndex:i];
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
    
    [nameLbl setText:[[self.surgeonCasesDatas objectAtIndex:indexPath.row] objectForKey:@"Patient_Name"]];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSDate *d1 = [formater dateFromString:[[self.surgeonCasesDatas objectAtIndex:indexPath.row] objectForKey:@"DateOfService"]];
    [formater setDateFormat:@"MM-dd-yyyy"];
    NSString *str = [formater stringFromDate:d1];
    NSLog(@"%@",str);
    
    [emailLbl setText:str];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



-(IBAction)selectNone:(id)sender{
    [self.selectedCases removeAllObjects];
    [self.casesTable reloadData];
}

-(IBAction)selectAll:(id)sender{
    [self.selectedCases removeAllObjects];
    self.selectedCases = [self.surgeonCasesDatas mutableCopy];
    [self.casesTable reloadData];
}

-(IBAction)compare:(id)sender{
    
    if ([self.nationalCaseDatas count] == 0) {
        [UCUtility showInfoAlertView:@"" withMessage:@"Please select atleast one case."];
    }else{
        NSString *list = [[NSString alloc] init];
        
        for (int i = 0; i < [self.nationalCaseDatas count]; i++) {
            list = [list stringByAppendingString:[[self.nationalCaseDatas objectAtIndex:i] objectForKey:@"DetailID"]];
            if (i != self.nationalCaseDatas.count - 1) {
                list = [list stringByAppendingString:@","];
            }
        }
        
        NSLog(@"%@",list);
        isNational = YES;
        [UCUtility showBlockView];
        [UCWebServerHandler getClinicalDetails:list withDelegate:self];
    }
}

- (void)ClinicalDetailsSuccessHandler:(ASIHTTPRequest *)request {
    
    NSString *response = [request responseString];
    NSLog(@"%@",response);
    
    id result = [response JSONValue];
    
    if ([[result objectForKey:@"status"] isEqualToString:@"true"]) {
        if(isNational){
            isNational = NO;
            self.nationalClinicalDatas = [[result objectForKey:@"clinicalData"] mutableCopy];
            NSLog(@"%i",[self.nationalClinicalDatas count]);
            
            
            NSString *list = [[NSString alloc] init];
            for (int i = 0; i < [self.surgeonCasesDatas count]; i++) {
                list = [list stringByAppendingString:[[self.surgeonCasesDatas objectAtIndex:i] objectForKey:@"DetailID"]];
                if (i != self.surgeonCasesDatas.count - 1) {
                    list = [list stringByAppendingString:@","];
                }
            }
            
            NSLog(@"Surgeon List >> %@",list);
            //[UCUtility showBlockView];
            [UCWebServerHandler getClinicalDetails:list withDelegate:self];

        }else{
            [UCUtility hideBlockView];
            self.surgeonClicicalDatas = [[result objectForKey:@"clinicalData"] mutableCopy];
            UCSelectTimePointViewController *controller = [[UCSelectTimePointViewController alloc] initWithNibName:@"UCSelectTimePointViewController" bundle:nil];
            controller.isNationalFilter = YES;
            
            controller.performanceCases = [self.nationalClinicalDatas mutableCopy];
            controller.surgeonCases = [self.surgeonClicicalDatas mutableCopy];
            controller.totlaNationalCases = [self.nationalCaseDatas mutableCopy];
            controller.totalSurgeonCases = [self.surgeonCasesDatas mutableCopy];
            
            controller.totalSurgeonCount = [self.selectedCases count];
            
            [self.navigationController pushViewController:controller animated:YES];
        }
                
    }
    else {
        [UCUtility hideBlockView];
        [UCUtility showInfoAlertView:@"Error" withMessage:[result objectForKey:@"msg"]];
    }
    
    result = nil;
    response = nil;
}

- (void)ClinicalDetailsErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
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
                [self.selectedCases addObject:[self.surgeonCasesDatas objectAtIndex:indexPath.row]];
                
            }else{
                
                [imageView setImage:[UIImage imageNamed:@"proceduresUnCheck.png"]];
                [imageView setAccessibilityIdentifier:@"proceduresUnCheck.png"];
                
                NSString *temp = [[self.surgeonCasesDatas objectAtIndex:indexPath.row] objectForKey:@"DetailID"];
                
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
    controller.nationalFilter = self;
    controller.isNationalFilter = YES;
    [self.navigationController pushViewController:controller animated:YES];
}


- (IBAction)dateExpand:(UIButton *)sender {
    
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

-(IBAction)search:(id)sender{

    if (self.procedureLbl.text.length == 0 || [self.procedureLbl.text isEqualToString:@"Select"] || self.fromDateLbl.text.length == 0 || [self.fromDateLbl.text isEqualToString:@"Select"] || self.toDateLbl.text.length == 0 || [self.toDateLbl.text isEqualToString:@"Select"]) {
        
        [UCUtility showInfoAlertView:@"" withMessage:@"Please select all required fields"];
    }else{
        isNational = YES;
        
        if ([self varifyDates]) {
            
            [UCUtility showBlockView];
            [UCWebServerHandler getNationalPerformancData:self.procedureID fromTime:self.fromDate toTime:self.toDate withDelegate:self];
        }else{
            
            [UCUtility showInfoAlertView:@"" withMessage:@"From time cannot be in future of To time"];
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


- (void)surgeonPerformanceSuccessHandler:(ASIHTTPRequest *)request {
    
    NSString *response = [request responseString];
    NSLog(@"%@",response);
    id result = [response JSONValue];
    if (result && [[result objectForKey:@"status"] isEqualToString:@"true"] > 0) {
        if(isNational){
            isNational = NO;
            NSArray *data = [result objectForKey:@"sharedCases"];
            NSLog(@"%i",data.count);
            
            if ([data count] == 0) {
                
                [UCUtility hideBlockView];
                [UCUtility showInfoAlertView:@"" withMessage:@"No National cases found"];
                
            }else{
                
                [self.sortedArray removeAllObjects];
                [self sortCasesAccordingToDate:data];
                self.nationalCaseDatas = [self.sortedArray mutableCopy];
                NSLog(@"%i",self.nationalCaseDatas.count);
                
                
                self.procedureName = self.procedureLbl.text;
                self.fromDate = self.fromDate;
                self.toDate = self.toDate;
                [UCWebServerHandler getSurgeonPerformanceData:self.procedureID fromTime:self.fromDate toTime:self.toDate fromRecordNum:@"1" toRecordNum:@"1" withDelegate:self];
            }
            
            
            
        }else{
            [UCUtility hideBlockView];
            NSArray *data = [result objectForKey:@"contacts"];
            NSLog(@"%i",data.count);
            
            if ([data count] == 0) {
                
                [UCUtility showInfoAlertView:@"" withMessage:@"No Surgeon cases found"];
                
            }else{
                [self.sortedArray removeAllObjects];
                [self sortCasesAccordingToDate:data];
                self.surgeonCasesDatas = [self.sortedArray mutableCopy];
                NSLog(@"%i",self.surgeonCasesDatas.count);
                
                [self.casesTable reloadData];
            }
        }
        

    }else{
        [UCUtility hideBlockView];
    }
    
    response = nil;
    
}

- (void)surgeonPerformanceErrorHandler:(ASIHTTPRequest *)request {
    NSError *error = [request error];
    [UCUtility hideBlockView];
    [UCUtility showInfoAlertView:@"Error" withMessage:[error localizedDescription]];
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


@end
