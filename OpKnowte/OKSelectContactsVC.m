//
//  OKSelectContactsVC.m
//  OpKnowte
//
//  Created by Apple on 13.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSelectContactsVC.h"
#import "OKInstituteVC.h"

@interface OKSelectContactsVC () <OKSelectContactsCellDelegate>
@property (strong, nonatomic) IBOutlet UITableView *contactsTableView;
@property(strong, nonatomic) NSArray *contactsArray;
@property(strong, nonatomic) NSString *selectedContactID;
@property (strong, nonatomic) NSMutableArray *choosedContacts;

@end

@implementation OKSelectContactsVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    _contactsTableView.backgroundColor = [UIColor clearColor];
    self.contactsTableView.dataSource = self;
    self.contactsTableView.delegate = self;
    _contactsTableView.frame = CGRectMake(_contactsTableView.frame.origin.x, _contactsTableView.frame.origin.y, _contactsTableView.frame.size.width, (_contactsTableView.frame.size.height - 57.f));
    [self getContactsList];
    _choosedContacts = [[NSMutableArray alloc] init];
    [self addRightButtonsToNavbar];
    [self.contactsTableView reloadData];
    if (!IS_IOS7) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self getContactsList];
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


-(void) addRightButtonsToNavbar
{
    UIButton *addContact = [[UIButton alloc] init];
    addContact.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"plusGreenIcon"].size.width, [UIImage imageNamed:@"plusGreenIcon"].size.height );
    [addContact setImage:[UIImage imageNamed:@"plusGreenIcon"] forState:UIControlStateNormal];
    [addContact addTarget:self action:@selector(addContactTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithCustomView:addContact];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc] initWithObjects:add, nil];
}

-(void) addContactTapped
{
    _selectedContactID = nil;
    [self performSegueWithIdentifier:@"fromSelectContactsToInstitute" sender:_contactID];
    
}

-(void) getContactsList
{
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    OKContactManager *contactManager = [OKContactManager instance];
    [contactManager getContactsByUserID:[OKUserManager instance].currentUser.identifier roleID:_contactID handler: ^(NSString* error, NSMutableArray* array){
        if (!error) {
            self.contactsArray = array;
            
            [self.contactsTableView reloadData];
        }
        [[OKLoadingViewController instance] hide];
    }];
}

- (IBAction)backButton:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate setChoosedContactsArray:_choosedContacts];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _contactsArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"contacts";
    OKSelectContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKSelectContactsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    OKContactModel *contact = (OKContactModel*)self.contactsArray[indexPath.row];
    cell.delegate = self;
    cell.contactModel = contact;
    cell.contactsType.text = contact.name;
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}

-(void)addContactToArray:(OKContactModel *)contact{
    [_choosedContacts addObject:contact];
    NSLog(@"%i", _choosedContacts.count);
}

-(void)deleteContactFromArray:(OKContactModel *)contact{
    for (int i = 0; i<_choosedContacts.count; i++) {
        OKContactModel *searchedContact = _choosedContacts[i];
        if ([searchedContact.identifier isEqualToString:contact.identifier]) {
            [_choosedContacts removeObjectAtIndex:i];
            break;
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKContactModel *contact = [OKContactModel new];
    contact = self.contactsArray[indexPath.row];
    self.selectedContactID = contact.identifier;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"fromSelectContactsToInstitute"]){
        OKInstituteVC *instVC = (OKInstituteVC*)segue.destinationViewController;
        instVC.contactID = self.contactID;
        instVC.cameFromVC = @"reminder";
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end