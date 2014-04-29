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
#import "RangeSlider.h"

//@class RangeSlider;
@interface OKSurgeonPerfomanceDataVC ()
@property (strong, nonatomic) IBOutlet UITableView *procedureTableView;

@property (strong, nonatomic) IBOutlet UIView *dateView;
@property (strong, nonatomic) IBOutlet OKCustomTextField *dateFromTF;
@property (strong, nonatomic) IBOutlet OKCustomTextField *dateToTF;

@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) IBOutlet UILabel *diselectAllLabel;
@property (strong, nonatomic) IBOutlet UIButton *diselectAllButton;
@property (strong, nonatomic) IBOutlet UILabel *searchLabel;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@property (strong, nonatomic) IBOutlet UITableView *listTableView;

@property (strong, nonatomic) IBOutlet UIView *selectVariablesView;
@property (strong, nonatomic) IBOutlet UIButton *selectVariablesButton;

@property(strong,nonatomic) RangeSlider *slider;

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
    _dateFromTF.text = @"";
    _dateToTF.text = @"";
    
    
    
    _searchView.backgroundColor = [UIColor clearColor];
    
    
    _selectVariablesView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradientBG"]];

    
    _selectVariablesButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _selectVariablesButton.layer.cornerRadius = 14;
    _selectVariablesButton.clipsToBounds = YES;
    
    
    
    
    _slider = [[RangeSlider alloc] initWithFrame:CGRectMake(60, 100, 244, 20)]; // the slider enforces a height of 30, although I'm not sure that this is necessary
	_slider.minimumRangeLength = .0005; // this property enforces a minimum range size. By default it is set to 0.0
	[_slider setMinThumbImage:[UIImage imageNamed:@"rangethumb.png"]]; // the two thumb controls are given custom images
	[_slider setMaxThumbImage:[UIImage imageNamed:@"rangethumb.png"]];
	UIImage *image; // there are two track images, one for the range "track", and one for the filled in region of the track between the slider thumbs
	[_slider setTrackImage:[[UIImage imageNamed:@"fullrange.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(9.0, 9.0, 9.0, 9.0)]];
	image = [UIImage imageNamed:@"fillrange.png"];
	[_slider setInRangeTrackImage:image];
    //[_slider addTarget:self action:@selector(report:) forControlEvents:UIControlEventValueChanged]; // The slider sends actions when the value of the minimum or maximum changes
	//reportLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 30, 310, 30)]; // a label to see the values of the slider in this demo
	//reportLabel.adjustsFontSizeToFitWidth = YES;
	//reportLabel.textAlignment = NSTextAlignmentCenter;
	//[window addSubview:reportLabel];
	//NSString *report = [NSString stringWithFormat:@"current slider range is %d to %d", (int)(slider.min*1000), (int)(slider.max*1000)];
	//reportLabel.text = report;
    [self.dateView addSubview:_slider];
    
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
