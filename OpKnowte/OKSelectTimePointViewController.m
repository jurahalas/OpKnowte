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
#import "OKFollowUpDataManager.h"
#import "OKLRRadicalProstatectomyModel.h"

@interface OKSelectTimePointViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *selectTimePointTableView;
@property (strong, nonatomic) NSArray *timePointsArray;
@property (strong, nonatomic) NSArray *timePointsPenile;
@property (strong, nonatomic) NSArray *timePointShockwave;
@property (nonatomic) int timepointID;
@property (strong, nonatomic) NSString *caseNumber;
@property (strong, nonatomic) NSString *selectedCases;
@property (strong, nonatomic) OKCase *caseObj;
@property (nonatomic, assign) int selectedRow;
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
    [timePointsManager getAllTimePointsWithProcID:_procID WithHandler:^(NSString *errorMsg, NSArray *timePointsArray) {
        
        _timePointsArray = timePointsArray;
        [self.selectTimePointTableView reloadData];
        [[OKLoadingViewController instance] hide];
    }];
    if (!IS_IOS7) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
    
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
    [cell.timePointLabel setText:timePoint.timePointName];
    [cell setCellBGImageLight:(int)indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKTimePointModel *timePoint = self.timePointsArray[indexPath.row];
    [OKTimePointsManager instance].selectedTimePoint = timePoint;
    self.selectedRow =indexPath.row;
    
    NSString *cameFromVC = [[NSString alloc] init];
    if ([[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 9 || [[OKProceduresManager instance].selectedProcedure.identifier integerValue] == 10) {
        cameFromVC = @"months";
    }else{
        if (indexPath.row == 0) {
            cameFromVC = @"weeks";
        }else if (indexPath.row >0 && indexPath.row <11){
            cameFromVC = @"months";
        }
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
                        }else if ([_procID isEqualToString:@"1"] && ![ongoingData.continence isEqualToString:@""] && [[OKTimePointsManager instance].selectedTimePoint.identifier integerValue] > 12){
                            [self performSegueWithIdentifier:@"summaryVC" sender:ongoingData];
                        }else if ([_procID isEqualToString:@"1"] && [ongoingData.continence isEqualToString:@""] && [[OKTimePointsManager instance].selectedTimePoint.identifier integerValue] > 12){
                            [self performSegueWithIdentifier:@"ongoingClinical" sender:ongoingData];
                        }else if ([_procID isEqualToString:@"1"] && ![ongoingData.gleason isEqualToString:@""]){
                            [self performSegueWithIdentifier:@"summaryVC" sender:ongoingData];
                        }else if ([_procID isEqualToString:@"1"] && [ongoingData.gleason isEqualToString:@""]){
                            [self performSegueWithIdentifier:@"ongoingClinical" sender:ongoingData];
                        }else if ([_procID isEqualToString:@"10"] && ([ongoingData.stoneLocation isEqualToString:@""] || ongoingData.stoneLocation == nil)){
                            [self performSegueWithIdentifier:@"ongoingClinical" sender:ongoingData];
                        }else if ([_procID isEqualToString:@"10"] && ![ongoingData.stoneLocation isEqualToString:@""]){
                            [self performSegueWithIdentifier:@"summaryVC" sender:ongoingData];
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
//            {
//                UIAlertView *accessAlert = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                                                     message:@"you haven't access for entering data to this case "
//                                                                                    delegate:self
//                                                                           cancelButtonTitle:@"OK"
//                                                                           otherButtonTitles:nil, nil];
//                [accessAlert show];
                [[OKLoadingViewController instance]hide];
//            }
        }];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
        summaryVC.stonesCount = _stonesCount;
        if ([_procID isEqualToString:@"9"] && [_cameFromVC isEqualToString:@"FollowUpData"]) {
            summaryVC.detailPeriod = OKProcedureSummaryFollowPenile;
            summaryVC.caseNumber = _caseID;
        }else if ([_procID isEqualToString:@"1"]){
            if ([[OKTimePointsManager instance].selectedTimePoint.identifier integerValue]>12) {
                summaryVC.detailPeriod = OKProcedureSummaryDetailRobotic6Weeks;
            }else{
                summaryVC.detailPeriod = OKProcedureSummaryDetailRobotic;
            }
        }else if ([_procID isEqualToString:@"9"]){
            summaryVC.detailPeriod = OKProcedureSummaryDetailPenile;
        }else if ([_procID isEqualToString:@"10"]){
            summaryVC.detailPeriod = OKProcedureSummaryDetailShockwave;
        }else{
            //summaryVC.detailPeriod = self.selectTimePointTableView.indexPathForSelectedRow.row == 0 ? OKProcedureSummaryDetailTwoWeeks:OKProcedureSummaryDetailSixWeeks;
            summaryVC.detailPeriod = self.selectedRow == 0 ? OKProcedureSummaryDetailTwoWeeks:OKProcedureSummaryDetailSixWeeks;
                    }
    }else if ([segue.identifier isEqualToString:@"ongoingClinical"]){
        OKOngoingClinicalViewController *ongVC = (OKOngoingClinicalViewController*)segue.destinationViewController;
        ongVC.ongoingData = sender;
        ongVC.procID = _procID;
        ongVC.caseNumber = _caseNumber;
        ongVC.stonesCount = _stonesCount;
        if ([_procID isEqualToString:@"9"] && [_cameFromVC isEqualToString:@"FollowUpData"]) {
            ongVC.detailPeriod = OKProcedureSummaryFollowPenile;
            ongVC.caseNumber = _caseID;
        }else if ([_procID isEqualToString:@"9"]){
            ongVC.detailPeriod = OKProcedureSummaryDetailPenile;
        }else if ([_procID isEqualToString:@"1"]){
            if ([[OKTimePointsManager instance].selectedTimePoint.identifier integerValue]>12) {
                ongVC.detailPeriod = OKProcedureSummaryDetailRobotic6Weeks;
            }else{
                ongVC.detailPeriod = OKProcedureSummaryDetailRobotic;
            }
        }else if ([_procID isEqualToString:@"10"]){
            ongVC.detailPeriod = OKProcedureSummaryDetailShockwave;
        }else{
            //ongVC.detailPeriod = self.selectTimePointTableView.indexPathForSelectedRow.row == 0 ? OKProcedureSummaryDetailTwoWeeks:OKProcedureSummaryDetailSixWeeks;
            ongVC.detailPeriod = self.selectedRow == 0 ? OKProcedureSummaryDetailTwoWeeks:OKProcedureSummaryDetailSixWeeks;
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
}

@end
