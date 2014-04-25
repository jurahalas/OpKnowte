//
//  OKOperatieNoteViewController.m
//  OpKnowte
//
//  Created by Olegek on 25.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKOperatieNoteViewController.h"

@interface OKOperatieNoteViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@end

@implementation OKOperatieNoteViewController
@synthesize segmentControl;

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
    
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark IBAction

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)segmentControlButton:(id)sender {
    UIColor *selectedColor = [UIColor colorWithRed: 255/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    UIColor *deselectedColor = [UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    
    for (UIControl *subview in [segmentControl subviews]) {

        if ([subview isSelected]){
            [subview setTintColor:selectedColor];

        }
        else
            [subview setTintColor:deselectedColor];
             }
}

@end
