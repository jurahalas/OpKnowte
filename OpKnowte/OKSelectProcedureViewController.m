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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OKSelectProcedureCell *cell = (OKSelectProcedureCell *)[_selectProcedureTableView cellForRowAtIndexPath:indexPath];
    int procID = 0;
    if ([cell.procedureLabel.text isEqualToString:@"Shockwave Lithotripsy"]) {
        procID = 10;
    }
    if ([cell.procedureLabel.text isEqualToString:@"Laparoscopic Robotic Partial Nephrectomy"]) {
       procID = 2;
    }
    if ([cell.procedureLabel.text isEqualToString:@"Insertion of Penile Prosthesis"]) {
        procID = 9;
    }
    if ([cell.procedureLabel.text isEqualToString:@"Laparoscopic Robotic Radical Prostatectomy"]) {
        procID = 1;
    }
    
    
    
    if ([_cameFromVC isEqualToString:@"DataSharingVC"]) {
        [self performSegueWithIdentifier:@"fromSelectProcToDataShar" sender:[NSString stringWithFormat:@"%d", procID]];
    } else if ([_cameFromVC isEqualToString:@"AccessSettingsVC"] ){
        [self performSegueWithIdentifier:@"fromSelectProcToAccessSettings" sender:[NSString stringWithFormat:@"%d", procID]];
    }else if ([_cameFromVC isEqualToString:@"ReminderSettings"] ){
        [self performSegueWithIdentifier:@"fromProceduresToCases" sender:[NSString stringWithFormat:@"%d", procID]];
    } else if ([_cameFromVC isEqualToString:@"EditProcTemplateVC"] ){
        [self performSegueWithIdentifier:@"fromSelectProcToEditTemplate" sender:[NSString stringWithFormat:@"%d", procID]];
    }else if ([_cameFromVC isEqualToString:@"SurgicalLogsVC"]){
        [self performSegueWithIdentifier:@"fromSelectProcToSurgicalLogs" sender:[NSString stringWithFormat:@"%d", procID]];
    }else if([_cameFromVC isEqualToString:@"OKPerformanceVC"]){
        [self performSegueWithIdentifier:@"fromSelectProcToOperativeData" sender:[NSString stringWithFormat:@"%d",procID]];
    } else {
        if ([cell.procedureLabel.text isEqualToString:@"Shockwave Lithotripsy"]) {
            OKShockwaveLithotripsyVC *vc = [[OKShockwaveLithotripsyVC alloc] init];
            vc.procedureID = procID;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([cell.procedureLabel.text isEqualToString:@"Laparoscopic Robotic Partial Nephrectomy"]) {
            OKLRPartialNephrectomyVC *vc = [[OKLRPartialNephrectomyVC alloc] init];
            vc.procedureID = procID;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([cell.procedureLabel.text isEqualToString:@"Insertion of Penile Prosthesis"]) {
            OKPenileProsthesisVC *vc = [[OKPenileProsthesisVC alloc] init];
            vc.procedureID = procID;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([cell.procedureLabel.text isEqualToString:@"Laparoscopic Robotic Radical Prostatectomy"]) {
            OKLRRadicalProstatectomyVC *vc = [[OKLRRadicalProstatectomyVC alloc] init];
            vc.procedureID = procID;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


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
    cell.procedureLabel.text = procedure.procedureText;
    [cell setCellBGImageLight:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    return cell;
    
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
    } else if ([segue.identifier isEqualToString:@"fromProceduresToCases"]){
        OKSelectCaseViewController *reminderVC = (OKSelectCaseViewController*)segue.destinationViewController;
        reminderVC.procID = sender;
    } else if ([segue.identifier isEqualToString:@"fromSelectProcToOperativeData"]){
        OKIntraOperativeDataViewController * operativeData = (OKIntraOperativeDataViewController *)segue.destinationViewController;
        operativeData.procID = sender;
        int i = [sender intValue];
        OKProcedureModel *tappedProc = _allProcArray[i-1];
        operativeData.procTitle = tappedProc.procedureText;
    }
}


@end
