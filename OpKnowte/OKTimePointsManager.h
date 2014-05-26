//
//  OKTimePointsManager.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/18/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"
#import "OKTimePointModel.h"

@interface OKTimePointsManager : OKBaseManager

@property (nonatomic, strong) OKTimePointModel *selectedTimePoint;

+ (OKTimePointsManager *)instance;

- (void)getAllTimePointsWithHandler:(void(^)(NSString *errorMsg, NSArray *timePointsArray))handler;

@end
