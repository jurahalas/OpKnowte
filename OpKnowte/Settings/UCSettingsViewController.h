//
//  UCSettingsViewController.h
//  MZUroCapture
//
//  Created by Jawad ali on 4/26/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCSettingsViewController : UIViewController
{
    
}

@property (nonatomic, retain) IBOutlet UIScrollView *scroller;

- (IBAction)homeButtonPressed:(id)sender;

- (IBAction)backButtonPressed:(id)sender;

-(IBAction)buttonPressed:(UIButton *)sender;


@end
