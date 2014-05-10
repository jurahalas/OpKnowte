//
//  OKCaseDataTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 08.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKProcedureTemplateVariablesModel.h"

@protocol OKCaseDataTableViewCellDelegate <NSObject>

-(void) addVariableToTemplate:(OKProcedureTemplateVariablesModel*)contact;
-(void) deleteVariableFromTemplate:(OKProcedureTemplateVariablesModel*)contact;

@end


@interface OKCaseDataTableViewCell : UITableViewCell
@property (nonatomic, weak) id <OKCaseDataTableViewCellDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *caseDataLabel;
@property (strong, nonatomic) IBOutlet UIButton *caseDataButton;
@property (strong, nonatomic) OKProcedureTemplateVariablesModel *variableModel;
- (IBAction)caseDataButton:(id)sender;
@property (nonatomic) BOOL buttonIsTapped;

-(void) setCellUserIntaractionDisabled;
-(void) setCellUserIntaractionEnabled;
-(void) setCellBGImageLight:(int) cellCount;
-(void) setCellButtonBGImageWithGreenMinusIcon:(BOOL) minusIcon;
@end
