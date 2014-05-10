//
//  OKAccessSettingsCCViewController.m
//  OpKnowte
//
//  Created by Olegek on 10.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKAccessSettingsCCViewController.h"
#import "OKAccessSettingsCCTableViewCell.h"
#import "OKInstituteVC.h"
#import "OKContactManager.h"
#import "OKContactModel.h"
#import "OKUserModel.h"

@interface OKAccessSettingsCCViewController ()

@property (strong, nonatomic) IBOutlet UITableView *accessSettingsTableView;
@property(strong, nonatomic) NSArray *contactsArray;
@property(strong, nonatomic) NSString *selectedContactID;

@end

@implementation OKAccessSettingsCCViewController
@synthesize contactsArray,selectedContactID,accessSettingsTableView,choseContact;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    accessSettingsTableView.backgroundColor = [UIColor clearColor];
    
    self.accessSettingsTableView.dataSource = self;
    self.accessSettingsTableView.delegate = self;
    
    accessSettingsTableView.frame = CGRectMake(accessSettingsTableView.frame.origin.x, accessSettingsTableView.frame.origin.y, accessSettingsTableView.frame.size.width, (accessSettingsTableView.frame.size.height - 50.f));
    
    choseContact = [[NSMutableArray alloc]init];
    
    [self addBottomTabBar];
    [self addRightButtonsToNavbar];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getContactsList];
}


-(void) addRightButtonsToNavbar
{
    UIButton *addContact = [[UIButton alloc] init];
    addContact.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"plusGreenIcon"].size.width, [UIImage imageNamed:@"plusGreenIcon"].size.height );
    [addContact setImage:[UIImage imageNamed:@"plusGreenIcon"] forState:UIControlStateNormal];
    [addContact addTarget:self action:@selector(addContactTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *deleteContact = [[UIButton alloc] init];
    deleteContact.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"redCross"].size.width, [UIImage imageNamed:@"redCross"].size.height );
    [deleteContact setImage:[UIImage imageNamed:@"redCross"] forState:UIControlStateNormal];
    [deleteContact addTarget:self action:@selector(deleteContactTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithCustomView:addContact];
    UIBarButtonItem *delete = [[UIBarButtonItem alloc] initWithCustomView:deleteContact];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:add,delete, nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"fromAccessSettingToInstitute"]){
        OKInstituteVC *instVC = (OKInstituteVC*)segue.destinationViewController;
        instVC.contactID = self.contactID;
        instVC.cameFromVC = @"AccessSettingsCCViewController";
    }
}


-(void) addContactTapped
{
    [self performSegueWithIdentifier:@"fromAccessSettingToInstitute" sender:_contactID];
}


-(void) deleteContactTapped
{
    if (selectedContactID==nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"You must select contact to delete it"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        [self.view endEditing:YES];
        
    }else{
        OKContactManager *manager = [OKContactManager instance];
        [manager deleteContactWithContactID:self.selectedContactID handler:^(NSString *errorMsg) {
            if (!errorMsg) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                message:@"Сontact was successfully removed"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
            [self getContactsList];
        }];
    }
}


-(void) getContactsList
{
    OKContactManager *contactManager = [OKContactManager instance];
    [contactManager getContactsByUserID:[OKUserManager instance].currentUser.identifier roleID:_contactID handler: ^(NSString* error, NSMutableArray* array){
        if (!error) {
            self.contactsArray = array;
            [self.accessSettingsTableView reloadData];
        }
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
    return contactsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"contactCell";
    OKAccessSettingsCCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKAccessSettingsCCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    OKContactModel *contact = (OKContactModel*)self.contactsArray[indexPath.row];
    cell.contactNameLabel.text = contact.name;
    cell.emailLabel.text = contact.contactEmail;
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKContactModel *contact = [OKContactModel new];
    contact = self.contactsArray[indexPath.row];
    self.selectedContactID = contact.identifier;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
