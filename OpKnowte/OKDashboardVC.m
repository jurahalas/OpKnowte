//
//  OKDashboardVC.m
//  OpKnowte
//
//  Created by Apple on 22.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKDashboardVC.h"
#import "OKDashboardTableViewCell.h"
#import "OKAppDelegate.h"


@interface OKDashboardVC ()

@property (strong, nonatomic) IBOutlet UITableView *dashboardTableView;
@property (strong, nonatomic) IBOutlet UIView *userView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation OKDashboardVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    _dashboardTableView.backgroundColor = [UIColor clearColor];
    [self.navigationController setNavigationBarHidden:YES];
    self.dashboardTableView.dataSource = self;
    self.dashboardTableView.delegate = self;
    _dashboardTableView.frame = CGRectMake(_dashboardTableView.frame.origin.x, _dashboardTableView.frame.origin.y, _dashboardTableView.frame.size.width, (_dashboardTableView.frame.size.height - 60.f));
    _userView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dashboardBG"]];;
    [self addBottomTabBar];
    [self.dashboardTableView reloadData];
}


#pragma mark - IBActions

#pragma mark - Table View methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"dashboardCell";
    OKDashboardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKDashboardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSMutableArray *dataTitleArray = [[NSMutableArray alloc] initWithObjects:
                                      @"Surgical Data Capture",
                                      @"Surgical Performance Data",
                                      @"Surgical Logs", nil];
    
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithObjects:
                                  [UIImage imageNamed:@"toc.png"],
                                  [UIImage imageNamed:@"magnifier.png"],
                                  [UIImage imageNamed:@"knife.png"], nil];
    
    cell.cellName.text = [dataTitleArray objectAtIndex:indexPath.row];
    cell.cellImage.image = [imageArray objectAtIndex:indexPath.row];
    [cell setCellBGImageLight:indexPath.row];

    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
