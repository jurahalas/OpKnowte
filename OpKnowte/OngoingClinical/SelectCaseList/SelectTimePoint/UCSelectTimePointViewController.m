//
//  UCSelectTimePointViewController.m
//  MZUroCapture
//
//  Created by Omer on 5/9/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSelectTimePointViewController.h"
#import "UCSettingsViewController.h"
#import "CONSTANTS.h"
#import "UCTWTPPageOneViewController.h"
#import "UCSixMonthTimePointViewController.h"
#import "UCSurgeonPerformanceTwoWeeks.h"
#import "UCSurgeonPerformanceSixMonths.h"
#import "UCTimePointSummaryViewController.h"
#import "UCSurgeonPostOpData.h"
#import "UCESWLTimePoint.h"

#import "OKTimePointsManager.h"
#import "OKProceduresManager.h"
#import "OKClinicalManager.h"

@class UCSixMonthsTimePointViewController;

@interface UCSelectTimePointViewController ()

@end

@implementation UCSelectTimePointViewController

@synthesize caseData, timePointsTable, timePoints, performanceCases, isFilter;
@synthesize surgeonCases,isNationalFilter;
@synthesize onGoingData, timePoint;
@synthesize totalSurgeonCases, totlaNationalCases, totalCount, totalNationalCount, totalSurgeonCount;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.caseData = [[NSMutableDictionary alloc] init];
        self.onGoingData = [[NSMutableDictionary alloc] init];
        self.performanceCases = [[NSMutableArray alloc] init];
        self.surgeonCases = [[NSMutableArray alloc] init];
        self.totlaNationalCases = [[NSMutableArray alloc] init];
        self.totlaNationalCases = [[NSMutableArray alloc] init];
        self.isFilter = NO;
        self.isNationalFilter = NO;
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



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(IS_IPHONE_5)
    {
        headerLbl_.frame=CGRectMake(headerLbl_.frame.origin.x, headerLbl_.frame.origin.y+5, headerLbl_.frame.size.width, headerLbl_.frame.size.height);
    }
    [headerLbl_ setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    
    NSLog(@"%i",self.performanceCases.count);
    
    int procedure = [[OKProceduresManager instance].selectedProcedure.procedureID intValue];
    NSLog(@"%i",procedure);
    if (procedure == 10) {
        if (self.timePoints == nil) {
            self.timePoints = [[NSMutableArray alloc] init];
        }
        [self.timePoints removeAllObjects];
        [self.timePoints addObject:[self.caseData objectForKey:@"FollowUp"]];
        [self.timePointsTable reloadData];
        NSLog(@"%@",self.caseData);
        
    }else{
        
        [UCUtility showBlockView];
        [OKTimePointsManager getAllTimePoints:^(NSString *errorMsg, id responseJSON) {
            [UCUtility hideBlockView];
            if(!errorMsg)
                [self allTimePointsSucceded:responseJSON];
            else
                [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
        }];
    }
    
    if (self.isNationalFilter) {
        NSLog(@"%i",[self.totlaNationalCases count]);
        
        self.totalNationalCount = [self.totlaNationalCases count];
    }
        
}


- (void)allTimePointsSucceded:(id)response
{
    id result = response;
    if (result && [[result objectForKey:@"status"] isEqualToString:@"true"] > 0) {
        
        if (self.timePoints == nil) {
            self.timePoints = [[NSMutableArray alloc] init];
        }
        [self.timePoints removeAllObjects];
        
        self.timePoints = [[result objectForKey:@"timePoints"] mutableCopy];
        
        if (isNationalFilter) {
            [self.timePoints addObject:@"Operative Data"];
        }
        
        [self.timePointsTable reloadData];
        
    }else{
        [UCUtility showInfoAlertView:@"" withMessage:@"No defalut selection Found"];
    }
}


- (IBAction)homeButtonPressed:(id)sender {
    if (DELEGATE.isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)weeklyButtonPressed:(id)sender
{

}
-(IBAction)monthlyButtonPressed:(id)sender
{

}



// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.timePoints count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"UCSelectCaseCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    [cell. textLabel setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17.0]];
    if (indexPath.row == 11) {
        [cell.textLabel setText:[self.timePoints objectAtIndex:indexPath.row]];
    }else{
        int procedure = [[OKProceduresManager instance].selectedProcedure.procedureID intValue];
        NSLog(@"%i",procedure);
        if (procedure == 10) {
            [cell.textLabel setText:[self.timePoints objectAtIndex:indexPath.row]];
        }else{
            [cell.textLabel setText:[[self.timePoints objectAtIndex:indexPath.row] objectForKey:@"timePointName"]];
        }
        
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        if (self.isFilter == YES) {
            
            UCSurgeonPerformanceTwoWeeks *controller = [[UCSurgeonPerformanceTwoWeeks alloc] initWithNibName:@"UCSurgeonPerformanceTwoWeeks" bundle:nil];
            controller.performanceCases = [self.performanceCases mutableCopy];
            controller.isNational = NO;
            controller.totalCount = self.totalCount;
            [self.navigationController pushViewController:controller animated:YES];
            
        }else if(isNationalFilter == YES){
            UCSurgeonPerformanceTwoWeeks *controller = [[UCSurgeonPerformanceTwoWeeks alloc] initWithNibName:@"UCSurgeonPerformanceTwoWeeks" bundle:nil];
            controller.performanceCases = [self.performanceCases mutableCopy];
            controller.surgeonCases = [self.surgeonCases mutableCopy];
            
            controller.totalSurgeonCount = self.totalSurgeonCount;
            controller.totalNationalCount = self.totalNationalCount;
            
            controller.isNational = YES;
            [self.navigationController pushViewController:controller animated:YES];
        
        }else{
            /*
            UCTWTPPageOneViewController *controller = [[UCTWTPPageOneViewController alloc] initWithNibName:@"UCTWTPPageOneViewController" bundle:nil];
            controller.caseData = [self.caseData mutableCopy];
            controller.timePoint = [NSDictionary dictionaryWithDictionary:[self.timePoints objectAtIndex:indexPath.row]];
            
            [self.navigationController pushViewController:controller animated:YES];
            */
            
            int procedure = [[OKProceduresManager instance].selectedProcedure.procedureID intValue];
            if (procedure == 10) {
                
                [UCUtility showBlockView];
                [OKClinicalManager getOngoingClinicalDetail:[self.caseData objectForKey:@"DetailID"] withTimePointID:@"" withUserID:[OKUserManager instance].currentUser.userID withProcedureID:[OKProceduresManager instance].selectedProcedure.procedureID handler:^(NSString *errorMsg, id responseJSON) {
                    [UCUtility hideBlockView];
                    if(!errorMsg)
                       [self OnGoingDetailSucceded:responseJSON];
                    else
                        [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
                }];
            }else{
                self.timePoint = [self.timePoints objectAtIndex:indexPath.row];
                
                [UCUtility showBlockView];
                [OKClinicalManager getOngoingClinicalDetail:[self.caseData objectForKey:@"DetailID"] withTimePointID:[[self.timePoints objectAtIndex:indexPath.row] objectForKey:@"id"] withUserID:[OKUserManager instance].currentUser.userID withProcedureID:[OKProceduresManager instance].selectedProcedure.procedureID handler:^(NSString *errorMsg, id responseJSON) {
                    
                    [UCUtility hideBlockView];
                    if(!errorMsg)
                        [self OnGoingDetailSucceded:responseJSON];
                    else
                        [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
                }];
            }

        }
        
                
    }else if (indexPath.row >0 && indexPath.row <11){
        
        if (self.isFilter == YES) {
            
            UCSurgeonPerformanceSixMonths *controller = [[UCSurgeonPerformanceSixMonths alloc] initWithNibName:@"UCSurgeonPerformanceSixMonths" bundle:nil];
            controller.performanceCases = [self.performanceCases mutableCopy];
            controller.timepointID = indexPath.row+1;
            controller.totalCount = self.totalCount;
            [self.navigationController pushViewController:controller animated:YES];
            
        }else if(isNationalFilter == YES){
            UCSurgeonPerformanceSixMonths *controller = [[UCSurgeonPerformanceSixMonths alloc] initWithNibName:@"UCSurgeonPerformanceSixMonths" bundle:nil];
            controller.performanceCases = [self.performanceCases mutableCopy];
            controller.surgeonCases = [self.surgeonCases mutableCopy];
            controller.timepointID = indexPath.row+1;
            controller.isNational = YES;
            controller.totalNationalCount = self.totalNationalCount;
            controller.totalSurgeonCount = self.totalSurgeonCount;
            [self.navigationController pushViewController:controller animated:YES];
            
        }else{
            
            /*
            UCSixMonthTimePointViewController *controller = [[UCSixMonthTimePointViewController alloc] initWithNibName:@"UCSixMonthTimePointViewController" bundle:nil];
            
            controller.caseData = [self.caseData mutableCopy];
            controller.timePoint = [NSDictionary dictionaryWithDictionary:[self.timePoints objectAtIndex:indexPath.row]];
            
            [self.navigationController pushViewController:controller animated:YES];
             
             */
            
            self.timePoint = [self.timePoints objectAtIndex:indexPath.row];
            
            [UCUtility showBlockView];
            [OKClinicalManager getOngoingClinicalDetail:[self.caseData objectForKey:@"DetailID"] withTimePointID:[[self.timePoints objectAtIndex:indexPath.row] objectForKey:@"id"] withUserID:[OKUserManager instance].currentUser.userID withProcedureID:[OKProceduresManager instance].selectedProcedure.procedureID handler:^(NSString *errorMsg, id responseJSON) {
                
                [UCUtility hideBlockView];
                if(!errorMsg)
                    [self OnGoingDetailSucceded:responseJSON];
                else
                    [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
            }];
            
        }
    }else if (indexPath.row == 11){
        
        NSLog(@"Operative Data");
        
        UCSurgeonPostOpData *controller = [[UCSurgeonPostOpData alloc] initWithNibName:@"UCSurgeonPostOpData" bundle:nil];
        
        controller.surgeonCases = [self.totalSurgeonCases mutableCopy];
        controller.selectedCases = [self.totlaNationalCases mutableCopy];
        controller.totalSurgeonCount =self.totalSurgeonCount;
        controller.totalNationalCount = self.totalNationalCount;
        
        controller.isNationalData = YES;
        
        [self.navigationController pushViewController:controller animated:YES];
        
    }
}



- (void)OnGoingDetailSucceded:(id)response
{
    id result = response;
    if (result && [[result objectForKey:@"status"] isEqualToString:@"true"] > 0) {
        
        if (self.onGoingData == nil) {
            self.onGoingData = [[NSMutableDictionary alloc] init];
        }
        [self.onGoingData removeAllObjects];
        self.onGoingData = [result mutableCopy];
        
        NSString *caseID = [[[self.onGoingData objectForKey:@"clinicalData"] objectAtIndex:0] objectForKey:@"caseID"];
        if (caseID.length > 0) {
            [self setValues];
        }else{
            // [self setValues];
            
            if ([[self.timePoint objectForKey:@"id"] isEqualToString:@"1"]) {
                
                UCTWTPPageOneViewController *controller = [[UCTWTPPageOneViewController alloc] initWithNibName:@"UCTWTPPageOneViewController" bundle:nil];
                controller.caseData = [self.caseData mutableCopy];
                controller.timePoint = self.timePoint;
                [self.navigationController pushViewController:controller animated:YES];
                
            }else if ([[self.timePoint objectForKey:@"id"] intValue] >1 && [[self.timePoint objectForKey:@"id"] intValue] <12){
                
                UCSixMonthTimePointViewController *controller = [[UCSixMonthTimePointViewController alloc] initWithNibName:@"UCSixMonthTimePointViewController" bundle:nil];
                controller.caseData = [self.caseData mutableCopy];
                controller.timePoint = self.timePoint;
                [self.navigationController pushViewController:controller animated:YES];
                
            }else{
                int procedure = [[OKProceduresManager instance].selectedProcedure.procedureID intValue];
                if (procedure == 10) {
                    UCESWLTimePoint *controller = [[UCESWLTimePoint alloc] initWithNibName:@"UCESWLTimePoint" bundle:nil];
                    
                    controller.stonesCount = [self.caseData objectForKey:@"Stones_Count"];
                    controller.caseID = [self.caseData objectForKey:@"DetailID"];
                    
                    [self.navigationController pushViewController:controller animated:YES];
                }
            }
        }
    }
    
    response = nil;
    
}


-(void)setValues{
    NSDictionary *dict = [[self.onGoingData objectForKey:@"clinicalData"] objectAtIndex:0];
    NSLog(@"%@",dict);
    
    UCTimePointSummaryViewController *controller = [[UCTimePointSummaryViewController alloc] initWithNibName:@"UCTimePointSummaryViewController" bundle:nil];
    NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] init];
    
    if ([[dict objectForKey:@"timePointID"] isEqualToString:@"1"]){
        
        
        NSDictionary *dict = [[self.onGoingData objectForKey:@"clinicalData"] objectAtIndex:0];
        //NSLog(@"%@",dict);
        
        [tempDictionary setObject:[dict objectForKey:T_STAGE] forKey:@"T"];
        [tempDictionary setObject:[dict objectForKey:N_STAGE] forKey:@"N"];
        [tempDictionary setObject:[dict objectForKey:M_STAGE] forKey:@"M"];
        [tempDictionary setObject:[dict objectForKey:TUMOR_CHAR_STAGE] forKey:@"Tumor Characterictics"];
        [tempDictionary setObject:[dict objectForKey:FUHRMAN_GRAGE_STAGE] forKey:@"Fuhrman Grade"];
        [tempDictionary setObject:[dict objectForKey:MARGIN_STAGE] forKey:@"Margins"];
        [tempDictionary setObject:[dict objectForKey:DEEP_MARGIN_STAGE] forKey:@"Deep Margin"];
        //////////////////////////////////////////
        [tempDictionary setObject:[dict objectForKey:NIGHTS_STAGE] forKey:@"Post-Op Hospital Stay"];
        [tempDictionary setObject:[dict objectForKey:COMPLICATIONS_STAGE] forKey:@"Complications"];
        [tempDictionary setObject:[dict objectForKey:PREOP_BUN_STAGE] forKey:@"Pre-operative Bun"];
        [tempDictionary setObject:[dict objectForKey:PREOP_CRATININE_STAGE] forKey:@"Pre-operative Creatinine"];
        [tempDictionary setObject:[dict objectForKey:POSTOP_BUN_STAGE] forKey:@"Post-operative Bun"];
        [tempDictionary setObject:[dict objectForKey:POSTOP_CREATININE_STAGE] forKey:@"Post-operative Creatinine"];
        [tempDictionary setObject:[dict objectForKey:ADD_DIAGNOSIS_STAGE] forKey:@"Additional Diagnosis"];
        
        controller.caseData = self.caseData;
        controller.caseID = [self.caseData objectForKey:@"DetailID"];
        controller.timePointID = [self.timePoint objectForKey:@"id"];
        controller.timePoint = @"Two";
        controller.summaryDictionary = [tempDictionary mutableCopy];
        
    }else if ([[dict objectForKey:@"timePointID"] intValue] >1 && [[dict objectForKey:@"timePointID"] intValue] <12){
        
        [controller.summaryDictionary setObject:[dict objectForKey:XRAY_STAGE] forKey:@"Chest X-ray"];
        [controller.summaryDictionary setObject:[dict objectForKey:BUN_STAGE] forKey:@"Bun"];
        [controller.summaryDictionary setObject:[dict objectForKey:CREATININE_STAGE] forKey:@"Creatinine"];
        [controller.summaryDictionary setObject:[dict objectForKey:LIVER_ENZYMES_STAGE] forKey:@"Liver Enzymes"];
        [controller.summaryDictionary setObject:[dict objectForKey:HERNIA_STAGE] forKey:@"Port Site Hernia"];
        [controller.summaryDictionary setObject:[dict objectForKey:OTHER_STAGE] forKey:@"Other"];
        [controller.summaryDictionary setObject:[dict objectForKey:CT_SCAN_STAGE] forKey:@"CT-Scan"];
        
        controller.caseData = self.caseData;
        controller.caseID = [self.caseData objectForKey:@"DetailID"];
        controller.timePointID = [self.timePoint objectForKey:@"id"];
        controller.timePoint = @"Six";
        
    }else{
        //NSLog(@"%@",self.caseData);
        [controller.summaryDictionary setObject:[self.caseData objectForKey:@"FollowUp"] forKey:@"Follow up"];
        [controller.summaryDictionary setObject:[dict objectForKey:@"postComplications"] forKey:@"Complications"];
        
        NSArray *components = [[dict objectForKey:@"fragmentation"] componentsSeparatedByString:@","];
        
        for (int i = 0; i < [components count]; i++) {
            [controller.summaryDictionary setObject:[components objectAtIndex:i] forKey:[NSString stringWithFormat:@"Fragmentation for stone %i",i+1]];
        }
        
        controller.caseData = self.caseData;
        controller.caseID = [self.caseData objectForKey:@"DetailID"];
        controller.timePointID = @"";
        controller.timePoint = @"";
    }
    controller.timePointDictionary = self.timePoint;
    [self.navigationController pushViewController:controller animated:YES];

}


@end
