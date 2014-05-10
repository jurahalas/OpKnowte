//
//  OKCaseDataViewController.m
//  OpKnowte
//
//  Created by Olegek on 07.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKCaseDataViewController.h"
#import "OKCaseDataTableViewCell.h"

@interface OKCaseDataViewController ()
@property (strong, nonatomic) IBOutlet UITableView *caseDataTableView;

@end

@implementation OKCaseDataViewController
@synthesize caseDataTableView;

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
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    
    caseDataTableView.backgroundColor = [UIColor clearColor];
    self.caseDataTableView.dataSource = self;
    self.caseDataTableView.delegate = self;
    caseDataTableView.frame = CGRectMake(caseDataTableView.frame.origin.x, caseDataTableView.frame.origin.y, caseDataTableView.frame.size.width, (caseDataTableView.frame.size.height - 57.f));
    
}
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate updateTemplateModelWith:_templateModel];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    OKCaseDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKCaseDataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.caseDataLabel.text = @"sadasdas";
    [cell setCellBGImageLight:indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
