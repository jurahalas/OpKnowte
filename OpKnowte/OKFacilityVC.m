//
//  OKFacilityVC.m
//  OpKnowte
//
//  Created by Apple on 29.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKFacilityVC.h"
#import "OKFacilityTableViewCell.h"


@interface OKFacilityVC ()

@property (strong, nonatomic) IBOutlet UITableView *facilityTableView;
@property (strong, nonatomic) NSMutableArray *contactsArray;


@end

@implementation OKFacilityVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    _facilityTableView.backgroundColor = [UIColor clearColor];
    self.facilityTableView.dataSource = self;
    self.facilityTableView.delegate = self;
    _facilityTableView.frame = CGRectMake(_facilityTableView.frame.origin.x, _facilityTableView.frame.origin.y, _facilityTableView.frame.size.width, (_facilityTableView.frame.size.height - 57.f));
    [self addBottomTabBar];
    [self addRightButtonToNavbar];
    
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    
    OKContactManager *contactManager = [OKContactManager instance];
    [contactManager getContactsByUserID:@"121" roleID:@"4" handler: ^(NSString* error, NSMutableArray* contactsArray){
        NSLog(@"Error - %@", error);

        _contactsArray = contactsArray;
        [self.facilityTableView reloadData];
        [[OKLoadingViewController instance] hide];
    }];
}


-(void) addRightButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"plusGreenIcon.png"].size.width, [UIImage imageNamed:@"plusGreenIcon.png"].size.height );
    [right setImage:[UIImage imageNamed:@"plusGreenIcon.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = anotherButton;

}

#pragma mark IBAction metods

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Table View methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _contactsArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"facilityCell";
    OKFacilityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKFacilityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    OKContactModel *contact = (OKContactModel*)self.contactsArray[indexPath.row];
    cell.facilityNameLabel.text = contact.contactName;
    cell.emailLabel.text = @"ololo";

    [cell setCellBGImageLight:indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
