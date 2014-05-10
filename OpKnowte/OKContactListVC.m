//
//  OKContactListVC.m
//  OpKnowte
//
//  Created by Apple on 09.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKContactListVC.h"

@interface OKContactListVC ()
@property (strong, nonatomic) IBOutlet UITableView *contactsTable;
@property(strong, nonatomic) NSArray *contactsArray;
@property(strong, nonatomic) NSString *selectedContactID;
@end

@implementation OKContactListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    _contactsTable.backgroundColor = [UIColor clearColor];
    
    self.contactsTable.dataSource = self;
    self.contactsTable.delegate = self;
    
    _contactsTable.frame = CGRectMake(_contactsTable.frame.origin.x, _contactsTable.frame.origin.y, _contactsTable.frame.size.width, (_contactsTable.frame.size.height - 50.f));
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
    if([segue.identifier isEqualToString:@"fromContactListToInstitute"]){
        OKInstituteVC *instVC = (OKInstituteVC*)segue.destinationViewController;
        instVC.contactID = self.contactID;
        instVC.cameFromVC = @"ContactListVC";
    }
}


-(void) addContactTapped
{
    [self performSegueWithIdentifier:@"fromContactListToInstitute" sender:_contactID];
}


-(void) deleteContactTapped
{
    if (_selectedContactID==nil) {
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
            [self.contactsTable reloadData];
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
    return _contactsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"contactCell";
    OKContactListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKContactListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    OKContactModel *contact = (OKContactModel*)self.contactsArray[indexPath.row];
    cell.contactNameLabel.text = contact.name;
    cell.contactEmailLabel.text = contact.contactEmail;
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