//
//  OKOperatieNoteTableViewCell.h
//  OpKnowte
//
//  Created by Olegek on 26.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKOperatieNoteTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *caseDataKeyLabel;
@property (strong, nonatomic) IBOutlet UILabel *caseDataValueLabel;
-(void)setLabels;
@end
