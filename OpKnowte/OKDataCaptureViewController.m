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
    self.tableData = @[@"Immediate Post-Operative",
                       @"Ongoing Clinical"];
    [self addBottomTabBar];
    dataCapture.backgroundColor = [UIColor clearColor];
    self.dataCapture.dataSource = self;
    self.dataCapture.delegate = self;
    dataCapture.frame = CGRectMake(dataCapture.frame.origin.x, dataCapture.frame.origin.y, dataCapture.frame.size.width, (dataCapture.frame.size.height - 57.f));
    [self.dataCapture reloadData];
}


#pragma mark - IBActions
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table View methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OKDataCaptureTableViewCell *cell = (OKDataCaptureTableViewCell *)[dataCapture cellForRowAtIndexPath:indexPath];
    if ([cell.dataCaptureLable.text isEqualToString:@"Immediate Post-Operative"]) {
        [self performSegueWithIdentifier:@"fromDataCaptureToSelectProcedure" sender:self];
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"dataCapture";
    OKDataCaptureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OKDataCaptureTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.dataCaptureLable.text = self.tableData[indexPath.row];
    [cell setCellBGImageLight:(int)indexPath.row];
    return cell;
}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self performSegueWithIdentifier:@"selectProcedure" sender:indexPath];
//}


//#pragma mark - prepare for segue
//
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if([segue.identifier isEqualToString:@"selectProcedure"]){
//        OKSelectProcedureViewController *vc = (OKSelectProcedureViewController*)segue.destinationViewController;
//    }
//}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
