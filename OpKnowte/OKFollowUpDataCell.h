//
//  OKFollowUpDataCell.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/15/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OKFollowUpDataCellDelegate <NSObject>

-(void) openSummaryViewWithModel:(id)model;

@end

@interface OKFollowUpDataCell : UITableViewCell
@property (nonatomic, weak) id <OKFollowUpDataCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIButton *plusButton;

@property (strong, nonatomic) id model;
- (IBAction)plusButtonTapped:(id)sender;

@end
