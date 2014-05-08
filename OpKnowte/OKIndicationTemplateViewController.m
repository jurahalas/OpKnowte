//
//  OKIndicationTemplateViewController.m
//  OpKnowte
//
//  Created by Olegek on 07.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKIndicationTemplateViewController.h"

@interface OKIndicationTemplateViewController ()
@property (strong, nonatomic) IBOutlet UILabel *indicationLabel;

@end

@implementation OKIndicationTemplateViewController
@synthesize indicationLabel;

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
    [self labelText];
}

-(void)labelText
{
    NSString *labelText = [NSString stringWithFormat:@"smth Text We then introduced 5 additional ports across the abdomen. One 8mm robotic port was placed one handbreath to either side of the midline port. Two handbreaths to the left, an additional 8mm robotic port was placed for the 4th arm assistant port. Two handbreaths to the right a 12mm bedside port was placed and pre-mptively an 0 vicryl was placed via the Carter-Thomason technique. Lastly a 5mm secondary bedside assistant port was placed to triangulate the ports on the right side of the abdomen."];
    
    indicationLabel.text = labelText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}


@end
