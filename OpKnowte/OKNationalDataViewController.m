//
//  OKNationalDataViewController.m
//  OpKnowte
//
//  Created by Apple on 17.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKNationalDataViewController.h"

@interface OKNationalDataViewController ()

@property (strong, nonatomic) IBOutlet UITableView *nationalData;

@end

@implementation OKNationalDataViewController

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
    _nationalData.backgroundColor = [UIColor clearColor];
    
    self.nationalData.dataSource = self;
    self.nationalData.delegate = self;
    _nationalData.frame = CGRectMake(_nationalData.frame.origin.x, _nationalData.frame.origin.y, _nationalData.frame.size.width, (_nationalData.frame.size.height - 57.f));
    [self addBottomTabBar];
    
    [self.nationalData reloadData];
    
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
    OKNationalDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKNationalDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
