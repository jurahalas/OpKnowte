//
//  OKProcedureDetailSummaryViewController.m
//  OpKnowte
//
//  Created by Eugene on 4/18/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureDetailSummaryViewController.h"
#import "OKOngoingData.h"
#import <SVPullToRefresh.h>
#import "OKOngoingClinicalViewController.h"
#import "OKSettingsViewController.h"
#import "OKDashboardVC.h"
#import "OKInfoViewController.h"

@interface OKProcedureDetailSummaryViewController () <UITableViewDelegate, UITableViewDataSource,OKBaseVCDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSOrderedDictionary *tableDict;
@property (strong, nonatomic) SVPullToRefreshView *pullToRefreshView;

@end

@implementation OKProcedureDetailSummaryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self draw];
    
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, (self.tableView.frame.size.height - 60.f));
    
    [self setupPullToRefresh];
    if (!IS_IOS7) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
}

-(void)draw{
    OKBottomTabBarView *bottomTabBarView = [[OKBottomTabBarView alloc] init];
    bottomTabBarView.delegate = self;
    [self.view addSubview:bottomTabBarView];
    [bottomTabBarView draw];
}

-(void) goToSettingsVC{
    
    if(![self.restorationIdentifier isEqualToString:@"settings"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        OKSettingsViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"settings"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
-(void) goToDashboard {
    if(![self.restorationIdentifier isEqualToString:@"dashboard"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        OKDashboardVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"dashboard"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)goToInfoVC{
    if(![self.restorationIdentifier isEqualToString:@"info"]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        OKInfoViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"info"];
        vc.cameFromVC = @"LogoTBButton";
        [self.navigationController pushViewController:vc animated:YES];
    }
}
//- (BOOL)navBar{
//    return self.navigationController.navigationBarHidden;
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.detailPeriod == OKProcedureSummaryDetailTwoWeeks)
        self.tableDict = self.ongoingData.twoWeeksItems;
    else
        self.tableDict = self.ongoingData.sixWeeksItems;
    [self.tableView reloadData];
}


-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width +27, [UIImage imageNamed:@"back"].size.height );
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
}


-(void)setupPullToRefresh
{
    [self.tableView addPullToRefreshWithActionHandler:^{
        [self performSegueWithIdentifier:@"ongoingClinical" sender:nil];
        [self.tableView.pullToRefreshView stopAnimating];
    }];
    [self.tableView.pullToRefreshView setTitle:@"Pull down to edit" forState:SVPullToRefreshStateAll];
    [self.tableView.pullToRefreshView setSubtitle:nil forState:SVPullToRefreshStateAll];
    [self.tableView.pullToRefreshView setTextColor:[UIColor whiteColor]];
}

#pragma mark - Table View methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableDict.allKeys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"procedureDetailSummaryCell";
    OKProcedureDetailSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKProcedureDetailSummaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *key = self.tableDict.allKeys[indexPath.row];
    cell.procedureKeyLabel.text = key;
    cell.procedureValueLabel.text = [self.tableDict objectForKey:key];
    return cell;
}

#pragma mark - prepare for segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ongoingClinical"]){
        OKOngoingClinicalViewController *ongVC = (OKOngoingClinicalViewController*)segue.destinationViewController;
        ongVC.ongoingData = self.ongoingData;
        ongVC.detailPeriod = self.detailPeriod;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
