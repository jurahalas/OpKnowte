//
//  OKSelectCaseViewController.m
//  OpKnowte
//
//  Created by Olegek on 25.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSelectCaseViewController.h"
#import "OKSelectCaseTableViewCell.h"
#import "OKProceduresManager.h"

@interface OKSelectCaseViewController ()

@property (strong, nonatomic) IBOutlet UITableView *selectCase;
@property (strong, nonatomic) NSMutableArray *casesArray;

@end

@implementation OKSelectCaseViewController
@synthesize selectCase;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    selectCase.backgroundColor = [UIColor clearColor];
    self.selectCase.dataSource = self;
    self.selectCase.delegate = self;
    selectCase.frame = CGRectMake(selectCase.frame.origin.x, selectCase.frame.origin.y, selectCase.frame.size.width, (selectCase.frame.size.height - 57.f));
    
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    OKProceduresManager *procedureManager = [OKProceduresManager instance];
    [procedureManager getCasesListWithProcedureID:_procID andSurgeonID:[OKUserManager instance].currentUser.identifier handler:^(NSString *errorMsg, NSMutableArray *cases) {
        NSLog(@"Error %@", errorMsg);
        _casesArray = cases;
        [self.selectCase reloadData];
        [[OKLoadingViewController instance] hide];
    }];
    [self addBottomTabBar];
}


#pragma mark IBAction metods
- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark Table View methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _casesArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"selectCase";
    OKSelectCaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKSelectCaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    OKCase *caseModel = (OKCase*)self.casesArray[indexPath.row];
    _detailID = caseModel.detailID;
    cell.caseName.text = caseModel.patientName;
    cell.dataLable.text = caseModel.dateOfService;
    [cell setCellBGImageLight:indexPath.row];
    NSLog(@"%@", _detailID);
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"fromCasesToReminder" sender:[NSString stringWithFormat:@"%@", _procID]];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"fromCasesToReminder"]){
        OKSelectCaseViewController *contactVC = (OKSelectCaseViewController*)segue.destinationViewController;
        contactVC.procID = _procID;
        contactVC.detailID = _detailID;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
