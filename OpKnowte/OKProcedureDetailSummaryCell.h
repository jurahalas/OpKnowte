//
//  OKProcedureDetailSummaryCell.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/18/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKProcedureDetailSummaryCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *procedureKeyLabel;
@property (strong, nonatomic) IBOutlet UILabel *procedureValueLabel;
-(void) setLabels;
@end
