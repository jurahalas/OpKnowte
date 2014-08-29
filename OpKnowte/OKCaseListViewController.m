//
//  OKCaseListViewController.m
//  OpKnowte
//
//  Created by Olegek on 28.08.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKCaseListViewController.h"
#import "OKCaseListTableViewCell.h"
#import "OKCaseManager.h"
#import "OKUserManager.h"
#import "OKCase.h"
#import "OKProceduresManager.h"
#import "OKProcedureModel.h"
#import "OKTemplateManager.h"
#import "OKSelectTimePointViewController.h"
#import "OKUserListVC.h"

@interface OKCaseListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *cases;
@property (strong, nonatomic) NSString *caseID;
@property (strong, nonatomic) NSMutableArray * usersIDsArray;

@end

@implementation OKCaseListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, (self.tableView.frame.size.height - 50.f));
    [self setupData];
    [self addLeftButtonToNavbar];
    [self addBottomTabBar];
    self.caseID = [[NSString alloc]init];
    self.usersIDsArray = [[NSMutableArray alloc]init];
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
    [self setupData];
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
    OKCaseListTableViewCell *cell =[[OKCaseListTableViewCell alloc]init];
    cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    OKCase *selCase = self.cases[indexPath.row];
    if ([_procID isEqualToString:@"9"]) {
        cell.caseName.text = [NSString stringWithFormat:@"%i. %@",indexPath.row+1, selCase.patientNameNineProc];;
    } else {
        cell.caseName.text = [NSString stringWithFormat:@"%i. %@",indexPath.row+1, selCase.patientName];
    }
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    OKCase *selCase = self.cases[indexPath.row];
    NSString *usersID = selCase.usersID;
    self.usersIDsArray = [usersID componentsSeparatedByString:@","];
    self.caseID = selCase.caseID;
    [self performSegueWithIdentifier:@"goToUsersList" sender:nil];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToUsersList"]) {
        OKUserListVC *usersVC = (OKUserListVC*)segue.destinationViewController;
        usersVC.procID = self.procID;
        usersVC.caseID = self.caseID;
        usersVC.shareUsersIDs = [[NSMutableArray alloc]init];
        usersVC.shareUsersIDs = self.usersIDsArray;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
