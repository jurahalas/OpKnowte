//
//  OKTimePointsManager.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/18/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"

@interface OKTimePointsManager : OKBaseManager

+ (OKTimePointsManager *)instance;
- (void)getAllTimePointsWithHandler:(void(^)(NSString *errorMsg, NSMutableArray *timePointsArray))handler;

@end
