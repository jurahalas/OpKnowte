//
//  OKInfoViewController.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/17/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKInfoViewController.h"

@interface OKInfoViewController ()
@property (strong, nonatomic) IBOutlet UILabel *infoTextLabel;
@property (strong, nonatomic) IBOutlet UIButton *continueButton;

@end

@implementation OKInfoViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES ];
    NSString *infoText = [NSString stringWithFormat:@"This application will allow for easy capture of\n anonymous surgical data via dictated and\n manual entry. The application will be HIPPA\n compilant and password protected. The\n software will allow for queries and analysis of\n outcomes. The owner will have the option of\n participating in a nationalized/globalized\n database that will allow for bench-marking. In\n addition the owners will be able to request\n that their datalog be shared with hospital\n credentialing services and boards of\n certification. the national pooled database\n will be a valuable resource for defining\n acceptable outcomes and defining\n benchmarks for quality of care."];
    _infoTextLabel.text = infoText;
    
    _continueButton.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _continueButton.layer.cornerRadius = 14;
    _continueButton.clipsToBounds = YES;
    
    

}
- (IBAction)continueButtonTapped:(id)sender {
    if ([_cameFromVC isEqualToString:@"LogoTBButton"]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self performSegueWithIdentifier:@"fromInfoViewToDashboard" sender:nil];
    }

}
-(void)viewWillAppear:(BOOL)animated{
    
     [self.navigationController setNavigationBarHidden:YES animated:YES ];
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
