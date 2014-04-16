//
//  OKSelectProcedureViewController.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/15/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSelectProcedureViewController.h"

@interface OKSelectProcedureViewController ()
@property (strong, nonatomic) IBOutlet UITableView *selectProcedureTableView;

@end

@implementation OKSelectProcedureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
	[self.navigationController setNavigationBarHidden:NO animated:YES ];
    _selectProcedureTableView.backgroundColor = [UIColor clearColor];
    
    self.selectProcedureTableView.dataSource = self;
    self.selectProcedureTableView.delegate = self;
    [self.selectProcedureTableView reloadData];
    NSLog(@"%f",_selectProcedureTableView.frame.size.height );
    
    _selectProcedureTableView.frame = CGRectMake(_selectProcedureTableView.frame.origin.x, _selectProcedureTableView.frame.origin.y, _selectProcedureTableView.frame.size.width, (_selectProcedureTableView.frame.size.height - 60.f));
    NSLog(@"%f",_selectProcedureTableView.frame.size.height );
    [self addBottomTabBar];
    [self.selectProcedureTableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - IBActions
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table View methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"procedureCell";
    OKSelectProcedureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (!cell) {
        cell = [[OKSelectProcedureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    [cell setCellTitleOlo];
    if (indexPath.row >3) {
        [cell setCellUserIntaractionDisabled];
    } else {
        [cell setCellUserIntaractionEnabled];
    }
    
    return cell;
}

@end
