//
//  OKNationalPerformanceDataViewController.m
//  OpKnowte
//
//  Created by Apple on 16.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKNationalPerformanceDataViewController.h"

@interface OKNationalPerformanceDataViewController ()
@property (weak, nonatomic) IBOutlet UITableView *nationalDataTableView;

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
    [self.nationalDataTableView reloadData];
    NSLog(@"%f",_nationalDataTableView.frame.size.height );
    
    _nationalDataTableView.frame = CGRectMake(_nationalDataTableView.frame.origin.x, _nationalDataTableView.frame.origin.y, _nationalDataTableView.frame.size.width, (_nationalDataTableView.frame.size.height - 51.f));
    NSLog(@"%f",_nationalDataTableView.frame.size.height );
    [self addBottomTabBar];
    [self.nationalDataTableView reloadData];

}

-(void) viewDidAppear:(BOOL)animated{
    _nationalDataTableView.frame = CGRectMake(_nationalDataTableView.frame.origin.x, _nationalDataTableView.frame.origin.y, _nationalDataTableView.frame.size.width, (_nationalDataTableView.frame.size.height - 51.f));
}
-(void) viewWillAppear:(BOOL)animated{
    _nationalDataTableView.frame = CGRectMake(_nationalDataTableView.frame.origin.x, _nationalDataTableView.frame.origin.y, _nationalDataTableView.frame.size.width, (_nationalDataTableView.frame.size.height - 51.f));
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
    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"nationalDataCell";
    OKNationalDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (!cell) {
        cell = [[OKNationalDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell setCellTitle];
    if (indexPath.row >3) {
        [cell setCellUserIntaractionDisabled];
    } else {
        [cell setCellUserIntaractionEnabled];
    }
    
    return cell;
}

@end
