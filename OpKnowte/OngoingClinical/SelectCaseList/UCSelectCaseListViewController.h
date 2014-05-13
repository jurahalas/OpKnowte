//
//  UCSelectCaseListViewController.h
//  MZUroCapture
//
//  Created by Omer on 5/9/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCSelectTimePointViewController.h"

@interface UCSelectCaseListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    IBOutlet UITableView *tableview;
    IBOutlet UILabel *headerLbl_;
    NSMutableArray *cases;
    //NSMutableArray *dates;
}
@property (nonatomic) BOOL isReminderSetting;
@property (nonatomic) BOOL fromSettings;
@property (nonatomic, retain) NSMutableArray *cases;

- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
-(IBAction)SettingsView:(id)sender;
@end
