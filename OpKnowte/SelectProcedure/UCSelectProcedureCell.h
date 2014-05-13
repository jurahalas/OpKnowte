//
//  UCSelectProcedureCell.h
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/12/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCProcedureModel.h"
@interface UCSelectProcedureCell : UITableViewCell
{
    BOOL isSelected_;
    UCProcedureModel *procedureModel;
}
@property (strong, nonatomic) IBOutlet UIButton *checkBtn;
- (IBAction)checkBtnPressed:(id)sender;
@property (strong,nonatomic)IBOutlet UILabel *label;
@property (nonatomic)BOOL isSelected;
-(void) loadCellContent:(UCProcedureModel*)model;
@end
