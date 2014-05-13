//
//  UCSelectAccessContactsViewController.m
//  MZUroCapture
//
//  Created by Atif Joyia on 05/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import "UCSelectAccessContactsViewController.h"

@interface UCSelectAccessContactsViewController ()

@end

@implementation UCSelectAccessContactsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(IS_IPHONE_5)
    {
        self.headerLbl.frame=CGRectMake(self.headerLbl.frame.origin.x, self.headerLbl.frame.origin.y+5, self.headerLbl.frame.size.width, self.headerLbl.frame.size.height);
    }
    [self.headerLbl setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:17]];
    [self.headerLbl setText:@"SELECT CONTACT"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contactsArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"UCSelectProcedureCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [tableView setBackgroundView:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [[self.contactsArray objectAtIndex:indexPath.row] firstName], [[self.contactsArray objectAtIndex:indexPath.row] lastName]];
    cell.detailTextLabel.text = [[self.contactsArray objectAtIndex:indexPath.row] email];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([UCAppDelegate sharedObject].selectedUser == nil) {
        [UCAppDelegate sharedObject].selectedUser = [[UCRegisterModel alloc] init];
    }
    [UCAppDelegate sharedObject].selectedUser = [self.contactsArray objectAtIndex:indexPath.row];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
