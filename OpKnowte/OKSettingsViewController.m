//
//  OKSettingsViewController.m
//  OpKnowte
//
//  Created by Olegek on 01.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSettingsViewController.h"
#import "OKSettingsTableViewCell.h"
#import "OKSelectProcVC.h"
#import "OKContactListVC.h"

@interface OKSettingsViewController ()

@property (strong, nonatomic) IBOutlet UITableView *settingsTableView;

@end

@implementation OKSettingsViewController
@synthesize settingsTableView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    settingsTableView.backgroundColor = [UIColor clearColor];
    self.settingsTableView.dataSource = self;
    self.settingsTableView.delegate = self;
    settingsTableView.frame = CGRectMake(settingsTableView.frame.origin.x, settingsTableView.frame.origin.y, settingsTableView.frame.size.width, (settingsTableView.frame.size.height - 57.f));
    [self.settingsTableView reloadData];
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


- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"settings";
    OKSettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKSettingsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSMutableArray *dataTitleArray = [[NSMutableArray alloc] initWithObjects:
                                      @"Data Sharing",
                                      @"Reminder Settings",
                                      @"Access Settings",
                                      @"Contacts",
                                      @"Institutions",
                                      @"Edit Procedure Template",
                                      @"Change Password",nil];
    cell.settingsLabel.text = [dataTitleArray objectAtIndex:indexPath.row];
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKSettingsTableViewCell *cell = [[OKSettingsTableViewCell alloc] init];
    cell = (OKSettingsTableViewCell*)[settingsTableView cellForRowAtIndexPath:indexPath];
    if ([cell.settingsLabel.text  isEqualToString:@"Access Settings"])
    {
        [self performSegueWithIdentifier:@"aSettings" sender:indexPath];
    }else if ([cell.settingsLabel.text isEqualToString:@"Change Password"])
    {
        [self performSegueWithIdentifier:@"CP" sender:indexPath];
    }else if ([cell.settingsLabel.text  isEqualToString:@"Contacts"])
    {
        [self performSegueWithIdentifier:@"fromSettingsToContacts" sender:indexPath];
    }else if ([cell.settingsLabel.text isEqualToString:@"Data Sharing"])
    {
        [self performSegueWithIdentifier:@"dataShare" sender:indexPath];
    }else if ([cell.settingsLabel.text isEqualToString:@"Edit Procedure Template"])
    {
        [self performSegueWithIdentifier:@"EPT" sender:indexPath];
    }else if ([cell.settingsLabel.text isEqualToString:@"Reminder Settings"])
    {
        [self performSegueWithIdentifier:@"reminder" sender:indexPath];
    }else if ([cell.settingsLabel.text isEqualToString:@"Institutions"])
    {
        [self performSegueWithIdentifier:@"institutions" sender:[NSString stringWithFormat:@"4"]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    OKSelectProcVC *instVC = (OKSelectProcVC*)segue.destinationViewController;
    if([segue.identifier isEqualToString:@"aSettings"]){
        instVC.cameFromVC = @"AccessSettingsVC";
    } else if ([segue.identifier isEqualToString:@"dataShare"]){
        instVC.cameFromVC = @"DataSharingVC";
    } else if ([segue.identifier isEqualToString:@"EPT"]){
        instVC.cameFromVC = @"EditProcTemplateVC";
    } else if ([segue.identifier isEqualToString:@"reminder"]){
        instVC.cameFromVC = @"ReminderSettings";
    }else if ([segue.identifier isEqualToString:@"institutions"]){
        OKContactListVC *contactsVC = (OKContactListVC*)segue.destinationViewController;
        contactsVC.contactID = sender;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end