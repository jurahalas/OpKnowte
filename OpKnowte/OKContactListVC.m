//
//  OKContactListVC.m
//  OpKnowte
//
//  Created by Apple on 09.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKContactListVC.h"
#import "OKInstituteVC.h"
@interface OKContactListVC ()
@property (strong, nonatomic) IBOutlet UITableView *contactsTable;
@property(strong, nonatomic) NSArray *contactsArray;
@property(strong, nonatomic) NSString *selectedContactID;
@property (strong, nonatomic) OKContactModel *selectedContact;
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
    [self getContactsList];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
        if (_selectedContact!= nil) {
            instVC.selectedContact = _selectedContact;
        }
    }

}


-(void) addContactTapped
{
    _selectedContact = nil;
    [self performSegueWithIdentifier:@"fromContactListToInstitute" sender:_contactID];
    
}


-(void) deleteContactTapped
{

    [self.contactsTable setEditing:!self.contactsTable.editing animated:YES];
//    if (_selectedContactID==nil) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                                          message:@"You must select contact to delete it"
//                                                                         delegate:self
//                                                                cancelButtonTitle:@"OK"
//                                                                otherButtonTitles:nil, nil];
//        [alert show];
//        [self.view endEditing:YES];
//        
//    }else{
//        OKContactManager *manager = [OKContactManager instance];
//        [manager deleteContactWithContactID:self.selectedContactID handler:^(NSString *errorMsg) {
//            if (!errorMsg) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
//                                                                                  message:@"Сontact was successfully removed"
//                                                                                 delegate:self
//                                                                        cancelButtonTitle:@"OK"
//                                                                        otherButtonTitles:nil, nil];
//                [alert show];
//            }
//            [self getContactsList];
//        }];
//    }
}


-(void) getContactsList
{
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    OKContactManager *contactManager = [OKContactManager instance];
    [contactManager getContactsByUserID:[OKUserManager instance].currentUser.identifier roleID:_contactID handler: ^(NSString* error, NSMutableArray* array){
        if (!error) {
            self.contactsArray = array;
            [self.contactsTable reloadData];
        }
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
    _selectedContact = self.contactsArray[indexPath.row];

    [self performSegueWithIdentifier:@"fromContactListToInstitute" sender:_contactID];
    
    
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        OKContactModel *contact = [OKContactModel new];
        contact = self.contactsArray[indexPath.row];
        NSString *selectedContactID = contact.identifier;
        OKContactManager *manager = [OKContactManager instance];
        [manager deleteContactWithContactID:selectedContactID handler:^(NSString *errorMsg) {
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











- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
