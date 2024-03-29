//
//  OKIntraOperativeDataTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 15.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OKIntraOperativeProtocol <NSObject>

-(void) openSummaryViewWithModel:(id)model;

@end

@interface OKIntraOperativeDataTableViewCell : UITableViewCell

@property (nonatomic, weak) id <OKIntraOperativeProtocol> delegate;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIButton *plusButton;
@property (strong, nonatomic) IBOutlet UILabel *CaseLabel;


@property (strong, nonatomic) id model;
- (IBAction)plusButtonTapped:(id)sender;

@end