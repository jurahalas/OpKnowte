//
//  OKNationalPerformanceDataViewController.m
//  OpKnowte
//
//  Created by Apple on 16.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKNationalPerformanceDataViewController.h"

@interface OKNationalPerformanceDataViewController ()
@property (strong, nonatomic) IBOutlet UITableView *nationalDataTableView;

@end

@implementation OKNationalPerformanceDataViewController


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
    _nationalDataTableView.backgroundColor = [UIColor clearColor];
    
    self.nationalDataTableView.dataSource = self;
    self.nationalDataTableView.delegate = self;
    _nationalDataTableView.frame = CGRectMake(_nationalDataTableView.frame.origin.x, _nationalDataTableView.frame.origin.y, _nationalDataTableView.frame.size.width, (_nationalDataTableView.frame.size.height - 60.f));
    [self addBottomTabBar];
    
    [self.nationalDataTableView reloadData];
    
}


#pragma mark - IBActions
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table View methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"nationalDataCell";
    OKNationalDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKNationalDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
     NSMutableArray *dataTitleArray = [[NSMutableArray alloc] initWithObjects:
                                       @"Chest Xray",
                                       @"Liver Enzymes",
                                       @"Post Site Hernia",
                                       @"CT Scan",
                                       @"Bun",
                                       @"Creatine",
                                       @"Margins",
                                       @"Change in BUN",
                                       @"Deep Margins",
                                       @"Average Creatine",
                                       @"Tumor Characteristics",
                                       @"Length Stay",
                                       @"Complications",
                                       @"Fuhrman Grade",
                                       @"TNM", nil];

    cell.nationalDataLabel.text = [dataTitleArray objectAtIndex:indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

