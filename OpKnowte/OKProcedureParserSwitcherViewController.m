//
//  OKProcedureParserSwitcherViewController.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/23/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProcedureParserSwitcherViewController.h"

@interface OKProcedureParserSwitcherViewController ()
@property (strong, nonatomic) IBOutlet UILabel *customLabel;
@property (strong, nonatomic) IBOutlet UISwitch *customSwitcher;

@end

@implementation OKProcedureParserSwitcherViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
