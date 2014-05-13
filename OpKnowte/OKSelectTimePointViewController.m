//
//  OKSelectTimePointViewController.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/18/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSelectTimePointViewController.h"
#import "OKTimePointModel.h"
#import "OKTimePointsManager.h"
#import "OKProcedureDetailSummaryViewController.h"
#import "OKCaseManager.h"
#import "OKCase.h"
#import "OKProceduresManager.h"
#import "OKProcedureModel.h"

@interface OKSelectTimePointViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *selectTimePointTableView;
@property (strong, nonatomic) NSArray *timePointsArray;

@property (strong, nonatomic) OKCase *caseObj;

@end

@implementation OKSelectTimePointViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    _selectTimePointTableView.backgroundColor = [UIColor clearColor];
    
    self.selectTimePointTableView.dataSource = self;
    self.selectTimePointTableView.delegate = self;
    
    _selectTimePointTableView.frame = CGRectMake(_selectTimePointTableView.frame.origin.x, _selectTimePointTableView.frame.origin.y, _selectTimePointTableView.frame.size.width, (_selectTimePointTableView.frame.size.height - 50.f));
    [self addBottomTabBar];
    
    self.caseObj = [OKCaseManager instance].selectedCase;
    
    int procedure = [[OKProceduresManager instance].selectedProcedure.procedureID intValue];
    NSLog(@"%i",procedure);
//    if (procedure == 10) {
//        if (self.timePoints == nil) {
//            self.timePoints = [[NSMutableArray alloc] init];
//        }
//        [self.timePoints removeAllObjects];
//        [self.timePoints addObject:[self.caseData objectForKey:@"FollowUp"]];
//        [self.timePointsTable reloadData];
//        NSLog(@"%@",self.caseData);
//        
//    }else{
    
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    OKTimePointsManager *timePointsManager = [OKTimePointsManager instance];
    [timePointsManager getAllTimePointsWithHandler:^(NSString* error, NSArray* timePointsArray){
        _timePointsArray = timePointsArray;
        [self.selectTimePointTableView reloadData];
        [[OKLoadingViewController instance] hide];
    }];
    
//    }
}

#pragma mark - IBActions
- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Table View methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _timePointsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"timePointCell";
    OKSelectTimePointCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKSelectTimePointCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    OKTimePointModel *timePoint = (OKTimePointModel*)self.timePointsArray[indexPath.row];
    
    if (indexPath.row == 11) {
        [cell.textLabel setText:[self.timePointsArray objectAtIndex:indexPath.row]];
    }else{
        int procedure = [[OKProceduresManager instance].selectedProcedure.procedureID intValue];
        NSLog(@"%i",procedure);
        if (procedure == 10) {
            [cell.textLabel setText:[self.timePointsArray objectAtIndex:indexPath.row]];
        }else{
            [cell.textLabel setText:timePoint.timePointName];
        }
    }
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OKTimePointModel *timePoint = self.timePointsArray[indexPath.row];
    
    [OKTimePointsManager instance].selectedTimePoint = timePoint;
    
//    [[OKCaseManager instance]getOngoingClinicalDetailsForCaseID:[OKCaseManager instance].selectedCase.identifier timePointID:timePoint.timePointID procedureID:[OKProceduresManager instance].selectedProcedure.procedureID handler:^(NSString *errorMsg, id responseJSON) {
//        
//        
//        if(!errorMsg){
//            
//        }
//    }];

//    if (indexPath.row == 0) {
//        
//        if (self.isFilter) {
////            
////            UCSurgeonPerformanceTwoWeeks *controller = [[UCSurgeonPerformanceTwoWeeks alloc] initWithNibName:@"UCSurgeonPerformanceTwoWeeks" bundle:nil];
////            controller.performanceCases = [self.performanceCases mutableCopy];
////            controller.isNational = NO;
////            controller.totalCount = self.totalCount;
////            [self.navigationController pushViewController:controller animated:YES];
//            
//        }else if(self.isNationalFilter){
////            UCSurgeonPerformanceTwoWeeks *controller = [[UCSurgeonPerformanceTwoWeeks alloc] initWithNibName:@"UCSurgeonPerformanceTwoWeeks" bundle:nil];
////            controller.performanceCases = [self.performanceCases mutableCopy];
////            controller.surgeonCases = [self.surgeonCases mutableCopy];
////            
////            controller.totalSurgeonCount = self.totalSurgeonCount;
////            controller.totalNationalCount = self.totalNationalCount;
////            
////            controller.isNational = YES;
////            [self.navigationController pushViewController:controller animated:YES];
//            
//        }else{
//            
//            /*
//             UCTWTPPageOneViewController *controller = [[UCTWTPPageOneViewController alloc] initWithNibName:@"UCTWTPPageOneViewController" bundle:nil];
//             controller.caseData = [self.caseData mutableCopy];
//             controller.timePoint = [NSDictionary dictionaryWithDictionary:[self.timePoints objectAtIndex:indexPath.row]];
//             
//             [self.navigationController pushViewController:controller animated:YES];
//             */
//            
//            int procedure = [[OKProceduresManager instance].selectedProcedure.procedureID intValue];
//            if (procedure == 10) {
//                
//                [[OKLoadingViewController instance]showWithText:@"Loading"];
//                [ok getOngoingClinicalDetail:[self.caseData objectForKey:@"DetailID"] withTimePointID:@"" withUserID:[defaults objectForKey:UD_USERID] withProcedureID:[UCAppDelegate sharedObject].selectedProcedure.procedureID withDelegate:self];
//            }else{
//                self.timePoint = [self.timePoints objectAtIndex:indexPath.row];
//                
//                [UCUtility showBlockView];
//                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                [UCWebServerHandler getOngoingClinicalDetail:[self.caseData objectForKey:@"DetailID"] withTimePointID:[[self.timePoints objectAtIndex:indexPath.row] objectForKey:@"id"] withUserID:[defaults objectForKey:UD_USERID] withProcedureID:[UCAppDelegate sharedObject].selectedProcedure.procedureID withDelegate:self];
//            }
//            
//        }
//        
//        
//    }else if (indexPath.row >0 && indexPath.row <11){
//        
//        if (self.isFilter == YES) {
//            
//            UCSurgeonPerformanceSixMonths *controller = [[UCSurgeonPerformanceSixMonths alloc] initWithNibName:@"UCSurgeonPerformanceSixMonths" bundle:nil];
//            controller.performanceCases = [self.performanceCases mutableCopy];
//            controller.timepointID = indexPath.row+1;
//            controller.totalCount = self.totalCount;
//            [self.navigationController pushViewController:controller animated:YES];
//            
//        }else if(isNationalFilter == YES){
//            UCSurgeonPerformanceSixMonths *controller = [[UCSurgeonPerformanceSixMonths alloc] initWithNibName:@"UCSurgeonPerformanceSixMonths" bundle:nil];
//            controller.performanceCases = [self.performanceCases mutableCopy];
//            controller.surgeonCases = [self.surgeonCases mutableCopy];
//            controller.timepointID = indexPath.row+1;
//            controller.isNational = YES;
//            controller.totalNationalCount = self.totalNationalCount;
//            controller.totalSurgeonCount = self.totalSurgeonCount;
//            [self.navigationController pushViewController:controller animated:YES];
//            
//        }else{
//            
//            /*
//             UCSixMonthTimePointViewController *controller = [[UCSixMonthTimePointViewController alloc] initWithNibName:@"UCSixMonthTimePointViewController" bundle:nil];
//             
//             controller.caseData = [self.caseData mutableCopy];
//             controller.timePoint = [NSDictionary dictionaryWithDictionary:[self.timePoints objectAtIndex:indexPath.row]];
//             
//             [self.navigationController pushViewController:controller animated:YES];
//             
//             */
//            
//            self.timePoint = [self.timePoints objectAtIndex:indexPath.row];
//            
//            [UCUtility showBlockView];
//            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//            [UCWebServerHandler getOngoingClinicalDetail:[self.caseData objectForKey:@"DetailID"] withTimePointID:[[self.timePoints objectAtIndex:indexPath.row] objectForKey:@"id"] withUserID:[defaults objectForKey:UD_USERID] withProcedureID:[UCAppDelegate sharedObject].selectedProcedure.procedureID withDelegate:self];
//            
//        }
//    }else if (indexPath.row == 11){
//        
//        NSLog(@"Operative Data");
//        
//        UCSurgeonPostOpData *controller = [[UCSurgeonPostOpData alloc] initWithNibName:@"UCSurgeonPostOpData" bundle:nil];
//        
//        controller.surgeonCases = [self.totalSurgeonCases mutableCopy];
//        controller.selectedCases = [self.totlaNationalCases mutableCopy];
//        controller.totalSurgeonCount =self.totalSurgeonCount;
//        controller.totalNationalCount = self.totalNationalCount;
//        
//        controller.isNationalData = YES;
//        
//        [self.navigationController pushViewController:controller animated:YES];
//        
//    }

    
}



//-(NSDictionary*)summaryDictFromJSON:(NSDictionary*)json
//{
//    
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
