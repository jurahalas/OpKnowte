//
//  OKSelectProcedureViewController.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/15/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSelectProcedureViewController.h"
#import "OKProceduresManager.h"
#import "OKProcedureModel.h"
#import "OKLoadingViewController.h"
#import "OKShockwaveLithotripsyVC.h"
#import "OKLRPartialNephrectomyVC.h"
#import "OKPenileProsthesisVC.h"
#import "OKLRRadicalProstatectomyVC.h"
#import "OKDataSharingViewController.h"
#import "OKReminderVC.h"
#import "OKSelectCaseViewController.h"

#import "OKTemplateViewController.h"
#import "OKAccessConfirmViewController.h"
#import "OKAccessSettingsViewController.h"
#import "OKSurgicalLogsVC.h"
#import "OKIntraOperativeDataViewController.h"
#import "OKFollowUpDataVC.h"


@interface OKSelectProcedureViewController ()
@property (strong, nonatomic) IBOutlet UITableView *selectProcedureTableView;
@property (strong, nonatomic) NSMutableArray *procArray;
@property (strong, nonatomic) NSArray *allProcArray;
@end

@implementation OKSelectProcedureViewController


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
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    _selectProcedureTableView.backgroundColor = [UIColor clearColor];
    
    self.selectProcedureTableView.dataSource = self;
    self.selectProcedureTableView.delegate = self;
    
    _selectProcedureTableView.frame = CGRectMake(_selectProcedureTableView.frame.origin.x, _selectProcedureTableView.frame.origin.y, _selectProcedureTableView.frame.size.width, (_selectProcedureTableView.frame.size.height - 57.f));
    [self addBottomTabBar];
  
    [[OKLoadingViewController instance] showWithText:@"Loading..."];

    OKProceduresManager *procedureManager = [OKProceduresManager instance];
    [procedureManager getAllProceduresWithHandler:^(NSString* error, NSMutableArray* proceduresArray){
        NSLog(@"Error - %@", error);
        
        _procArray = proceduresArray;
        _allProcArray = [proceduresArray copy];
        for (int i = 0; i<_procArray.count; i++) {
            OKProcedureModel *proc = _procArray[i];
            
            if (!proc.procedureActive) {
                [_procArray removeObjectAtIndex:i];
                i--;
            }
        }
        [self.selectProcedureTableView reloadData];
        
        [[OKLoadingViewController instance] hide];
    }];
    if (!IS_IOS7) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
	// Do any additional setup after loading the view.
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - IBActions
- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table View methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _procArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"procedureCell";
    OKSelectProcedureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKSelectProcedureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    OKProcedureModel *procedure = (OKProcedureModel*)self.procArray[indexPath.row];

        cell.procedureLabel.text = procedure.procedureShortName;
        [cell setCellBGImageLight:indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    OKProcedureModel *proc = _procArray[indexPath.row];
    [OKProceduresManager instance].selectedProcedure = proc;
    
    OKSelectProcedureCell *cell = (OKSelectProcedureCell *)[_selectProcedureTableView cellForRowAtIndexPath:indexPath];
    NSInteger procID = [proc.identifier integerValue];
    NSString *procName = proc.procedureShortName;
    if ([_cameFromVC isEqualToString:@"DataSharingVC"]) {
        [self performSegueWithIdentifier:@"fromSelectProcToDataShar" sender:[NSString stringWithFormat:@"%d", procID]];
        
    } else if ([_cameFromVC isEqualToString:@"AccessSettingsVC"] ){
        [self performSegueWithIdentifier:@"fromSelectProcToAccessSettings" sender:[NSString stringWithFormat:@"%d", procID]];
        
    }else if ([_cameFromVC isEqualToString:@"ongoing"] || !_cameFromVC){
        [self performSegueWithIdentifier:@"fromProceduresToCases" sender:[NSString stringWithFormat:@"%d", procID]];
        
    }else if ([_cameFromVC isEqualToString:@"ReminderSettings"]){
        [self performSegueWithIdentifier:@"toReminder" sender:[NSString stringWithFormat:@"%d", procID]];
        
    } else if ([_cameFromVC isEqualToString:@"EditProcTemplateVC"] ){
        [self performSegueWithIdentifier:@"fromSelectProcToEditTemplate" sender:[NSString stringWithFormat:@"%d", procID]];
        
    }else if ([_cameFromVC isEqualToString:@"SurgicalLogsVC"]){
        [self performSegueWithIdentifier:@"fromSelectProcToSurgicalLogs" sender:[NSString stringWithFormat:@"%d", procID]];
        
    }else if ([_cameFromVC isEqualToString:@"FollowUpDataVC"]){
        [self performSegueWithIdentifier:@"fromSelectProcToFollowUpData" sender:[NSString stringWithFormat:@"%d", procID]];
        
    }
    
    
    
    else if ([_cameFromVC isEqualToString:@"OKPerformanceVC"]){
        [self performSegueWithIdentifier:@"fromSelectProcToOperativeData" sender:[NSString stringWithFormat:@"%d", procID]];
    }
    
    
    
    else if ([_cameFromVC isEqualToString:@"ImmediatePostOperative"]){
        id vc = nil;
        if ([cell.procedureLabel.text isEqualToString:@"Shockwave Lithotripsy"]) {
            vc = [[OKShockwaveLithotripsyVC alloc] init];
        }else
        if ([cell.procedureLabel.text isEqualToString:@"Robotic Partial Nephrectomy"]) {
            vc = [[OKLRPartialNephrectomyVC alloc] init];
        }else
        if ([cell.procedureLabel.text isEqualToString:@"Insertion of Penile Prosthesis"]) {
            vc = [[OKPenileProsthesisVC alloc] init];
        }else
        if ([cell.procedureLabel.text isEqualToString:@"Robotic Radical Prostatectomy"]) {
            vc = [[OKLRRadicalProstatectomyVC alloc] init];
        }
        [vc setValue:@(procID) forKey:@"procedureID"];
        [vc setValue:procName forKey:@"procedureName"];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [self performSegueWithIdentifier:@"fromSelectProcToOngoingClinical" sender:nil];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"fromSelectProcToDataShar"]){
        OKDataSharingViewController *sharVC = (OKDataSharingViewController*)segue.destinationViewController;
        sharVC.procID = sender;
        
    } else if ([segue.identifier isEqualToString:@"fromSelectProcToAccessSettings"]){
       OKAccessConfirmViewController *sharVC = (OKAccessConfirmViewController*)segue.destinationViewController;
        sharVC.procID = sender;
        
    }  else if ([segue.identifier isEqualToString:@"fromSelectProcToEditTemplate"]){
        OKTemplateViewController *sharVC = (OKTemplateViewController*)segue.destinationViewController;
        sharVC.procID = sender;
        
    } else if ([segue.identifier isEqualToString:@"fromSelectProcToSurgicalLogs"]){
        OKSurgicalLogsVC *sharVC = (OKSurgicalLogsVC*)segue.destinationViewController;
        sharVC.procID = sender;
        int i = [sender  intValue] ;
        OKProcedureModel *tappedProc =_allProcArray[i-1];
        sharVC.procTitle = tappedProc.procedureText;
        
    }else if ([segue.identifier isEqualToString:@"toReminder"]){
        OKSelectCaseViewController *reminderVC = (OKSelectCaseViewController*)segue.destinationViewController;
        reminderVC.procID = sender;
        reminderVC.cameFromVC = @"Reminder";
        
    }else if ([segue.identifier isEqualToString:@"fromProceduresToCases"]){
        OKSelectCaseViewController *reminderVC = (OKSelectCaseViewController*)segue.destinationViewController;
        reminderVC.procID = sender;
        
    }else if ([segue.identifier isEqualToString:@"fromSelectProcToOperativeData"]){
        OKIntraOperativeDataViewController * operativeData = (OKIntraOperativeDataViewController *)segue.destinationViewController;
        operativeData.procID = sender;
        int i = [sender intValue];
        OKProcedureModel *tappedProc = _allProcArray[i-1];
        operativeData.procTitle = tappedProc.procedureText;
        
    } else if ([segue.identifier isEqualToString:@"fromSelectProcToFollowUpData"]){
        OKFollowUpDataVC *reminderVC = (OKFollowUpDataVC*)segue.destinationViewController;
        reminderVC.procID = sender;
        int i = [sender  intValue] ;
        OKProcedureModel *tappedProc =_allProcArray[i-1];
        reminderVC.procTitle = tappedProc.procedureText;
    }
}


@end
