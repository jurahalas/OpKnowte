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
#import "OKAccessSettingsViewController.h"
#import "OKAccessSettingManager.h"
#import "OKFakeTableViewCell.h"

@interface OKAccessSettingsCCViewController ()<OKAccessSettingsCC>

@property (strong, nonatomic) IBOutlet UITableView *accessSettingsTableView;

@property(strong, nonatomic) NSArray *contactsArray;
@property(strong, nonatomic) NSString *selectedContactID;
@property(strong, nonatomic) NSMutableArray * containsWithAccesArray;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIView *shareButtonView;

- (IBAction)shareButtonTapped:(id)sender;

@end

@implementation OKAccessSettingsCCViewController
@synthesize contactsArray,selectedContactID,accessSettingsTableView,accessArray,containsWithAccesArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    accessSettingsTableView.backgroundColor = [UIColor clearColor];
    self.shareButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    self.shareButton.layer.cornerRadius = 14.f;
    
    [self.view bringSubviewToFront:self.shareButtonView];
    
    self.accessSettingsTableView.dataSource = self;
    self.accessSettingsTableView.delegate = self;
    
  // accessSettingsTableView.frame = CGRectMake(accessSettingsTableView.frame.origin.x, accessSettingsTableView.frame.origin.y + 65, accessSettingsTableView.frame.size.width, (accessSettingsTableView.frame.size.height));
    
    _choosedContacts = [[NSMutableArray alloc]init];
    for (NSDictionary * chosedM in accessArray) {
        [_choosedContacts addObject:[chosedM valueForKeyPath:@"emailAddress"]];
    }
    
    //containsWithAccesArray = [[NSMutableArray alloc]init];
    
//    [self addBottomTabBar];
//    [self addRightButtonsToNavbar];
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
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    [self getContactsList];
}

-(void)viewWillDisappear:(BOOL)animated
{
    id<OKAccessSettingsCCDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(updateWithArray:)]) {
        [delegate updateWithArray:self.choosedContacts];
        
    }
}

//-(void) addRightButtonsToNavbar
//{
//    UIButton *addContact = [[UIButton alloc] init];
//    addContact.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"plusGreenIcon"].size.width, [UIImage imageNamed:@"plusGreenIcon"].size.height );
//    [addContact setImage:[UIImage imageNamed:@"plusGreenIcon"] forState:UIControlStateNormal];
//    [addContact addTarget:self action:@selector(addContactTapped) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *deleteContact = [[UIButton alloc] init];
//    deleteContact.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"redCross"].size.width, [UIImage imageNamed:@"redCross"].size.height );
//    [deleteContact setImage:[UIImage imageNamed:@"redCross"] forState:UIControlStateNormal];
//    [deleteContact addTarget:self action:@selector(deleteContactTapped) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithCustomView:addContact];
//    UIBarButtonItem *delete = [[UIBarButtonItem alloc] initWithCustomView:deleteContact];
//    
//    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:add,delete, nil];
//}

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
    
    [self.accessSettingsTableView setEditing:!self.accessSettingsTableView.editing animated:YES];
//    if (selectedContactID==nil) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                        message:@"You must select contact to delete it"
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil, nil];
//        [alert show];
//        [self.view endEditing:YES];
//        
//    }else{
//        OKContactManager *manager = [OKContactManager instance];
//        [manager deleteContactWithContactID:self.selectedContactID handler:^(NSString *errorMsg) {
//            if (!errorMsg) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
//                                                                message:@"Сontact was successfully removed"
//                                                               delegate:self
//                                                      cancelButtonTitle:@"OK"
//                                                      otherButtonTitles:nil, nil];
//                [alert show];
//            }
//            [self getContactsList];
//        }];
//    }
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
    return contactsArray.count + 1;
}

//-(void)addContactToList:(OKContactModel *)contact{
//
//    [_choosedContacts addObject:contact.contactEmail];
//}
//
//-(void)deleteContactFromList:(OKContactModel *)contact{
//    
//
//    for (int i = 0; i<_choosedContacts.count; i++) {
//        if ([[_choosedContacts objectAtIndex:i]isEqualToString:contact.contactEmail]) {
//            [_choosedContacts removeObjectAtIndex:i];
//        }
//    }
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"contactCell";
    static NSString *fakeCellIdentifier = @"fakeCell";
    
    OKAccessSettingsCCTableViewCell *cell = [[OKAccessSettingsCCTableViewCell alloc] init];
    OKFakeTableViewCell *fakeCell = [[OKFakeTableViewCell alloc]init];
    
    if (indexPath.row < self.contactsArray.count) {

        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        OKContactModel * contact  = (OKContactModel*)self.contactsArray[indexPath.row];
        cell.contactNameLabel.text = contact.name;
        cell.emailLabel.text = contact.contactEmail;
        cell.contactModel = contact;
        [cell setCellBGImageLight:indexPath.row];
        cell.delegate = self;
        
        for (NSDictionary * chosedM in accessArray) {
            if ([[chosedM valueForKey:@"contactID"] isEqualToString:contact.identifier]) {
                [cell setCellButtonBGImageWithGreenMinusIcon:YES];
            }
        }
        
        return cell;
        
    } else {
        
        fakeCell = [tableView dequeueReusableCellWithIdentifier:fakeCellIdentifier forIndexPath:indexPath];
        
        return fakeCell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKContactModel *contact = [OKContactModel new];
    contact = self.contactsArray[indexPath.row];
    self.selectedContactID = contact.identifier;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewCellEditingStyleDelete;
//}
//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}

//
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        OKContactModel *contact = [OKContactModel new];
//        contact = self.contactsArray[indexPath.row];
//        NSString *selectedContactID = contact.identifier;
//        OKContactManager *manager = [OKContactManager instance];
//        [manager deleteContactWithContactID:selectedContactID handler:^(NSString *errorMsg) {
//            if (!errorMsg) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
//                                                                message:@"Сontact was successfully removed"
//                                                               delegate:self
//                                                      cancelButtonTitle:@"OK"
//                                                      otherButtonTitles:nil, nil];
//                [alert show];
//            }
//            [self getContactsList];
//        }];
//    }
//}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)shareButtonTapped:(id)sender
{
    
}


@end
