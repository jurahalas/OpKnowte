//
//  OKCaseDataTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 08.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKCaseDataTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *caseDataLabel;
@property (strong, nonatomic) IBOutlet UIButton *caseDataButton;
- (IBAction)caseDataButton:(id)sender;
@property (nonatomic) BOOL buttonIsTapped;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;
@end
