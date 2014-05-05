//
//  OKProcedureMultiselectVC.m
//  OpKnowte
//
//  Created by Eugene on 05.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureMultiselectVC.h"

@interface OKProcedureMultiselectVC ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *fieldName;
@property (strong, nonatomic) NSMutableArray *selectedItems;

- (IBAction)doneTapped:(id)sender;

@end

@implementation OKProcedureMultiselectVC

+(void)showInViewController:(UIViewController*)vc fieldName:(NSString*)fieldName data:(NSArray*)data delegate:(id<OKProcedureMultiselectVCDelegate>)delegate
{
    OKProcedureMultiselectVC *multiselVC = [[OKProcedureMultiselectVC alloc]init];
    multiselVC.tableData = data;
    multiselVC.delegate = delegate;
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
    self.selectedItems = [NSMutableArray new];
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
    cell.accessoryType = [self.selectedItems containsObject:item]?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark - tableview delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.selectedItems addObject:self.tableData[indexPath.row]];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    // Dispose of any resources that can be recreated.
}

@end
