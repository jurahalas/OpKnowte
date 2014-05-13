//
//  UCSurgeonPerformanceTwoWeeks.h
//  MZUroCapture
//
//  Created by Atif Joyia on 20/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCSurgeonPerformanceTwoWeeks : UIViewController<UIScrollViewDelegate>
{
    IBOutlet UILabel * l_Header;
}

@property (nonatomic) int totalSurgeonCount;
@property (nonatomic) int totalNationalCount;
@property (nonatomic) int totalCount;
@property (nonatomic, retain) NSMutableArray *performanceCases;
@property (nonatomic, retain) NSMutableArray *surgeonCases;
@property (nonatomic) BOOL isNational;
@property (nonatomic, retain) IBOutlet UIScrollView *scroller;

-(IBAction)complications:(id)sender;
- (IBAction)SettingsView:(id)sender;
-(IBAction)home:(id)sender;
@end
