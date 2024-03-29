//
//  OKPerformanceVC.m
//  OpKnowte
//
//  Created by Apple on 24.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKPerformanceVC.h"
#import "OKSelectProcedureViewController.h"

@interface OKPerformanceVC ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *performanceTableView;

@end

@implementation OKPerformanceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.navigationController setNavigationBarHidden:NO animated:YES ];
    _performanceTableView.backgroundColor = [UIColor clearColor];
    self.performanceTableView.dataSource = self;
    self.performanceTableView.delegate = self;
    _performanceTableView.frame = CGRectMake(_performanceTableView.frame.origin.x, _performanceTableView.frame.origin.y, _performanceTableView.frame.size.width, (_performanceTableView.frame.size.height - 57.f));
    [self addBottomTabBar];
    
    [self.performanceTableView reloadData];
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

#pragma mark - IBActions

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table View methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"performanceCell";
    OKPerformanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKPerformanceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSMutableArray *dataTitleArray = [[NSMutableArray alloc] initWithObjects:
                                      @"Intra-Operative Data",
                                      @"FollowUp Data", nil];
    
    cell.performanceLabel.text = [dataTitleArray objectAtIndex:indexPath.row];
    [cell setCellBGImageLight:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OKPerformanceTableViewCell *cell = [[OKPerformanceTableViewCell alloc] init];
    cell = (OKPerformanceTableViewCell*)[_performanceTableView cellForRowAtIndexPath:indexPath];
    if ([cell.performanceLabel.text isEqualToString:@"FollowUp Data"]) {
        
        [self performSegueWithIdentifier:@"fromFollowUpDataToSelectProc" sender:indexPath];
    }
	else if ([cell.performanceLabel.text isEqualToString:@"Intra-Operative Data"]) {
        [self performSegueWithIdentifier:@"toSelectProcedureFromIntraOperative" sender:indexPath];
	}
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"fromFollowUpDataToSelectProc"]){
        OKSelectProcedureViewController *instVC = (OKSelectProcedureViewController*)segue.destinationViewController;
        instVC.cameFromVC = @"FollowUpDataVC";
    }else if([segue.identifier isEqualToString:@"toSelectProcedureFromIntraOperative"]){
        OKSelectProcedureViewController *selectProcedure = (OKSelectProcedureViewController*)segue.destinationViewController;
        selectProcedure.cameFromVC = @"OKPerformanceVC";
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
