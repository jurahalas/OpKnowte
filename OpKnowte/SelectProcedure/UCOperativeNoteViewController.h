//
//  UCOperativeNoteViewController.h
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/29/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCLRPNPageOneViewController.h"
@interface UCOperativeNoteViewController : UIViewController<UITextViewDelegate> {
    NSMutableArray *varsArray_;
}

@property (strong, nonatomic) NSString *indicationTxt;
@property (strong, nonatomic) NSString *procedureTxt;
@property (strong, nonatomic) UCLRPNPageOneViewController *parent;
@property (strong, nonatomic) IBOutlet UITableView *opTable;
@property (strong, nonatomic) IBOutlet UIWebView *indicationWV;
@property (strong, nonatomic) IBOutlet UIButton *caseDataBtn;
@property (strong, nonatomic) IBOutlet UIButton *indicatonBTn;
@property (strong, nonatomic) IBOutlet UIButton *procedureBtn;
@property (strong, nonatomic) IBOutlet UITextView *procedureTV;
@property (strong, nonatomic) IBOutlet UITableView *prTable;
@property (strong, nonatomic) IBOutlet UIImageView *bottomBar;
@property (strong, nonatomic) IBOutlet UIButton *prOneBtn;
@property (strong, nonatomic) IBOutlet UIButton *prTwoBtn;
@property (strong, nonatomic) IBOutlet UIButton *prThreeBtn;
@property (strong, nonatomic) IBOutlet UIButton *prFourBtn;
@property (strong, nonatomic) IBOutlet UIButton *prFiveBtn;
@property (strong, nonatomic) IBOutlet UIButton *fwdBtn;
@property (strong, nonatomic) NSMutableArray *tableArray;
@property (strong, nonatomic) NSMutableArray *templateVariables;
@property (strong, nonatomic) NSMutableArray *caseDataArray;
@property (strong, nonatomic) UCTemplateResponseModel *templateModel;
@property (nonatomic, retain) NSMutableArray *CCContacts;

@property (strong, nonatomic) id parentModel;



- (void)loadCaseData;


- (IBAction)opNoteSegmentControl:(UIButton *)sender;
- (IBAction)SettingsView:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)homeButtonPressed:(id)sender;

@end
