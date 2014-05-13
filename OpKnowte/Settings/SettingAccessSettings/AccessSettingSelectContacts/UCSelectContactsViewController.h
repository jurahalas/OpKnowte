//
//  UCSelectContactsViewController.h
//  MZUroCapture
//
//  Created by Omer on 5/3/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCSelectContactsViewController : UIViewController
{
    IBOutlet UILabel *headerLbl_;
    IBOutlet UITextField *surgeonsTxt;
    IBOutlet UILabel *surgeonsLbl;
    IBOutlet UITextField *assistantsTxt;
    IBOutlet UILabel *assistantsLbl;
    IBOutlet UITextField *othersTxt;
    IBOutlet UILabel *othersLbl;
}

@property (nonatomic, retain) IBOutlet UIButton *settingsBtn;
@property (nonatomic, retain) IBOutlet UIButton *homeBtn;
@property (nonatomic, retain) IBOutlet UIButton *updateAccessBtn;

@property (nonatomic, retain) NSString *selectedVal;
@property (nonatomic, retain) NSMutableArray *selectedContacts;

@property (nonatomic) int selectedCat;
@property (nonatomic) int prevPage;
@property (nonatomic) BOOL isSelected;
- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)surgeonsButtonPressed:(id)sender;
- (IBAction)assistantsButtonPressed:(id)sender;
- (IBAction)othersButtonPressed:(id)sender;
-(IBAction)SettingsView:(id)sender;
@end
