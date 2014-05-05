//
//  OKSelectCaseViewController.m
//  OpKnowte
//
//  Created by Olegek on 25.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSelectCaseViewController.h"
#import "OKSelectCaseTableViewCell.h"

@interface OKSelectCaseViewController ()
@property (strong, nonatomic) IBOutlet UITableView *selectCase;
@end

@implementation OKSelectCaseViewController
@synthesize selectCase;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    selectCase.backgroundColor = [UIColor clearColor];
    self.selectCase.dataSource = self;
    self.selectCase.delegate = self;
    selectCase.frame = CGRectMake(selectCase.frame.origin.x, selectCase.frame.origin.y, selectCase.frame.size.width, (selectCase.frame.size.height - 57.f));
    [self.selectCase reloadData];
    
    [self addBottomTabBar];
}

#pragma mark IBAction metods

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Table View methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"selectCase";
    OKSelectCaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKSelectCaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSMutableArray *dataCaseNameArray = [[NSMutableArray alloc] initWithObjects:
                                      @"1.Case Name #1",
                                      @"2.Case Name #2",
                                      @"3.Case Name #3",
                                      @"4.Case Name #4",nil];
    
    NSMutableArray *dataCaseArray = [[NSMutableArray alloc] initWithObjects:
                                         @"04-18-2014",
                                         @"04-18-2014",
                                         @"04-18-2014",
                                         @"04-18-2014",nil];
    
    cell.caseName.text = [dataCaseNameArray objectAtIndex:indexPath.row];
    cell.dataLable.text = [dataCaseArray objectAtIndex:indexPath.row];
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
