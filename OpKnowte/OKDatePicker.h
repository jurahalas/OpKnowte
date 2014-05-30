//
//  OKDatePicker.h
//  OpKnowte
//
//  Created by Eugene on 05.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OKDatePickerProtocol <NSObject>

-(void) addDataToTFAndHideIt;

@end

@interface OKDatePicker : UIControl
@property (nonatomic, weak) id <OKDatePickerProtocol> delegate;
@property (nonatomic, retain, readwrite) NSDate *minimumDate;
@property (nonatomic, retain, readwrite) NSDate *maximumDate;
@property (nonatomic, assign, readwrite) NSDate *date;

- (void)setDate:(NSDate *)date animated:(BOOL)animated;
- (void)setTextColor:(UIColor*)textColor;

@end
