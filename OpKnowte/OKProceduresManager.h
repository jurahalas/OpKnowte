//
//  OKProceduresManager.h
//  OpKnowte
//
//  Created by Apple on 15.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"

@interface OKProceduresManager : OKBaseManager

+ (OKProceduresManager *)instance;

- (void)getAllProceduresWithId:(NSInteger)procedureId text:(NSString*)text abbreviation:(NSString*)abbreaviation handler:(void(^)(NSString *errorMsg))handler;;

@end
