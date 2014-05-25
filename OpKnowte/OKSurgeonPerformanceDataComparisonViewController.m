//
//  OKSurgeonPerformanceDataComparisonViewController.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/22/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSurgeonPerformanceDataComparisonViewController.h"

@interface OKSurgeonPerformanceDataComparisonViewController ()
@property (strong, nonatomic) IBOutlet UITableView *surgeonPerformanceDataComparisonTableView;

@end

@implementation OKSurgeonPerformanceDataComparisonViewController

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
    [self setNavBarTitle];
    
    _surgeonPerformanceDataComparisonTableView.backgroundColor = [UIColor clearColor];
    
    self.surgeonPerformanceDataComparisonTableView.dataSource = self;
    self.surgeonPerformanceDataComparisonTableView.delegate = self;
    
    _surgeonPerformanceDataComparisonTableView.frame = CGRectMake(_surgeonPerformanceDataComparisonTableView.frame.origin.x, _surgeonPerformanceDataComparisonTableView.frame.origin.y, _surgeonPerformanceDataComparisonTableView.frame.size.width, (_surgeonPerformanceDataComparisonTableView.frame.size.height - 57.f));
    [self addBottomTabBar];
    if (!IS_IOS7) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
	// Do any additional setup after loading the view.
}
-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width+27, [UIImage imageNamed:@"back"].size.height );
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) setNavBarTitle{

    UIView *navbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, 44)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(-15, 0, 240, 24)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:18.0f];
    titleLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"Surgeon Performance Data";
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(-15, 24, 240, 20)];
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    subTitleLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:13.0f];
    subTitleLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    subTitleLabel.textColor = [UIColor whiteColor];
    subTitleLabel.text = @"Sample size (N=2)";
    
    [navbarView addSubview:titleLabel];
    [navbarView addSubview:subTitleLabel];
    
    self.navigationItem.titleView = navbarView;
    
}
#pragma mark - IBActions
- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - Table View methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 50.f;
    } else {
        return 100.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *titleCellIdentifier = @"titleCell";
    static NSString *contentCellIdentifier = @"contentCell";
    OKSurgeonPerformanceDataComparisonTitleCell *titleCell = [[OKSurgeonPerformanceDataComparisonTitleCell alloc] init];
    OKSurgeonPerformanceDataComparisonContentCell *contentCell = [[OKSurgeonPerformanceDataComparisonContentCell alloc] init];
    if (indexPath.row == 0) {
        titleCell = [tableView dequeueReusableCellWithIdentifier:titleCellIdentifier forIndexPath:indexPath];
        if (!titleCell) {
            titleCell = [[OKSurgeonPerformanceDataComparisonTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleCellIdentifier];
        }
        titleCell.titleLabel.text = @"Average blood loss";\
        return titleCell;
    } else {
        contentCell = [tableView dequeueReusableCellWithIdentifier:contentCellIdentifier forIndexPath:indexPath];
        if (!contentCell) {
            contentCell = [[OKSurgeonPerformanceDataComparisonContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentCellIdentifier];
        }
        if (indexPath.row == 1) {
            [contentCell setLabelsWithData:@"National Data" bloodLoss:@"Average Blood Loss - 179.9 (2.0 to 2523.0)" sampleSize:@"Sample size (N=112)"];
            return contentCell;
        
        } else {
            [contentCell setLabelsWithData:@"Surgeon Data" bloodLoss:@"Average Blood Loss - 500.0 (500.0 to 500.0)" sampleSize:@"Sample size (N=1)"];
            return contentCell;

        }
 
    }

    
}


@end
