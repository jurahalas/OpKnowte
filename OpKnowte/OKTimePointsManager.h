//
//  OKTimePointsManager.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/18/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"

@class OKTimePointModel;

@interface OKTimePointsManager : OKBaseManager

@property (nonatomic, strong) OKTimePointModel *selectedTimePoint;

+ (void)getAllTimePoints:(void(^)(NSString *errorMsg, id responseJSON))handler;

- (void)getAllTimePointsWithHandler:(void(^)(NSString *errorMsg, NSArray *timePointsArray))handler;

@end
