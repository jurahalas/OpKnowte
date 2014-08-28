//
//  OKCaseListViewController.m
//  OpKnowte
//
//  Created by Olegek on 28.08.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKCaseListViewController.h"
#import "OKCaseListTableViewCell.h"
#import "OKFakeTableViewCell.h"
#import "OKCaseManager.h"
#import "OKUserManager.h"
#import "OKCase.h"
#import "OKProceduresManager.h"
#import "OKProcedureModel.h"
#import "OKTemplateManager.h"
#import "OKSelectTimePointViewController.h"

@interface OKCaseListViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *goToListView;
@property (strong, nonatomic) IBOutlet UIButton *goToUserListButton;
- (IBAction)goToUsersListTapped:(id)sender;

@property (strong, nonatomic) NSArray *cases;

@end

@implementation OKCaseListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, (self.tableView.frame.size.height - 57.f));
    [self addBottomTabBar];
    [self setupData];
    [self addLeftButtonToNavbar];

    self.goToUserListButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    self.goToUserListButton.layer.cornerRadius = 14;
}


-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width, [UIImage imageNamed:@"back"].size.height );
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


-(void)setupData
{
    [[OKLoadingViewController instance]showWithText:@"Loading"];
    [[OKCaseManager instance]getCaseListForProcedureWithID:[OKProceduresManager instance].selectedProcedure.identifier surgeonID:[OKUserManager instance].currentUser.identifier handler:^(NSString *errorMsg, NSArray *cases) {
        [[OKLoadingViewController instance]hide];
        if(!errorMsg){
            self.cases = [cases sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"DOS" ascending:YES]]];
            [self.tableView reloadData];
        }
    }];
}


#pragma mark IBAction metods
- (IBAction)backButton
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark Table View datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cases.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"selectCase";
    OKCaseListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    OKCase *selCase = self.cases[indexPath.row];

    cell.textLabel.text = selCase.patientName;
    cell.dataLable.text = selCase.dateOfServiceString;
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//        [[OKLoadingViewController instance]showWithText:@"Loading"];
//        [[OKUserManager instance] updateDataSharingSettingsWithProcID:self.procID userID:[OKUserManager instance].currentUser.identifier isSharing:@"no" handler:^(NSString* error){
//            [[OKLoadingViewController instance]hide];
//            OKCase *selCase = self.cases[indexPath.row];
//            [OKCaseManager instance].selectedCase = selCase;
//            _followUp = selCase.followup;
//            _stonesCount = selCase.stonesCount;
//        }];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([_procID isEqualToString:@"9"] && [segue.identifier isEqualToString:@"fromCasesToReminder"]) {
        OKSelectTimePointViewController *timePoint = (OKSelectTimePointViewController*)segue.destinationViewController;
        timePoint.procID = _procID;
    }else{
        if([segue.identifier isEqualToString:@"fromCasesToReminder"]){
            OKCaseListViewController *caseVC = (OKCaseListViewController*)segue.destinationViewController;
            caseVC.procID = _procID;
            caseVC.detailID = _detailID;
        }else if ([segue.identifier isEqualToString:@"selectTimepoint"]){
            OKSelectTimePointViewController *timePoint = (OKSelectTimePointViewController*)segue.destinationViewController;
            timePoint.procID = _procID;
            timePoint.followUp = _followUp;
            timePoint.stonesCount = _stonesCount;
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)goToUsersListTapped:(id)sender {
}
@end
