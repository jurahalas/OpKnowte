//
//  OKWebServerManager.h
//  OpKnowte
//
//  Created by Eugene on 08.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseManager.h"

@interface OKWebServerManager : OKBaseManager

+ (void)getNationalDates:(void(^)(NSString *errorMsg, id responseJSON ))handler;

+ (void)getNationalPerformancData:(NSString *)procedureID fromTime:(NSString *)fromDate toTime:(NSString *)toDate handler:(void(^)(NSString *errorMsg, id responseJSON ))handler;

+ (void)getSurgeonPerformanceData:(NSString *)procedureID fromTime:(NSString *)fromDate toTime:(NSString *)toDate fromRecordNum:(NSString *)fromCase toRecordNum:(NSString *)toCase handler:(void(^)(NSString *errorMsg, id responseJSON ))handler;

+(void)sendFaxWithText:(NSString *)text faxNumber:(NSString *)faxNumb handler:(void(^)(NSString *errorMsg, id responseJSON ))handler;

+ (void)getSurgeonDates:(void(^)(NSString *errorMsg, id responseJSON ))handler;

+ (void)getTemplateVariables:(NSString *)procedureID handler:(void(^)(NSString *errorMsg, id responseJSON))handler;

+ (void)getDataSharingSettings:(NSString *)procedureID handler:(void(^)(NSString *errorMsg, id responseJSON))handler;

+ (void)updateDataSharingSettings:(NSString *)procedureID isSharing:(NSString *)sharing handler:(void(^)(NSString *errorMsg, id responseJSON))handler;

@end
