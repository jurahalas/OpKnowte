//
//  OKIntraOperativeDataTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 15.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OKIntraOperativeProtocol <NSObject>

-(void) addModelToList:(id)model;
-(void) deleteModelFromList:(id)model;

@end

@interface OKIntraOperativeDataTableViewCell : UITableViewCell

@property (nonatomic, weak) id <OKIntraOperativeProtocol> delegate;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIButton *plusButton;
@property (strong, nonatomic) id model;
@property (nonatomic) BOOL buttonIsTapped;

- (IBAction)plusButtonTapped:(id)sender;
-(void) setCellButtonBGImageWithGreenMinusIcon:(BOOL) minusIcon;
@end
