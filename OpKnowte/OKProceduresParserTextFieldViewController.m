//
//  OKProceduresParserTextFieldViewController.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/23/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProceduresParserTextFieldViewController.h"

@interface OKProceduresParserTextFieldViewController ()
@property (strong, nonatomic) IBOutlet OKCustomTextField *customTextField;

@end

@implementation OKProceduresParserTextFieldViewController

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
