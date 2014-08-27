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

@interface OKUserListVC ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *shareButtonView;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (assign, nonatomic) int countOfCell;

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
    self.countOfCell = 4;
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

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)shareButtonTapped:(id)sender
{
}
@end
