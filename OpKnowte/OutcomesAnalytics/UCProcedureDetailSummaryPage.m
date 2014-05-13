//
//  UCProcedureDetailSummaryPage.m
//  MZUroCapture
//
//  Created by Atif Joyia on 09/07/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCProcedureDetailSummaryPage.h"
#import "UCSettingsViewController.h"
#import "UCHomeScreenViewController.h"

#import "OKWebServerManager.h"
#import "OKProceduresManager.h"

@implementation UCProcedureDetailSummaryPage

@synthesize summaryTable, caseData;
@synthesize templateVariables, model;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.caseData = [[NSMutableDictionary alloc] init];
        self.templateVariables = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(IS_IPHONE_5)
    {
        headerLbl_.frame=CGRectMake(headerLbl_.frame.origin.x, headerLbl_.frame.origin.y+5, headerLbl_.frame.size.width, headerLbl_.frame.size.height);
    }
    [headerLbl_ setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    
    [UCUtility showBlockView];
    [OKWebServerManager getTemplateVariables:[[OKProceduresManager instance].selectedProcedure procedureID] handler:^(NSString *errorMsg, id responseJSON) {
        
        [UCUtility hideBlockView];
        if(!errorMsg)
           [self templateVariablesSucceded:responseJSON];
        else
            [UCUtility showInfoAlertView:@"Error" withMessage:errorMsg];
    }];
}


- (void)templateVariablesSucceded:(id)response
{
    self.templateVariables = [UCUtility getTemplateDetailVariables:response];
    self.model = [UCUtility getCaseMode:self.caseData];
    [self.summaryTable reloadData];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.templateVariables count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"UCSelectCaseCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    UCTemplateVariablesModel *variableModel = [self.templateVariables objectAtIndex:indexPath.row];
   // NSLog(@"%@",[variableModel key]);
   // NSLog(@"%@",[variableModel value]);
    
    [cell.textLabel setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:15]];
    [cell.textLabel setTextColor:[UIColor darkGrayColor]];
    [cell.textLabel setText:[variableModel value]];
    
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"PTSans-Regular" size:15]];
    [cell.detailTextLabel setTextColor:[UIColor colorWithRed:0.4863f green:0.7294f blue:0.7333 alpha:1.0f]];
    [cell.detailTextLabel setText:[model valueForKey:[variableModel key]]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (IBAction)SettingsView:(id)sender {
    UCSettingsViewController *setting = nil;
    if(IS_IPHONE_5) {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController" bundle:nil];
    }
    else {
        setting = [[UCSettingsViewController alloc] initWithNibName:@"UCSettingsViewController_iphone" bundle:nil];
    }
    //UCSettingsViewController * setting =[[UCSettingsViewController alloc]init];
    [self.navigationController pushViewController:setting animated:YES];
}

-(IBAction)home:(id)sender{
    if (DELEGATE.isComingFromSignUp) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
    }else{
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}

@end
