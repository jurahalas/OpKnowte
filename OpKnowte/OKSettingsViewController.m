//
//  OKSettingsViewController.m
//  OpKnowte
//
//  Created by Olegek on 01.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSettingsViewController.h"
#import "OKSettingsTableViewCell.h"

@interface OKSettingsViewController ()

@property (strong, nonatomic) IBOutlet UITableView *settingsTableView;

@end

@implementation OKSettingsViewController
@synthesize settingsTableView;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    
    settingsTableView.backgroundColor = [UIColor clearColor];
    self.settingsTableView.dataSource = self;
    self.settingsTableView.delegate = self;
    settingsTableView.frame = CGRectMake(settingsTableView.frame.origin.x, settingsTableView.frame.origin.y, settingsTableView.frame.size.width, (settingsTableView.frame.size.height - 57.f));
    [self.settingsTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"settings";
    OKSettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKSettingsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSMutableArray *dataTitleArray = [[NSMutableArray alloc] initWithObjects:
                                      @"Data Sharing",
                                      @"Reminder Settings",
                                      @"Access Settings",
                                      @"Contacts",
                                      @"Institutions",
                                      @"Edit Procedure Template",nil];
    
    cell.settingsLabel.text = [dataTitleArray objectAtIndex:indexPath.row];
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}

@end
