//
//  OKContactsVC.m
//  OpKnowte
//
//  Created by Apple on 06.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKContactsVC.h"
#import "OKInstituteVC.h"

@interface OKContactsVC ()

@property (strong, nonatomic) IBOutlet UITableView *contactsTableView;
@property (strong, nonatomic) NSDictionary *dataDict;

@end

@implementation OKContactsVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataDict =  @{@"Surgeons":@"1",
                       @"Assistans":@"2",
                       @"Reffering Physicians":@"5"};
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    _contactsTableView.backgroundColor = [UIColor clearColor];
    self.contactsTableView.dataSource = self;
    self.contactsTableView.delegate = self;
    _contactsTableView.frame = CGRectMake(_contactsTableView.frame.origin.x, _contactsTableView.frame.origin.y, _contactsTableView.frame.size.width, (_contactsTableView.frame.size.height - 57.f));
    [self.contactsTableView reloadData];
}


- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"institute"]){
        OKInstituteVC *instVC = (OKInstituteVC*)segue.destinationViewController;
        instVC.contactID = [self.dataDict valueForKey:sender];
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
    cell.contactsLabel.text = [self.dataDict.allKeys objectAtIndex:indexPath.row];
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"institute" sender:self.dataDict.allKeys[indexPath.row]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end