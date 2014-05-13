//
//  UCSurgeonPerformanceViewController.h
//  MZUroCapture
//
//  Created by Omer on 6/28/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCSurgeonPerformanceViewController : UIViewController
{
    IBOutlet UILabel * l_Header;
    IBOutlet UIButton *outcomeData;
    IBOutlet UILabel *outcomeDataLbl;
    IBOutlet UIButton *immediatePostOp;
    IBOutlet UILabel *immediatePostOpLbl;
}
-(IBAction)back:(id)sender;
-(IBAction)OutcomeDataSearch:(id)sender;
-(IBAction)PostOpData:(id)sender;
- (IBAction)SettingsView:(id)sender;
- (IBAction)home:(id)sender;
@end
