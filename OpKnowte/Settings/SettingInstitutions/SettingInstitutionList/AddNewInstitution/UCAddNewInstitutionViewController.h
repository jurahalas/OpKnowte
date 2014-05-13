//
//  UCAddNewInstitutionViewController.h
//  MZUroCapture
//
//  Created by Omer on 5/27/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCAddNewInstitutionViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField *nameTF;
    IBOutlet UITextField *streetAddressTF;
    IBOutlet UITextField *cityTF;
    IBOutlet UITextField *stateTF;
    IBOutlet UITextField *zipTF;
    IBOutlet UITextField *countryTF;
    IBOutlet UITextField *emailTF;
    IBOutlet UITextField *faxTF;
    
    IBOutlet UILabel *headerLbl_;
}

@property (nonatomic,retain) NSString *contactRoleID;
@property (nonatomic,retain) NSString *titleText;;

@property (nonatomic,retain) UCContactInfoModel *contactInfo;
@property (nonatomic,retain) IBOutlet UITextField *nameTF;
@property (nonatomic,retain) IBOutlet UITextField *streetAddressTF;
@property (nonatomic,retain) IBOutlet UITextField *cityTF;
@property (nonatomic,retain) IBOutlet UITextField *stateTF;
@property (nonatomic,retain) IBOutlet UITextField *zipTF;
@property (nonatomic,retain) IBOutlet UITextField *countryTF;
@property (nonatomic,retain) IBOutlet UITextField *emailTF;
@property (nonatomic,retain) IBOutlet UITextField *faxTF;

-(IBAction)submitButtonPressed:(id)sender;
-(IBAction)backButtonPressed:(id)sender;
@end
