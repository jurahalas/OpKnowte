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
    OKProcedureTextField *vc = [[OKProcedureTextField alloc] initWithFrame:CGRectMake(0, 200, 320, 43)];
    
    OKProcedureTextField *vc2 = [[OKProcedureTextField alloc] initWithFrame:CGRectMake(0, 300, 320, 43)];

    [self.view addSubview:vc.view];
    [self.view addSubview:vc2.view];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
