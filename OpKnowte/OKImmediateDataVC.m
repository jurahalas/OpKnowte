//
//  OKImmediateDataVC.m
//  OpKnowte
//
//  Created by Apple on 16.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKImmediateDataVC.h"

@interface OKImmediateDataVC ()
@property (strong, nonatomic) IBOutlet UITableView *immediateDataTable;
@property (strong, nonatomic) NSArray *tableData;

@end

@implementation OKImmediateDataVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tableData = @[
                       @"Average Age of Patient",
                       @"Male vs. Female",
                       @"BMI",
                       @"Left vs. Right Renal Mass",
                       @"Patients with Cysto/Stent",
                       @"Tumor Size",
                       @"Tumor Characteristics",
                       @"Cases Requiring Adhesiolysis",
                       @"Cases with Vascular Anomoly",
                       @"Intra-Operative Ultra Sound",
                       @"Deep Margins",
                       @"Margins",
                       @"Renal Collecting System Repair",
                       @"Average Clamp Time",
                       @"Coagulants",
                       @"Blood Loss",
                       @"Console Time",
                       @"Room Time",
                       @"Complications",
                       @"Cases Requiring Transfusion",
                       @"Advanced Options"
                       ];
    [self addBottomTabBar];
    _immediateDataTable.backgroundColor = [UIColor clearColor];
    self.immediateDataTable.dataSource = self;
    self.immediateDataTable.delegate = self;
    _immediateDataTable.frame = CGRectMake(_immediateDataTable.frame.origin.x, _immediateDataTable.frame.origin.y, _immediateDataTable.frame.size.width, (_immediateDataTable.frame.size.height - 57.f));
    [self.immediateDataTable reloadData];
}


#pragma mark - IBActions
- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table View methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableData.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"immediateCell";
    OKImmediateDataCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKImmediateDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.immediateDataLabel.text = self.tableData[indexPath.row];
    [cell setCellBGImageLight:(int)indexPath.row];
    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
