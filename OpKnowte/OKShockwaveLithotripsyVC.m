//
//  OKShockwaveLithotripsyVC.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/24/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKShockwaveLithotripsyVC.h"
#import "OKProcedureTextField.h"

@interface OKShockwaveLithotripsyVC ()
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (nonatomic,strong) NSArray *plistArray;
@end

@implementation OKShockwaveLithotripsyVC

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
    _plistArray = [[NSArray alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SLProcedure" ofType:@"plist"]];
    
    [self setCurrentPage:0];
    
    for (int i = 0; i<[[[_plistArray objectAtIndex:[self getCurrentPage]] objectForKey:@"fields" ]count] ; i++) {

    }
    
    OKProcedureTextField *vc = [[OKProcedureTextField alloc] initWithFrame:CGRectMake(0, 200, 320, 43)];
    
    OKProcedureTextField *vc2 = [[OKProcedureTextField alloc] initWithFrame:CGRectMake(0, 300, 320, 43)];

    [self.view addSubview:vc.view];
    [self.view addSubview:vc2.view];

}
#pragma mark - IBActions
- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextButton:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
