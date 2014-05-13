//
//  UCContactsListViewController.h
//  MZUroCapture
//
//  Created by Omer on 5/3/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCSendEmailToIstitutions.h"
#import "UCSettingReminderSettingsViewController.h"
#import "UCSelectContactsViewController.h"

@interface UCContactsListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIAlertViewDelegate>
{
    IBOutlet UITableView *tableview;
    IBOutlet UILabel *headerLbl_;
    NSMutableArray *assistants;
    NSMutableArray *emails;
    //UIAlertView *alertView;
    UITextField *nameField;
    UITextField *emailField;
    int prevPage;
    
    
    IBOutlet UIButton *overlayLayout;
    
//    UCWebServerHandler *serviceHandler;
//    UCWebServerHandler *serviceHandler2;
}
@property (nonatomic) int selectedCat;
@property (nonatomic, retain) NSMutableArray *assistants;
@property (nonatomic, retain) UCSendEmailToIstitutions *parent;
@property (nonatomic, retain) UCSelectContactsViewController *accessParent;
@property (nonatomic, retain) UCSettingReminderSettingsViewController *reminderParent;
@property (nonatomic, strong) NSMutableArray *selectedList;


- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)addButtonPressed:(id)sender;
- (IBAction)removeButtonPressed:(id)sender;
- (void)saveButtonPressed:(id)sender;
- (void)cancelButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)SettingsView:(id)sender;
- (BOOL)containsContactObject:(NSMutableArray *)contactsArray andContact:(UCContactInfoModel *)obj;
@end
