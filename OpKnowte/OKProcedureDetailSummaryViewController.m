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

@interface OKProcedureDetailSummaryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSOrderedDictionary *tableDict;
@property (strong, nonatomic) SVPullToRefreshView *pullToRefreshView;
@property (nonatomic) float savedScrollPosition;

@end

@implementation OKProcedureDetailSummaryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    self.tableView.backgroundColor = [UIColor clearColor];
    

    
    [self addBottomTabBar];
    
    [self setupPullToRefresh];
    
    if (IS_IOS7){
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y+64.f, self.tableView.frame.size.width, (self.tableView.frame.size.height-124.f));
    }else{
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, (self.tableView.frame.size.height-60.f));
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.detailPeriod == OKProcedureSummaryDetailTwoWeeks){
        self.tableDict = self.ongoingData.twoWeeksItems;
    }else{
        self.tableDict = self.ongoingData.sixWeeksItems;
    }
    [self.tableView reloadData];
//    NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:0];
  //  [_tableView scrollToRowAtIndexPath:index                      atScrollPosition:UITableViewScrollPositionTop animated:YES];
}


-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width +27, [UIImage imageNamed:@"back"].size.height );
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
}

-(void)backButton{
    [self.navigationController popViewControllerAnimated:YES];
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
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (self.tableView.contentOffset.y>-64.f){
//        //_tableView.showsPullToRefresh = NO;
//        _pullToRefreshView.hidden = YES;
//    }
//    else if (self.tableView.contentOffset.y == -64.f) {
//        _tableView.showsPullToRefresh = NO;
//    } else {
//        _tableView.showsPullToRefresh = YES;
//
//    }
//}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"pipiska");
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
