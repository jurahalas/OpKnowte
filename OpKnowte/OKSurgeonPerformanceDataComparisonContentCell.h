//
//  OKSurgeonPerformanceDataComparisonContentCell.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/22/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OKSurgeonPerformanceDataComparisonContentCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet UILabel *bloodLossLabel;
@property (strong, nonatomic) IBOutlet UILabel *sampleSizeLabel;
-(void) setLabelsWithData:(NSString*) data bloodLoss:(NSString*) bloodLoss sampleSize:(NSString*) sampleSize;
@end
