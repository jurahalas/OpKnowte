//
//  OKProceduresManager.h
//  OpKnowte
//
//  Created by Apple on 15.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"

#import "OKProcedureModel.h"

@interface OKProceduresManager : OKBaseManager

@property (nonatomic, strong) OKProcedureModel *selectedProcedure;

- (void)getAllProceduresWithHandler:(void(^)(NSString *errorMsg, NSMutableArray *proceduresDict ) )handler;

+ (void)doProceduresRequest:(void(^)(NSString *errorMsg, id responseJSON))handler;

@end
