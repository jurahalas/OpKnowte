//
//  OKSelectCaseViewController.m
//  OpKnowte
//
//  Created by Olegek on 25.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSelectCaseViewController.h"
#import "OKSelectCaseTableViewCell.h"
#import "OKCaseManager.h"
#import "OKUserManager.h"
#import "OKCase.h"
#import "OKProceduresManager.h"
#import "OKProcedureModel.h"
#import "OKTemplateManager.h"
#import "OKSelectTimePointViewController.h"

@interface OKSelectCaseViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *cases;

@end

@implementation OKSelectCaseViewController
@synthesize tableView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isReminderSetting = NO;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, (tableView.frame.size.height - 57.f));
    [self addBottomTabBar];
    [self setupData];
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


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


-(void)setupData
{
    [[OKLoadingViewController instance]showWithText:@"Loading"];
    if (self.fromSettings) {
        [[OKTemplateManager instance]getTemplate:[OKUserManager instance].currentUser.identifier withProcedureID:[OKProceduresManager instance].selectedProcedure
         .identifier handler:^(NSString *errorMg, OKTemplate *templateObj) {             [[OKLoadingViewController instance]hide];
         }];
    }else {
        [[OKCaseManager instance]getCaseListForProcedureWithID:[OKProceduresManager instance].selectedProcedure.identifier surgeonID:[OKUserManager instance].currentUser.identifier handler:^(NSString *errorMsg, NSArray *cases) {
            [[OKLoadingViewController instance]hide];
            if(!errorMsg){
                self.cases = [cases sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"DOS" ascending:YES]]];
                [self.tableView reloadData];
            }
        }];
    }
}


#pragma mark IBAction metods
- (IBAction)backButton:(id)sender
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
    OKSelectCaseTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKSelectCaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    OKCase *selCase = self.cases[indexPath.row];
    
    if(self.fromSettings){
        cell.textLabel.text = selCase.patientName;
    }else{
        if ([_procID isEqualToString:@"9"]) {
            cell.caseName.text = [NSString stringWithFormat:@"%i. %@",indexPath.row+1, selCase.patientNameNineProc];;
        }else{
            cell.caseName.text = [NSString stringWithFormat:@"%i. %@",indexPath.row+1, selCase.patientName];;

        }
    }
    cell.dataLable.text = selCase.dateOfServiceString;
    cell.selCase = selCase;
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.isReminderSetting) {
        [self performSegueWithIdentifier:@"fromCasesToReminder" sender:[NSString stringWithFormat:@"%@", _procID]];

    }else{
        [[OKLoadingViewController instance]showWithText:@"Loading"];
        [[OKUserManager instance] updateDataSharingSettingsWithProcID:self.procID userID:[OKUserManager instance].currentUser.identifier isSharing:@"no" handler:^(NSString* error){
            [[OKLoadingViewController instance]hide];
            OKCase *selCase = self.cases[indexPath.row];
            [OKCaseManager instance].selectedCase = selCase;
            _followUp = selCase.followup;
            _stonesCount = selCase.stonesCount;
            if ([_cameFromVC isEqualToString:@"Reminder"])
                [self performSegueWithIdentifier:@"fromCasesToReminder" sender:nil];
            else
                [self performSegueWithIdentifier:@"selectTimepoint" sender:nil];
        }];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([_procID isEqualToString:@"9"] && [segue.identifier isEqualToString:@"fromCasesToReminder"]) {
        OKSelectTimePointViewController *timePoint = (OKSelectTimePointViewController*)segue.destinationViewController;
        timePoint.procID = _procID;
    }else{
        if([segue.identifier isEqualToString:@"fromCasesToReminder"]){
            OKSelectCaseViewController *caseVC = (OKSelectCaseViewController*)segue.destinationViewController;
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

@end