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
#import "OKLoadingViewController.h"

@interface OKUserListVC ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *shareButtonView;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) IBOutlet UIView *searchTextFieldView;
@property (strong, nonatomic) IBOutlet OKCustomTextField *searchTextField;
@property (assign, nonatomic) int countOfCell;
@property (strong, nonatomic) NSMutableArray *usersArray;
@property (assign, nonatomic) BOOL isLastPage;
@property (assign, nonatomic) int page;
@property (assign, nonatomic) int totalPages;
@property (assign, nonatomic) int totalUSer;
@property (strong, nonatomic) NSString *keyword;
@property (assign, nonatomic) int numberPages;

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
    self.searchTextFieldView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"segmentControllBG.png"]];
    [self.searchTextField setCustomTextFieldPlaceholder:@"Search..." Secured:NO DownArrow:NO];
    self.keyword = @"";
    [[OKUserManager instance]searchUserByKeyword:@"" AndPage:@"1" Count:@"1" handler:^(NSString *errorMsg, NSMutableArray *users){
        if (!errorMsg) {
            self.usersArray = users;
            self.totalUSer = [[self.usersArray valueForKey:@"totalUsers"]integerValue];
                [self searchUserByKeyword:@"" WihtPage:@"1" Count:@(self.totalUSer)];
            [[OKLoadingViewController instance]hide];
        } else {
            [[OKLoadingViewController instance]hide];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //NSString *numberOfPage = [NSString stringWithFormat:@"%i",self.page];

}

-(void)searchUserByKeyword:(NSString *)keyword WihtPage:(NSString *)page Count:(NSString *)count;
{
    [[OKLoadingViewController instance] showWithText:@"Loading..."];
    [[OKUserManager instance]searchUserByKeyword:keyword AndPage:page Count:count handler:^(NSString *errorMsg, NSMutableArray *users){
        if (!errorMsg) {
            self.usersArray = users;
            // parsing value from array [[self.usersArray valueForKey:@"0"] valueForKey:@"EMAILADDRESS"]
            self.isLastPage = [[self.usersArray valueForKey:@"isLastPage"] boolValue];
            self.page = [[self.usersArray valueForKey:@"page"]integerValue];
            self.totalPages = [[self.usersArray valueForKey:@"totalPages"]integerValue];
            self.totalUSer = [[self.usersArray valueForKey:@"totalUsers"]integerValue];
            [self.tableView reloadData];
            [[OKLoadingViewController instance]hide];
        } else {
            [[OKLoadingViewController instance]hide];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.totalUSer+1;
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

    if (indexPath.row < self.totalUSer) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        NSString *number = [NSString stringWithFormat:@"%i",indexPath.row];
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@, %@",[[self.usersArray valueForKeyPath:number] valueForKeyPath:@"FIRSTNAME"],[[self.usersArray valueForKeyPath:number] valueForKeyPath:@"LASTNAME"],[[self.usersArray valueForKeyPath:number] valueForKeyPath:@"TITLE"]];;
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


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    self.keyword = self.searchTextField.text;
    
    [[OKUserManager instance]searchUserByKeyword:self.keyword AndPage:@"1" Count:@"1" handler:^(NSString *errorMsg, NSMutableArray *users){
        if (!errorMsg) {
            self.usersArray = users;
            self.totalUSer = [[self.usersArray valueForKey:@"totalUsers"]integerValue];
            [self searchUserByKeyword:self.keyword WihtPage:@"1" Count:@(self.totalUSer)];
            [[OKLoadingViewController instance]hide];
        } else {
            [[OKLoadingViewController instance]hide];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:errorMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
    return YES;
}


- (IBAction)backButton;
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)shareButtonTapped:(id)sender
{
    NSLog(@"Share Button Tapped");
}


@end
