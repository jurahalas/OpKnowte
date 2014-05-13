//
//  UCSettingInstitutionListViewController.h
//  MZUroCapture
//
//  Created by Omer on 5/8/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCSettingInstitutionsViewController.h"

@interface UCSettingInstitutionListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    IBOutlet UITableView *tableview;
    IBOutlet UILabel *headerLbl_;
    NSMutableArray *institutions;
    NSMutableArray *emails;
   // UIAlertView *alertView;
    UITextField *nameField;
    NSString *listName;
}
@property (nonatomic, retain) NSString *listName;
@property (nonatomic, retain) NSMutableArray *institutions;
@property (nonatomic, retain) NSMutableArray *selectedInstitutes;
@property (nonatomic) BOOL isOpNote;
@property (nonatomic, retain) UCSettingInstitutionsViewController *parent;
@property (nonatomic, retain) IBOutlet UIButton *fwdButton;
@property (nonatomic, retain) IBOutlet UIButton *settingButton;
@property (nonatomic, retain) IBOutlet UIButton *homeButton;
@property (nonatomic, retain) IBOutlet UIButton *backButton;

- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)addButtonPressed:(id)sender;
- (IBAction)removeButtonPressed:(id)sender;
-(void)saveButtonPressed:(id)sender;
-(void)cancelButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
-(IBAction)SettingsView:(id)sender;
@end
