//
//  OKSurgeonPerfomanceDataVC.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/25/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSurgeonPerfomanceDataVC.h"
#import "OKProcedureCell.h"
#import "OKListCell.h"


@interface OKSurgeonPerfomanceDataVC ()
@property (strong, nonatomic) IBOutlet UITableView *procedureTableView;

@property (strong, nonatomic) IBOutlet UIView *dateView;

@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) IBOutlet UILabel *diselectAllLabel;
@property (strong, nonatomic) IBOutlet UIButton *diselectAllButton;
@property (strong, nonatomic) IBOutlet UILabel *searchLabel;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@property (strong, nonatomic) IBOutlet UITableView *listTableView;

@property (strong, nonatomic) IBOutlet UIView *selectVariablesView;
@property (strong, nonatomic) IBOutlet UIButton *selectVariablesButton;

@end

@implementation OKSurgeonPerfomanceDataVC

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
    self.procedureTableView.dataSource = self;
    self.procedureTableView.delegate = self;
    self.listTableView.delegate=self;
    self.listTableView.dataSource=self;
    
	[self setDesign];
    [_procedureTableView reloadData];
    [_listTableView reloadData];
}
- (IBAction)selectVariablesButton:(id)sender {
}
- (IBAction)diselectAllButton:(id)sender {
}
- (IBAction)searchButton:(id)sender {
}
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

-(void) setDesign{
    [self.navigationController setNavigationBarHidden:NO animated:YES ];
    
    _procedureTableView.backgroundColor = [UIColor clearColor];
    _listTableView.backgroundColor = [UIColor clearColor];
    _dateView.backgroundColor = [UIColor colorWithRed:19/255.f green:65/255.f blue:91/255.f alpha:1];
    _searchView.backgroundColor = [UIColor clearColor];
    
    
    //_selectVariablesView.backgroundColor = [UIColor clearColor];
    _selectVariablesView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradientBG"]];

    
    _selectVariablesButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _selectVariablesButton.layer.cornerRadius = 14;
    _selectVariablesButton.clipsToBounds = YES;
 
    
}
#pragma mark - tableView methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _procedureTableView) {
        return 1;
    } else {
        return 10;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _procedureTableView) {
        static NSString *cellIdentifier = @"procedureCell";
        OKProcedureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[OKProcedureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        return cell;

    }else{
        static NSString *cellIdentifier = @"listCell";
        OKListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[OKListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        return cell;
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
