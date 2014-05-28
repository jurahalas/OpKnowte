//
//  OKSLListCell.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/11/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OKSLListCellDelegate <NSObject>

//-(void) addModelToList:(id)model;
//-(void) deleteModelFromList:(id)model;

@end

@interface OKSLListCell : UITableViewCell
@property (nonatomic, weak) id <OKSLListCellDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIButton *plusButton;

@property (strong, nonatomic) id model;
@property (nonatomic) BOOL buttonIsTapped;
- (IBAction)plusButtonTapped:(id)sender;
-(void) setCellButtonBGImageWithGreenMinusIcon:(BOOL) minusIcon;
@end
