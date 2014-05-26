//
//  OKDataCaptureViewController.m
//  OpKnowte
//
//  Created by Olegek on 25.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKDataCaptureViewController.h"
#import "OKSelectProcedureViewController.h"

@interface OKDataCaptureViewController ()

@property (strong, nonatomic) IBOutlet UITableView *dataCapture;
@property (strong, nonatomic) NSArray *tableData;

@end

@implementation OKDataCaptureViewController
@synthesize dataCapture;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tableData = @[@"Immediate Post-Operative",
                       @"Ongoing Clinical"];
    [self addBottomTabBar];
    dataCapture.backgroundColor = [UIColor clearColor];
    self.dataCapture.dataSource = self;
    self.dataCapture.delegate = self;
    dataCapture.frame = CGRectMake(dataCapture.frame.origin.x, dataCapture.frame.origin.y, dataCapture.frame.size.width, (dataCapture.frame.size.height - 57.f));
    [self.dataCapture reloadData];
    if (!IS_IOS7) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
	// Do any additional setup after loading the view.
}
-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width+27, [UIImage imageNamed:@"back"].size.height );
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
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
    [self performSegueWithIdentifier:@"fromDataCaptureToSelectProcedure" sender:[NSString stringWithFormat:@"%d",indexPath.row]];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"fromDataCaptureToSelectProcedure"]){
        if ([sender isEqualToString:@"0"]) {
            OKSelectProcedureViewController *sharVC = (OKSelectProcedureViewController*)segue.destinationViewController;
            sharVC.cameFromVC = @"ImmediatePostOperative";

        }
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"dataCapture";
    OKDataCaptureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKDataCaptureTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.dataCaptureLable.text = self.tableData[indexPath.row];
    [cell setCellBGImageLight:(int)indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
