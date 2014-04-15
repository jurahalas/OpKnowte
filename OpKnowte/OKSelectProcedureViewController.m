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
    
    _selectProcedureTableView.backgroundColor = [UIColor clearColor];
    [super viewDidLoad];
	[self.navigationController setNavigationBarHidden:NO animated:YES ];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    
    
    
    return cell;
}

@end
