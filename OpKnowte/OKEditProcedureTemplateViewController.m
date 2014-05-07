//
//  OKEditProcedureTemplateViewController.m
//  OpKnowte
//
//  Created by Olegek on 07.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKEditProcedureTemplateViewController.h"
#import "OKEditProcedureTemplateTableViewCell.h"
#import "OKSelectProcedureViewController.h"

@interface OKEditProcedureTemplateViewController ()
@property (strong, nonatomic) IBOutlet UITableView *editProcedureTemplateTableView;

@end

@implementation OKEditProcedureTemplateViewController
@synthesize editProcedureTemplateTableView;
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
    
    editProcedureTemplateTableView.backgroundColor = [UIColor clearColor];
    self.editProcedureTemplateTableView.dataSource = self;
    self.editProcedureTemplateTableView.delegate = self;
    editProcedureTemplateTableView.frame = CGRectMake(editProcedureTemplateTableView.frame.origin.x, editProcedureTemplateTableView.frame.origin.y, editProcedureTemplateTableView.frame.size.width, (editProcedureTemplateTableView.frame.size.height - 57.f));
    [self.editProcedureTemplateTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    
}
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"EPT";
    OKEditProcedureTemplateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKEditProcedureTemplateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSMutableArray *dataTitleArray = [[NSMutableArray alloc] initWithObjects:
                                      @"Procedure", nil];
    cell.editProcedureLabel.text = [dataTitleArray objectAtIndex:indexPath.row];
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([self.restorationIdentifier isEqualToString:@"SP"]) {
//    OKSelectProcedureViewController *vc = [[OKSelectProcedureViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

@end
