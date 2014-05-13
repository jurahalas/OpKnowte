//
//  UCSelectProcedureViewController.h
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/12/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCSelectProcedureCell.h"
//#import "UCWebServerHandler.h"
#import "UCProcedureResponseModel.h"
#import "UCDataCaptureViewController.h"
#import "UCSurgeonPerformanceFilter.h"
#import "UCSurgeonPerformanceCaseList.h"
#import "UCNationalPerformanceCaseList.h"

@interface UCSelectProcedureViewController : UIViewController <UIAlertViewDelegate>{
    
    IBOutlet UIButton *overlayLayout_;
    IBOutlet UIActivityIndicatorView *activityIndicator_;
    UCDataCaptureViewController *home;
    
}

@property int no_of_setting;
@property BOOL fromSettings;
@property BOOL fromOngoingClinical;

@property (nonatomic) BOOL isFilter;
@property (nonatomic) BOOL isSurgeonFilter;
@property (nonatomic, retain) UCSurgeonPerformanceFilter *filter;
@property (nonatomic) BOOL isNationalFilter;
@property (nonatomic, retain) UCNationalPerformanceCaseList *nationalFilter;
@property (nonatomic, retain) UCSurgeonPerformanceCaseList *surgeonFilter;
@property (strong, nonatomic) IBOutlet UITableView *procedureTableView;
@property (strong, nonatomic) NSMutableArray *accessContacts;
@property (strong, nonatomic) NSMutableArray *procedures;
@property (strong, nonatomic) UCDataCaptureViewController *home;

- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)backButtonPressed:(id)sender;
- (IBAction)SettingsView:(id)sender;

@end
