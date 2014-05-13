//
//  UCSettingselectProcedureViewController.h
//  MZUroCapture
//
//  Created by Jawad ali on 4/27/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCSettingselectProcedureViewController : UIViewController
{
     IBOutlet UILabel * l_Header;
}
@property int no_of_setting;
@property(nonatomic,retain) IBOutlet UILabel * l_Header;

- (IBAction)homeButtonPressed:(id)sender;

- (IBAction)backButtonPressed:(id)sender;

-(IBAction)buttonPressed:(UIButton *)sender;

@end
