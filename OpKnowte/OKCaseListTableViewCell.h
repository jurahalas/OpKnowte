//
//  OKCaseListTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 28.08.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKCase.h"

@protocol OKCaseDelegate <NSObject>

-(void) addCaseToArray:(OKCase*)contact;
-(void) deleteCaseFromArray:(OKCase*)contact;

@end

@interface OKCaseListTableViewCell : UITableViewCell

@property (nonatomic, weak) id <OKCaseDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *caseName;
@property (strong, nonatomic) IBOutlet UIButton *plusButton;
@property (nonatomic) BOOL buttonIsTapped;
@property (nonatomic, strong) OKCase *caseModel;

-(void) setCellBGImageLight:(int) cellCount;
-(void) setCellButtonBGImageWithGreenMinusIcon:(BOOL) minusIcon;

- (IBAction)plusButtonTapped:(id)sender;

@end
