//
//  OKAccessSettingsViewController.m
//  OpKnowte
//
//  Created by Olegek on 01.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKAccessSettingsViewController.h"
#import "OKAccessSettingsTableViewCell.h"
#import "OKAccessConfirmViewController.h"

@interface OKAccessSettingsViewController ()
@property (strong, nonatomic) IBOutlet UIButton *updateButton;
@property (strong, nonatomic) IBOutlet UITableView *accessSettingsTableView;

@end

@implementation OKAccessSettingsViewController
@synthesize accessSettingsTableView,updateButton;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)backButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)updateSettingsButton:(id)sender {
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    
    accessSettingsTableView.backgroundColor = [UIColor clearColor];
    self.accessSettingsTableView.dataSource = self;
    self.accessSettingsTableView.delegate = self;
    accessSettingsTableView.frame = CGRectMake(accessSettingsTableView.frame.origin.x, accessSettingsTableView.frame.origin.y, accessSettingsTableView.frame.size.width, (accessSettingsTableView.frame.size.height - 57.f));
    [self.accessSettingsTableView reloadData];

    updateButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    updateButton.layer.cornerRadius = 14;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"accessSetings";
    OKAccessSettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKAccessSettingsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSMutableArray *dataTitleArray = [[NSMutableArray alloc] initWithObjects:
                                      @"Surgeons",
                                      @"Assistans",
                                      @"Other",nil];
    
    cell.aSettingLable.text = [dataTitleArray objectAtIndex:indexPath.row];
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}



@end
