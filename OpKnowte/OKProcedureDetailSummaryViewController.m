//
//  OKProcedureDetailSummaryViewController.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/18/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureDetailSummaryViewController.h"

@interface OKProcedureDetailSummaryViewController ()
@property (strong, nonatomic) IBOutlet UITableView *procedureDetailSummaryTableView;

@end

@implementation OKProcedureDetailSummaryViewController

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
    _procedureDetailSummaryTableView.backgroundColor = [UIColor clearColor];
    
    self.procedureDetailSummaryTableView.dataSource = self;
    self.procedureDetailSummaryTableView.delegate = self;
    
    _procedureDetailSummaryTableView.frame = CGRectMake(_procedureDetailSummaryTableView.frame.origin.x, _procedureDetailSummaryTableView.frame.origin.y, _procedureDetailSummaryTableView.frame.size.width, (_procedureDetailSummaryTableView.frame.size.height - 60.f));
    [self addBottomTabBar];
    
    [self.procedureDetailSummaryTableView reloadData];
    if (!IS_IOS7) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
	// Do any additional setup after loading the view.
}
-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width, [UIImage imageNamed:@"back"].size.height );
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - IBActions
- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - Table View methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"procedureDetailSummaryCell";
    OKProcedureDetailSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKProcedureDetailSummaryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
   
    [cell setLabels];
    // Unselected cells
    //    if (indexPath.row >3) {
    //        [cell setCellUserIntaractionDisabled];
    //    } else {
    //        [cell setCellUserIntaractionEnabled];
    //    }
    
    return cell;
    
}

@end
