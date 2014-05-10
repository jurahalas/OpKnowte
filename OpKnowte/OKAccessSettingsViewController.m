//
//  OKAccessSettingsViewController.m
//  OpKnowte
//
//  Created by Olegek on 01.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKAccessSettingsViewController.h"
#import "OKAccessSettingsTableViewCell.h"
#import "OKAccessSettingsCCViewController.h"
#import "OKInstituteVC.h"

@interface OKAccessSettingsViewController ()
@property (strong, nonatomic) IBOutlet UIButton *updateButton;
@property (strong, nonatomic) IBOutlet UITableView *accessSettingsTableView;

@end

@implementation OKAccessSettingsViewController
@synthesize accessSettingsTableView,updateButton;

- (void)viewDidLoad
{
    
    self.dataDict =  @{@"Surgeons":@"1",
                       @"Assistans":@"2",
                       @"Outher":@"6"};
    
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


- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)updateSettingsButton:(id)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"choseContact"]){
        OKInstituteVC *vc = (OKInstituteVC*)segue.destinationViewController;
        vc.contactID = [self.dataDict valueForKey:sender];
        vc.cameFromVC = @"Access Settings View Controller";
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
    static NSString *cellIdentifier = @"accessSetings";
    OKAccessSettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKAccessSettingsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.aSettingLable.text = [self.dataDict.allKeys objectAtIndex:indexPath.row];
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"choseContact" sender:self.dataDict.allKeys[indexPath.row]];
}

@end
