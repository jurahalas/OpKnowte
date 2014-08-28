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
#import "OKUserListVC.h"

@interface OKCaseListViewController ()<UITableViewDelegate, UITableViewDataSource, OKCaseDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *goToListView;
@property (strong, nonatomic) IBOutlet UIButton *goToUserListButton;
- (IBAction)goToUsersListTapped:(id)sender;

@property (strong, nonatomic) NSArray *cases;
@property (strong, nonatomic) NSMutableArray *caseArray;

@end

@implementation OKCaseListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self setupData];
    [self addLeftButtonToNavbar];

    self.goToListView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradientBG"]];
    self.goToUserListButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    self.goToUserListButton.layer.cornerRadius = 14;
    
    self.caseArray = [[NSMutableArray alloc]init];
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
    return self.cases.count +1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"selectCase";
    OKCaseListTableViewCell *cell =[[OKCaseListTableViewCell alloc]init];
    static NSString *FakeCellIdentifier = @"FakeCell";
    OKFakeTableViewCell *FakeCell = [[OKFakeTableViewCell alloc] init];
    
    if (indexPath.row < self.cases.count) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        OKCase *selCase = self.cases[indexPath.row];
        cell.caseModel = selCase;
        cell.caseName.text = [NSString stringWithFormat:@"%i. %@",indexPath.row+1, selCase.patientName];
        [cell setCellBGImageLight:indexPath.row];
        return cell;
    } else {
        FakeCell = [tableView dequeueReusableCellWithIdentifier:FakeCellIdentifier forIndexPath:indexPath];
        return FakeCell;
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToUsersList"]) {
        OKUserListVC *usersVC = (OKUserListVC*)segue.destinationViewController;
        usersVC.procID = self.procID;
        usersVC.detailsArray = self.caseArray;
    }
}


- (IBAction)goToUsersListTapped:(id)sender
{
    if (self.caseArray.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"You must choose at least one case" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        [self performSegueWithIdentifier:@"goToUsersList" sender:nil];
    }
}


-(void)addCaseToArray:(OKCase *)contact
{
    [self.caseArray addObject:contact.caseID];
}


-(void)deleteCaseFromArray:(OKCase *)contact
{
    for (int i = 0; i<self.caseArray.count; i++) {
        if ([[self.caseArray objectAtIndex:i]isEqualToString:contact.caseID]) {
            [self.caseArray removeObjectAtIndex:i];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
