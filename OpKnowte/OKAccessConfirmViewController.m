//
//  OKAccessConfirmViewController.m
//  OpKnowte
//
//  Created by Olegek on 01.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKAccessConfirmViewController.h"
#import "OKAccessConfirmTableViewCell.h"

@interface OKAccessConfirmViewController ()
@property (strong, nonatomic) IBOutlet UITableView *ACTableView;
@property (strong, nonatomic) IBOutlet UILabel *ACLabel;

@end

@implementation OKAccessConfirmViewController
@synthesize ACTableView,ACLabel;

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
    [self addBottomTabBar];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    ACTableView.backgroundColor = [UIColor clearColor];
    self.ACTableView.dataSource = self;
    self.ACTableView.delegate = self;
    ACTableView.frame = CGRectMake(ACTableView.frame.origin.x, ACTableView.frame.origin.y, ACTableView.frame.size.width, (ACTableView.frame.size.height - 57.f));
    [self.ACTableView reloadData];
    
    NSString *indicationText = [NSString stringWithFormat:@"Select Contacts who are alowed to enter data on your cases"];
    
    ACLabel.text = indicationText;
}

#pragma mark Table View method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"access";
    OKAccessConfirmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKAccessConfirmTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSMutableArray *dataTitleArray = [[NSMutableArray alloc] initWithObjects:
                                      @"Select Contacts",nil];
    
    cell.ACLabel.text = [dataTitleArray objectAtIndex:indexPath.row];
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];}

@end