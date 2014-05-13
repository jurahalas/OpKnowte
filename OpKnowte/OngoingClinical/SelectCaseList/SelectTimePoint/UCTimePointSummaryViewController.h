//
//  UCTimePointSummaryViewController.h
//  MZUroCapture
//
//  Created by Atif Joyia on 18/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "UCTWTPPageOneViewController.h"
#import "UCSixMonthTimePointViewController.h"

@interface UCTimePointSummaryViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, EGORefreshTableHeaderDelegate, UIAlertViewDelegate>
{
    IBOutlet UILabel *headerLbl_;
    EGORefreshTableHeaderView *refreshHeaderView_;
    BOOL _reloading;
}

@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (nonatomic, retain) NSString *timePoint;
@property (nonatomic, retain) NSMutableDictionary *sixMonthsDict;
@property (nonatomic, retain) NSString *caseID;
@property (nonatomic, retain) NSString *timePointID;
@property (nonatomic, retain) NSDictionary *timePointDictionary;
@property (nonatomic, retain) NSMutableDictionary *summaryDictionary;
@property (nonatomic, retain) NSMutableDictionary *caseData;
@property (nonatomic, retain) NSArray *tableArray;
@property (nonatomic, retain) IBOutlet UITableView *summaryTable;


- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
