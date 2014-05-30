//
//  OKProcedureMultiselectVC.m
//  OpKnowte
//
//  Created by Eugene on 05.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureMultiselectVC.h"
#import <QuartzCore/QuartzCore.h>


@interface OKProcedureMultiselectVC ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;

@property (strong, nonatomic) NSString *fieldName;
@property (strong, nonatomic) NSMutableArray *selectedItems;
@property (assign,nonatomic) BOOL isSelected;

- (IBAction)doneTapped:(id)sender;

@end

@implementation OKProcedureMultiselectVC

+(void)showInViewController:(UIViewController*)vc fieldName:(NSString*)fieldName data:(NSArray*)data delegate:(id<OKProcedureMultiselectVCDelegate>)delegate
{
    OKProcedureMultiselectVC *multiselVC = [[OKProcedureMultiselectVC alloc]init];
    multiselVC.tableData = data;
    multiselVC.delegate = delegate;
    multiselVC.fieldName = fieldName;
    multiselVC.view.frame = vc.view.frame;
    multiselVC.view.alpha = 0.0f;
    multiselVC.view.backgroundColor = [UIColor clearColor];
    [vc.view addSubview:multiselVC.view];
    [vc addChildViewController:multiselVC];
    multiselVC.tableView.delegate = multiselVC;
    [UIView animateWithDuration:.25 animations:^{
        multiselVC.view.alpha = 1;
    }];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView.layer.cornerRadius = 10;
    self.selectedItems = [NSMutableArray new];
    _doneButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _doneButton.layer.cornerRadius = 14;
    _doneButton.clipsToBounds = YES;
    _isSelected = NO;

    
}


#pragma mark - tableview datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *item = self.tableData[indexPath.row];
    cell.textLabel.text = item;
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = [self.selectedItems containsObject:item]?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    cell.textColor = [UIColor whiteColor];
    UIView *myBackView = [[UIView alloc] initWithFrame:cell.frame];
    myBackView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = myBackView;
    return cell;
    
}

#pragma mark - tableview delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        [self.selectedItems removeObject:self.tableData[indexPath.row]];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else {
        [self.selectedItems addObject:self.tableData[indexPath.row]];
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


- (IBAction)doneTapped:(id)sender
{
    [self.delegate updateField:self.fieldName WithData:self.selectedItems];
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 0;
    }completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
