//
//  UCSendEmailToIstitutions.h
//  MZUroCapture
//
//  Created by Atif Joyia on 24/05/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "UCLRPNPageOneViewController.h"

@interface UCSendEmailToIstitutions : UIViewController<MFMailComposeViewControllerDelegate>{
    BOOL emailSent;
}

@property (nonatomic, retain) IBOutlet UILabel *headerLbl;
@property (nonatomic, retain) IBOutlet UIButton *sendBtn;
@property (nonatomic, retain) IBOutlet UITableView *institutionTable;

@property (nonatomic, retain) NSMutableArray *contactsArray;
@property (nonatomic, retain) NSMutableArray *emailsArray;
@property (nonatomic, retain) NSMutableArray *faxArray;
@property (nonatomic, retain) NSMutableArray *CCArray;

@property (strong, nonatomic) UCLRPNPageOneViewController *parent;
@property (strong, nonatomic) NSMutableArray *caseDataArray;
@property (strong, nonatomic) NSString *indicationText;
@property (strong, nonatomic) NSString *procedureText;

- (BOOL) containsString:(NSArray *)arrayOfStrings object:(NSString *)str;


@end
