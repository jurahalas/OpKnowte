//
//  OKListCell.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/25/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIButton *plusButton;
@property (strong, nonatomic) IBOutlet UILabel *CaseLabel;
@property (nonatomic) BOOL buttonIsTapped;
- (IBAction)plusButtonTapped:(id)sender;

@end
