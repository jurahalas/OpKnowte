//
//  OKSLListCell.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/11/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OKSLListCellDelegate <NSObject>

-(void) openSummaryViewWithModel:(id)model;


@end

@interface OKSLListCell : UITableViewCell
@property (nonatomic, weak) id <OKSLListCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIButton *plusButton;
@property (strong, nonatomic) IBOutlet UILabel *CaseLabel;

@property (strong, nonatomic) id model;
- (IBAction)plusButtonTapped:(id)sender;

@end
