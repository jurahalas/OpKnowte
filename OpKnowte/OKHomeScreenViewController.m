//
//  OKHomeScreenViewController.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/9/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKHomeScreenViewController.h"


@interface OKHomeScreenViewController ()

@end

@implementation OKHomeScreenViewController

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
    [self addBottomTabBar];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
