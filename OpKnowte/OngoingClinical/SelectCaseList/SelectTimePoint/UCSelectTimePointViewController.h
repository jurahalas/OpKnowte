//
//  UCSelectTimePointViewController.h
//  MZUroCapture
//
//  Created by Omer on 5/9/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCSixMonthTimePointViewController.h"

@interface UCSelectTimePointViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UILabel *headerLbl_;
}
@property (nonatomic) int totalCount;
@property (nonatomic) int totalSurgeonCount;
@property (nonatomic) int totalNationalCount;
@property (nonatomic, retain) NSMutableDictionary *caseData;
@property (nonatomic, retain) NSMutableArray *timePoints;
@property (nonatomic, retain) NSDictionary *timePoint;
@property (nonatomic, retain) NSMutableArray *performanceCases;
@property (nonatomic) BOOL isFilter;
@property (nonatomic) BOOL isNationalFilter;
@property (nonatomic, retain) NSMutableArray *surgeonCases;
@property (nonatomic, retain) IBOutlet UITableView *timePointsTable;
@property (nonatomic, retain) NSMutableDictionary *onGoingData;

@property (nonatomic, retain) NSMutableArray *totlaNationalCases;
@property (nonatomic, retain) NSMutableArray *totalSurgeonCases;


- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
-(IBAction)SettingsView:(id)sender;
-(IBAction)weeklyButtonPressed:(id)sender;
-(IBAction)monthlyButtonPressed:(id)sender;
@end
