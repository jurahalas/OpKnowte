//
//  OKContactsVC.m
//  OpKnowte
//
//  Created by Apple on 06.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKContactsVC.h"
#import "OKInstituteVC.h"
#import "OKContactListVC.h"

@interface OKContactsVC ()

@property (strong, nonatomic) IBOutlet UITableView *contactsTableView;
@property (strong, nonatomic) NSDictionary * contactID;
@end

@implementation OKContactsVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataDict =  @{@"1":@"Surgeons",
                       @"2":@"Assistants",
                       @"5":@"Refering Physicians"};
    
    self.contactID = @{@"Surgeons":@"1",
                       @"Assistants":@"2",
                       @"Refering Physicians":@"5"};
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    _contactsTableView.backgroundColor = [UIColor clearColor];
    self.contactsTableView.dataSource = self;
    self.contactsTableView.delegate = self;
    _contactsTableView.frame = CGRectMake(_contactsTableView.frame.origin.x, _contactsTableView.frame.origin.y, _contactsTableView.frame.size.width, (_contactsTableView.frame.size.height - 57.f));
    [self.contactsTableView reloadData];
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
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"contactList"]){
        OKContactListVC *contactVC = (OKContactListVC*)segue.destinationViewController;
        contactVC.contactID = [self.contactID valueForKey:sender];
        contactVC.cameFromVC = @"ContactsVC";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataDict.allKeys.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"contacts";
    OKContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKContactsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.contactsLabel.text = [self.dataDict.allValues objectAtIndex:indexPath.row];
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"contactList" sender:self.dataDict.allValues[indexPath.row]];
}



























- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end