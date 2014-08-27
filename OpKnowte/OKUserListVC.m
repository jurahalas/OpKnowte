//
//  OKUserListVC.m
//  OpKnowte
//
//  Created by Olegek on 27.08.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKUserListVC.h"
#import "OKUserListTableViewCell.h"
#import "OKFakeTableViewCell.h"
#import "OKUserManager.h"

@interface OKUserListVC ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *shareButtonView;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (assign, nonatomic) int countOfCell;
@property (strong, nonatomic) NSMutableArray *usersArray;

- (IBAction)shareButtonTapped:(id)sender;

@end

@implementation OKUserListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.shareButtonView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradientBG"]];
    self.shareButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    self.shareButton.layer.cornerRadius = 14;
    [self addLeftButtonToNavbar];
    self.countOfCell = 4;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self searchUserByKeyword:@"" WihtPage:@"1" Count:@"10"];
}

-(void)searchUserByKeyword:(NSString *)keyword WihtPage:(NSString *)page Count:(NSString *)count;
{
    [[OKUserManager instance]searchUserByKeyword:keyword AndPage:page Count:count handler:^(NSString *errorMsg, NSMutableArray *users){
        if (!errorMsg) {
            self.usersArray = users;
        } else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.countOfCell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"userList";
    OKUserListTableViewCell *cell = [[OKUserListTableViewCell alloc] init];
    static NSString *FakeCellIdentifier = @"FakeCell";
    OKFakeTableViewCell *FakeCell = [[OKFakeTableViewCell alloc] init];

    if (indexPath.row < self.countOfCell) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell setCellBGImageLight:indexPath.row];
        
        return cell;
    } else{
        FakeCell = [tableView dequeueReusableCellWithIdentifier:FakeCellIdentifier forIndexPath:indexPath];
        
        return FakeCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    if (IS_IOS7) {
        right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width, [UIImage imageNamed:@"back"].size.height );
    } else {
        right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width +27, [UIImage imageNamed:@"back"].size.height );
    }
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
    
}


- (IBAction)backButton;
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)shareButtonTapped:(id)sender
{
}
@end
