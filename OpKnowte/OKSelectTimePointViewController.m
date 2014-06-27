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
#import "OKSelectFUDVariablesVC.h"
#import "OKOngoingClinicalViewController.h"

@interface OKSelectTimePointViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *selectTimePointTableView;
@property (strong, nonatomic) NSArray *timePointsArray;
@property (strong, nonatomic) NSArray *timePointsPenile;
@property (nonatomic) int timepointID;
@property (strong, nonatomic) NSString *caseNumber;

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
    
    
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    OKTimePointsManager *timePointsManager = [OKTimePointsManager instance];
    [timePointsManager getAllTimePointsWithHandler:^(NSString* error, NSArray* timePointsArray){
        _timePointsArray = timePointsArray;
        [self.selectTimePointTableView reloadData];
        [[OKLoadingViewController instance] hide];
    }];
    
    if ([_procID isEqualToString:@"9"]) {
        _timePointsPenile = [[NSArray alloc] initWithObjects:
                            @"6 weeks",
                            @"3 months",
                            @"6 months",
                            @"12 months",
                            @"18 months",
                            @"24 months",
                            @"30 months",
                            @"36 months",
                            @"42 months",
                            @"48 months",
                            @"54 months",
                            @"60 months",
                            nil];
    }
    
    if (!IS_IOS7) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
	// Do any additional setup after loading the view.
}
-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width+27, [UIImage imageNamed:@"back"].size.height );
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
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
    if ([_procID isEqualToString:@"9"]){
            [cell.timePointLabel setText:[_timePointsPenile objectAtIndex:indexPath.row]];
    }else{
        [cell.timePointLabel setText:timePoint.timePointName];
    }
//    if (indexPath.row == 11) {
//        [cell.timePointLabel setText:[self.timePointsArray objectAtIndex:indexPath.row]];
//    }else{
//        [cell.timePointLabel setText:timePoint.timePointName];
//    }
    [cell setCellBGImageLight:(int)indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKTimePointModel *timePoint = self.timePointsArray[indexPath.row];
    [OKTimePointsManager instance].selectedTimePoint = timePoint;

    NSString *cameFromVC = [[NSString alloc] init];
    if (indexPath.row == 0) {
        cameFromVC = @"weeks";
    }else if (indexPath.row >0 && indexPath.row <11){
        cameFromVC = @"months";
    }
    _timepointID = indexPath.row+1;
    if([_cameFromVC isEqualToString:@"FollowUpData"]){
        [self performSegueWithIdentifier:@"fromSelectTimeToSelectVariables" sender:cameFromVC];
    }else{
        [[OKLoadingViewController instance]showWithText:@"Loading"];
        [[OKUserManager instance]getUserAccess:[OKProceduresManager instance].selectedProcedure.identifier handler:^(NSString *errorMsg) {
            if(!errorMsg){
                if ([_procID isEqualToString:@"9"]) {
                    _caseNumber = _caseObj.caseID;
                }else{
                    _caseNumber = [OKCaseManager instance].selectedCase.identifier;
                }
                [[OKCaseManager instance]getOngoingClinicalDetailsForCaseID:_caseNumber timePointID:timePoint.identifier procedureID:[OKProceduresManager instance].selectedProcedure.identifier handler:^(NSString *errorMsg, OKOngoingData *ongoingData) {
                
                    [[OKLoadingViewController instance]hide];
                    if(!errorMsg){
                        
                        if ([_procID isEqualToString:@"9"] && [ongoingData.averageCyclingTime isEqualToString:@""]) {
                            [self performSegueWithIdentifier:@"ongoingClinical" sender:ongoingData];
                        }else if ([_procID isEqualToString:@"9"] && ![ongoingData.averageCyclingTime isEqualToString:@""]){
                            [self performSegueWithIdentifier:@"summaryVC" sender:ongoingData];
                        }else if ([_procID isEqualToString:@"1"] && ![ongoingData.gleason isEqualToString:@""]){
                            [self performSegueWithIdentifier:@"summaryVC" sender:ongoingData];
                        }else if ([_procID isEqualToString:@"1"] && [ongoingData.gleason isEqualToString:@""]){
                            [self performSegueWithIdentifier:@"ongoingClinical" sender:ongoingData];
                        }else{
                            if ([cameFromVC isEqualToString:@"weeks"]) {
                                if(![ongoingData.tStage isEqualToString:@""]){
                                    [self performSegueWithIdentifier:@"summaryVC" sender:ongoingData];
                                }else{
                                    [self performSegueWithIdentifier:@"ongoingClinical" sender:ongoingData];
                                }
                            }else if ([cameFromVC isEqualToString:@"months"]){
                                if(![ongoingData.Bun isEqualToString:@""] && ongoingData.Bun!=nil){
                                    [self performSegueWithIdentifier:@"summaryVC" sender:ongoingData];
                                }else{
                                    [self performSegueWithIdentifier:@"ongoingClinical" sender:ongoingData];
                                }
                            }
                        }
                    }
                }];
            }else
                [[OKLoadingViewController instance]hide];
        }];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"fromSelectTimeToSelectVariables"]){
        OKSelectFUDVariablesVC *sharVC = (OKSelectFUDVariablesVC*)segue.destinationViewController;
        sharVC.cameFromVC = sender;
        sharVC.performanceCases = [[NSMutableArray alloc] initWithArray:_performanceCases];
        sharVC.surgeonCases = [[NSMutableArray alloc] initWithArray:_surgeonCases];
        sharVC.totlaNationalCases = [[NSMutableArray alloc] initWithArray:_totlaNationalCases];
        sharVC.totalSurgeonCases = [[NSMutableArray alloc] initWithArray:_totalSurgeonCases];
        sharVC.timepointID = _timepointID;
    }else if ([segue.identifier isEqualToString:@"summaryVC"]){
        OKProcedureDetailSummaryViewController *summaryVC = (OKProcedureDetailSummaryViewController*)segue.destinationViewController;
        summaryVC.ongoingData = sender;
        summaryVC.caseNumber = _caseNumber;
        if ([_procID isEqualToString:@"9"]) {
            summaryVC.detailPeriod = OKProcedureSummaryDetailPenile;
        }else if ([_procID isEqualToString:@"1"]){
            summaryVC.detailPeriod = OKProcedureSummaryDetailRobotic;
        }else{
            summaryVC.detailPeriod = self.selectTimePointTableView.indexPathForSelectedRow.row == 0 ? OKProcedureSummaryDetailTwoWeeks:OKProcedureSummaryDetailSixWeeks;
        }
    }else if ([segue.identifier isEqualToString:@"ongoingClinical"]){
        OKOngoingClinicalViewController *summaryVC = (OKOngoingClinicalViewController*)segue.destinationViewController;
        summaryVC.ongoingData = sender;
        summaryVC.procID = _procID;
        summaryVC.caseNumber = _caseNumber;
        if ([_procID isEqualToString:@"9"]) {
            summaryVC.detailPeriod = OKProcedureSummaryDetailPenile;
        }else if ([_procID isEqualToString:@"1"]){
            summaryVC.detailPeriod = OKProcedureSummaryDetailRobotic;
        }else{
            summaryVC.detailPeriod = self.selectTimePointTableView.indexPathForSelectedRow.row == 0 ? OKProcedureSummaryDetailTwoWeeks:OKProcedureSummaryDetailSixWeeks;
        }
    }

}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.selectTimePointTableView deselectRowAtIndexPath:self.selectTimePointTableView.indexPathForSelectedRow animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
