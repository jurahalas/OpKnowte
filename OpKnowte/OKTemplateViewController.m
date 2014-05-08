//
//  OKTemplateViewController.m
//  OpKnowte
//
//  Created by Olegek on 02.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKTemplateViewController.h"
#import "OKTemplateTableViewCell.h"

@interface OKTemplateViewController ()
@property (strong, nonatomic) IBOutlet UITableView *templateTableView;

@end

@implementation OKTemplateViewController
@synthesize templateTableView;

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
    
    templateTableView.backgroundColor = [UIColor clearColor];
    self.templateTableView.dataSource = self;
    self.templateTableView.delegate = self;
    templateTableView.frame = CGRectMake(templateTableView.frame.origin.x, templateTableView.frame.origin.y, templateTableView.frame.size.width, (templateTableView.frame.size.height - 57.f));
    [self.templateTableView reloadData];
}
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"template";
    OKTemplateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKTemplateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSMutableArray *dataTitleArray = [[NSMutableArray alloc] initWithObjects:
                                      @"Case Data",
                                      @"Indications",
                                      @"Procedures",nil];
    
    cell.templateLable.text = [dataTitleArray objectAtIndex:indexPath.row];
    [cell setCellBGImageLight:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OKTemplateTableViewCell *cell = [[OKTemplateTableViewCell alloc] init];
    cell = (OKTemplateTableViewCell*)[templateTableView cellForRowAtIndexPath:indexPath];
    if ([cell.templateLable.text  isEqualToString:@"Procedures"])
    {
        [self performSegueWithIdentifier:@"procedures" sender:indexPath];
    }else if ([cell.templateLable.text isEqualToString:@"Indications"]){
        [self performSegueWithIdentifier:@"indication" sender:indexPath];
    }
    

}

@end
