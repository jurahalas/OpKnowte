//
//  OKLoadingViewController.m
//  OpKnowte
//
//  Created by Apple on 17.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKLoadingViewController.h"
#import "OKAppDelegate.h"

#define DELEGATE ((OKAppDelegate*)[[UIApplication sharedApplication] delegate])

@interface OKLoadingViewController ()

@property (strong, nonatomic) IBOutlet UILabel *loadingLabel;

@end

@implementation OKLoadingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


+ (OKLoadingViewController*) instance {
    static OKLoadingViewController* instance = nil;
    if (instance == nil) {
        instance = [[OKLoadingViewController alloc] initWithNibName:@"OKLoadingViewController" bundle:nil];
    }
    return instance;
}


- (void)showWithText:(NSString*)text
{
    [self showInView:[DELEGATE topViewController].navigationController.topViewController.view withText:text];
    [self showInView:[[UIApplication sharedApplication] keyWindow] withText:text];

}


- (void)showInView:(UIView*)view withText:(NSString*)text
{
    if (self.view.superview != nil) {
        [self hide];
    }
    CGRect newFrame = view.bounds;
    newFrame.origin.y = 0;
    self.view.frame = newFrame;
    [view addSubview:self.view];
    self.loadingLabel.text = text;
}


- (void)hide
{
    [self.view removeFromSuperview];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4f];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end