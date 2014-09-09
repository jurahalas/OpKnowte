//
//  OKSendFaxManager.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/9/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"

@interface OKSendFaxManager : OKBaseManager
+ (OKSendFaxManager *)instance;

- (void)sendFaxWithUserID:(NSString*) userID Message:(NSString*) message AndFaxNumbers:(NSString*) faxNumbers  AndFaxNumbers2:(NSString*)faxNumbers2 addressList:(NSString*)addressList andNames:(NSString*)namesList  handler:(void(^)(NSString *errorMsg, NSDictionary *json))handler;


@end
