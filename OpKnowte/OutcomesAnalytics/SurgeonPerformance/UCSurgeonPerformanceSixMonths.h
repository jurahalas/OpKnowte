//
//  UCSurgeonPerformanceSixMonths.h
//  MZUroCapture
//
//  Created by Atif Joyia on 20/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCSurgeonPerformanceSixMonths : UIViewController
{
    IBOutlet UILabel * l_Header;
}

@property (nonatomic) int totalSurgeonCount;
@property (nonatomic) int totalNationalCount;
@property (nonatomic) int totalCount;
@property (nonatomic) int timepointID;
@property (nonatomic, retain) NSMutableArray *performanceCases;
@property (nonatomic, retain) IBOutlet UIScrollView *scroller;
@property (nonatomic, retain) NSMutableArray *surgeonCases;
@property (nonatomic) BOOL isNational;


-(IBAction)xray:(id)sender;
-(IBAction)Liver:(id)sender;
-(IBAction)Hernia:(id)sender;
-(IBAction)CTScan:(id)sender;
@end
