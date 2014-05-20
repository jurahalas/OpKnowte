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
#import "OKSelectFUDVariablesVC.h"

@interface OKSelectTimePointViewController ()
@property (strong, nonatomic) IBOutlet UITableView *selectTimePointTableView;
@property (strong, nonatomic) NSMutableArray *timePointsArray;
@property (nonatomic) int timepointID;
@end

@implementation OKSelectTimePointViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    _selectTimePointTableView.backgroundColor = [UIColor clearColor];
    
    self.selectTimePointTableView.dataSource = self;
    self.selectTimePointTableView.delegate = self;
    
    _selectTimePointTableView.frame = CGRectMake(_selectTimePointTableView.frame.origin.x, _selectTimePointTableView.frame.origin.y, _selectTimePointTableView.frame.size.width, (_selectTimePointTableView.frame.size.height - 50.f));
    [self addBottomTabBar];
    
    
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    OKTimePointsManager *timePointsManager = [OKTimePointsManager instance];
    [timePointsManager getAllTimePointsWithHandler:     ^(NSString* error, NSMutableArray* timePointsArray){
        NSLog(@"Error - %@", error);
        
        _timePointsArray = timePointsArray;
        [self.selectTimePointTableView reloadData];
        [[OKLoadingViewController instance] hide];
    }];
     
     

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
    cell.timePointLabel.text = timePoint.timePointName;
    [cell setCellBGImageLight:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cameFromVC = [[NSString alloc] init];
    if (indexPath.row == 0) {
        cameFromVC = @"weeks";
    }else if (indexPath.row >0 && indexPath.row <11){
        cameFromVC = @"months";
    }
    _timepointID = indexPath.row+1;
    if([_cameFromVC isEqualToString:@"FollowUpData"]){
        [self performSegueWithIdentifier:@"fromSelectTimeToSelectVariables" sender:cameFromVC];
        
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
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
