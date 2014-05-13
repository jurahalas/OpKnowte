//
//  UCSelectProcedureViewController.m
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/12/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSelectProcedureViewController.h"
#import "CONSTANTS.h"
#import "UCLRPNPageOneViewController.h"
#import "UCProcedureModel.h"
#import "UCSettingsViewController.h"
#import "UCSettingDataSharingViewController.h"
#import "UCSettingReminderSettingsViewController.h"
#import "UCAccessSettingViewController.h"
#import "UCSettingContactsViewController.h"
#import "UCSettingInstitutionsViewController.h"
#import "UCSelectCaseListViewController.h"
#import "UCEditProcedureTemplateViewController.h"
#import "UCSelectAccessContactsViewController.h"

#import "UCUtility.h"

#import "OKUserManager.h"
#import "OKProceduresManager.h"

@interface UCSelectProcedureViewController ()

@end

int selectedIndex;

@implementation UCSelectProcedureViewController

@synthesize no_of_setting;
@synthesize procedures, accessContacts, home,fromSettings, fromOngoingClinical;
@synthesize procedureTableView;
@synthesize filter, isFilter,surgeonFilter,isSurgeonFilter,nationalFilter,isNationalFilter;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.isFilter = NO;
    }
    return self;
}

- (IBAction)homeButtonPressed:(id)sender {
    if (DELEGATE.isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    if(fromOngoingClinical)
    {
        UCSelectCaseListViewController *selectProcedure;
        if(IS_IPHONE_5) {
            selectProcedure = [[UCSelectCaseListViewController alloc] initWithNibName:@"UCSelectCaseListViewController" bundle:nil];
        }
        else {
            selectProcedure = [[UCSelectCaseListViewController alloc] initWithNibName:@"UCSelectCaseListViewController_iPhone" bundle:nil];
        }
        [self.navigationController pushViewController:selectProcedure animated:NO];
    }
    else
    {
        [self forwardButtonPressed];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UCUtility showBlockView];
    [OKProceduresManager doProceduresRequest:^(NSString *errorMsg, id responseJSON) {
        [UCUtility hideBlockView];
        if(!errorMsg)
           [self proceduresSucceded:responseJSON];
        else
            [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
    }];
    selectedIndex = 0;
}


- (void)proceduresSucceded:(id)response
{
    if (self.procedures == nil) {
        self.procedures = [[NSMutableArray alloc] init];
    }
    self.procedures = [UCUtility getProceduresList:response];
    
    [procedureTableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.procedures count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [cell.textLabel setText:[[self.procedures objectAtIndex:indexPath.row] procedureText]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [OKProceduresManager instance].selectedProcedure = [self.procedures objectAtIndex:indexPath.row];
    selectedIndex = indexPath.row;
    
    if (isFilter == YES) {
        
        self.filter.procedureID = [[self.procedures objectAtIndex:indexPath.row] procedureID];
        [self.filter.procedureLbl setText:[[self.procedures objectAtIndex:indexPath.row] procedureText]];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if(isSurgeonFilter){
        self.surgeonFilter.procedureID = [[self.procedures objectAtIndex:indexPath.row] procedureID];
        [self.surgeonFilter.procedureLbl setText:[[self.procedures objectAtIndex:indexPath.row] procedureText]];
        [self.navigationController popViewControllerAnimated:YES];
    
    
    }else if(isNationalFilter){
        self.nationalFilter.procedureID = [[self.procedures objectAtIndex:indexPath.row] procedureID];
        [self.nationalFilter.procedureLbl setText:[[self.procedures objectAtIndex:indexPath.row] procedureText]];
        [self.navigationController popViewControllerAnimated:YES];

    
    }else if(fromSettings) {
        
        switch (no_of_setting) {
            case 1: {
                UCSettingDataSharingViewController * obj =[[UCSettingDataSharingViewController alloc]init];
                [self.navigationController pushViewController:obj animated:YES];
            }
            break;
                
            case 2: {
                UCSelectCaseListViewController *controller = [[UCSelectCaseListViewController alloc] initWithNibName:@"UCSelectCaseListViewController" bundle:nil];
                controller.isReminderSetting = YES;
                //UCSettingReminderSettingsViewController *controller = [[UCSettingReminderSettingsViewController alloc] initWithNibName:@"UCSettingReminderSettingsViewController" bundle:nil];
                [self.navigationController pushViewController:controller animated:YES];
            }
            break;
            
            case 3: {
                UCAccessSettingViewController *obj = [[UCAccessSettingViewController alloc] init];
                
                [self.navigationController pushViewController:obj animated:YES];
            }
            break;
                
            case 4: {
                UCSettingContactsViewController *obj = [[UCSettingContactsViewController alloc] init];
                [self.navigationController pushViewController:obj animated:YES];
            }
            break;
                
            case 5: {
                UCSettingInstitutionsViewController *obj = [[UCSettingInstitutionsViewController alloc] init];
                UCProcdureModel *model = [self.procedures objectAtIndex:indexPath.row];
                obj.selectedProcedureID = [model procedureID];
                [OKProceduresManager instance].selectedProcedure.procedureID = [model procedureID];
                [self.navigationController pushViewController:obj animated:YES];
            }
            break;
                
            case 6: {
                
                [OKProceduresManager instance].selectedProcedure = [self.procedures objectAtIndex:indexPath.row];
                
                UCEditProcedureTemplateViewController *selectProcedure;
                
                selectProcedure = [[UCEditProcedureTemplateViewController alloc] initWithNibName:@"UCEditProcedureTemplateViewController" bundle:nil];
                
                [self.navigationController pushViewController:selectProcedure animated:NO];
            }
            break;
            default:
            break;
        }
    }
    else {
        
        if (indexPath.row == 1 || indexPath.row == 9) {
            
            [UCUtility showBlockView];
            [[OKUserManager instance]getUserAccess:[OKProceduresManager instance].selectedProcedure.procedureID handler:^(NSString *errorMsg, id responseJSON) {
                [UCUtility hideBlockView];
                if(!errorMsg)
                   [self userAccessSucceded:responseJSON];
                else
                    [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
            }];
        }
        else {
            [UCUtility showInfoAlertView:@"Error" withMessage:@"No default template found"];
        }
    }
}


-(void) updateCell:(int)index
{
    UCProcedureModel *model = (UCProcedureModel*)[self.procedures objectAtIndex:6];
    model.isSelected = true;
}

-(BOOL) checkIfSelected {
    UCProcedureModel *model;
    for (int i =0; i<[self.procedures count]; i++)
    {
        model = (UCProcedureModel*)[self.procedures objectAtIndex:i];
        if (model.isSelected)
            return true;
    }
    return false;
}

- (void)forwardButtonPressed {
    
    switch (selectedIndex) {
        case 0:
            break;
        case 1:{
            UCLRPNPageOneViewController *selectProcedure;
            if(IS_IPHONE_5) {
                selectProcedure = [[UCLRPNPageOneViewController alloc] initWithNibName:@"UCLRPNPageOneViewController_iPhone" bundle:nil];
            }
            else {
                selectProcedure = [[UCLRPNPageOneViewController alloc] initWithNibName:@"UCLRPNPageOneViewController" bundle:nil];
            }
            
            selectProcedure.parentModel.var_procedureName = [OKProceduresManager instance].selectedProcedure.procedureText;
            
            [self.navigationController pushViewController:selectProcedure animated:YES];
            selectProcedure = nil;
        }
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        case 7:
            break;
        case 8:
            break;
        case 9:{
            UCLRPNPageOneViewController *selectProcedure;
            if(IS_IPHONE_5) {
                selectProcedure = [[UCLRPNPageOneViewController alloc] initWithNibName:@"UCLRPNPageOneViewController_iPhone" bundle:nil];
            }
            else {
                selectProcedure = [[UCLRPNPageOneViewController alloc] initWithNibName:@"UCLRPNPageOneViewController" bundle:nil];
            }
            
            selectProcedure.parentModel.var_procedureName = [OKProceduresManager instance].selectedProcedure.procedureText;
            
            [self.navigationController pushViewController:selectProcedure animated:YES];
            selectProcedure = nil;
        }
            break;
        case 10:
            break;
        case 11:
            break;
        default:
            break;
    }
     
     
}


- (void)userAccessSucceded:(id)response
{
    id result = [UCUtility getAccessList:response];
    
    if (result && [result count] > 0) {
        
        if (self.accessContacts == nil) {
            self.accessContacts = [[NSMutableArray alloc] init];
        }
        [self.accessContacts removeAllObjects];
        self.accessContacts = [result mutableCopy];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"We have found that someone has given you access to enter data. Do you want to enter on behalf of someone else? " delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        alert.tag = 100;
        [alert show];
    }
    else {
        if(fromOngoingClinical)
        {
//            [UCAppDelegate sharedObject].selectedUser = nil;
            UCSelectCaseListViewController *selectProcedure;
            if(IS_IPHONE_5) {
                selectProcedure = [[UCSelectCaseListViewController alloc] initWithNibName:@"UCSelectCaseListViewController" bundle:nil];
            }
            else {
                selectProcedure = [[UCSelectCaseListViewController alloc] initWithNibName:@"UCSelectCaseListViewController_iPhone" bundle:nil];
            }
            [self.navigationController pushViewController:selectProcedure animated:NO];
        }
        else
        {
//            [UCAppDelegate sharedObject].selectedUser = nil;
            [self forwardButtonPressed];
        }
        
    }
}


- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewDidUnload {
    overlayLayout_ = nil;
    activityIndicator_ = nil;
    [super viewDidUnload];
}

- (IBAction)SettingsView:(id)sender {
    UCSettingsViewController *setting = nil;
    if(IS_IPHONE_5) {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController" bundle:nil];
    }
    else {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController_iphone" bundle:nil];
    }
    [self.navigationController pushViewController:setting animated:YES];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 100) {
        
        if (buttonIndex == 0) {
            if(fromOngoingClinical){
//                [UCAppDelegate sharedObject].selectedUser = nil;
                UCSelectCaseListViewController *selectProcedure;
                if(IS_IPHONE_5) {
                    selectProcedure = [[UCSelectCaseListViewController alloc] initWithNibName:@"UCSelectCaseListViewController" bundle:nil];
                }
                else {
                    selectProcedure = [[UCSelectCaseListViewController alloc] initWithNibName:@"UCSelectCaseListViewController_iPhone" bundle:nil];
                }
                [self.navigationController pushViewController:selectProcedure animated:NO];
            }
            else{
//                [UCAppDelegate sharedObject].selectedUser = nil;
                [self forwardButtonPressed];
            }
            
        }else if (buttonIndex == 1){
            
            UCSelectAccessContactsViewController *controller = [[UCSelectAccessContactsViewController alloc] initWithNibName:@"UCSelectAccessContactsViewController" bundle:nil];
            
            controller.contactsArray = [self.accessContacts mutableCopy];
            
            [self.navigationController pushViewController:controller animated:YES];
            
        }
    }
}

@end

