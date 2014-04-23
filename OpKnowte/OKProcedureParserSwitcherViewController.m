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
@property (nonatomic, strong) NSString *fieldName;

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
-(void)setFieldName:(NSString*)name{
    _fieldName = name;
}
-(void)setPlaceHolder:(NSString*)placeHolder{
    _customLabel.text = placeHolder;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)switcherAction:(id)sender {
    if (_customSwitcher.on) {
        // switcher on
    } else {
        //switcher off
    }
}

@end
