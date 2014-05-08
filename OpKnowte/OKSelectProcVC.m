//
//  OKSelectProcVC.m
//  OpKnowte
//
//  Created by Apple on 07.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKSelectProcVC.h"

@interface OKSelectProcVC ()

@property (strong, nonatomic) IBOutlet UITableView *selectProcTableView;
@end

@implementation OKSelectProcVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self addBottomTabBar];
    _selectProcTableView.backgroundColor = [UIColor clearColor];
    self.selectProcTableView.dataSource = self;
    self.selectProcTableView.delegate = self;
    _selectProcTableView.frame = CGRectMake(_selectProcTableView.frame.origin.x, _selectProcTableView.frame.origin.y, _selectProcTableView.frame.size.width, (_selectProcTableView.frame.size.height - 57.f));
    [self.selectProcTableView reloadData];
    
}


- (IBAction)backButton:(id)sender
{
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
    static NSString *cellIdentifier = @"select";
    OKSelectProcTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[OKSelectProcTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
       [cell setCellBGImageLight:1];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"toSelectProc" sender:nil];
    NSLog(@"cell tapped");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
