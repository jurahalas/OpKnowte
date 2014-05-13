//
//  UCProcedureDetailSummaryPage.h
//  MZUroCapture
//
//  Created by Atif Joyia on 09/07/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCProcedureDetailSummaryPage : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UILabel *headerLbl_;
}

@property (nonatomic, retain) UCLRPNModel *model;
@property (nonatomic, retain) NSMutableDictionary *caseData;
@property (nonatomic, retain) IBOutlet UITableView *summaryTable;
@property (nonatomic, retain) NSMutableArray *templateVariables;
- (IBAction)SettingsView:(id)sender;
- (IBAction)home:(id)sender;
@end
