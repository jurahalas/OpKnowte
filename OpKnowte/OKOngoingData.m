//
//  OKOngoingData.m
//  OpKnowte
//
//  Created by Eugene on 21.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKOngoingData.h"
#import <objc/runtime.h>
#import "OKCaseManager.h"

@implementation OKOngoingData

-(void)setModelWithDictionary:(NSDictionary *)dictionary
{
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if([self respondsToSelector:NSSelectorFromString(key)])
            [self setValue:obj forKey:key];
    }];
}


-(NSOrderedDictionary*)twoWeeksItems
{
    NSMutableOrderedDictionary *dict = [[NSMutableOrderedDictionary alloc]init];

    @try {
        [dict setObject:self.tStage forKey:@"T"];
        [dict setObject:self.nStage forKey:@"N"];
        [dict setObject:self.mStage forKey:@"M"];
        [dict setObject:self.tumorChar forKey:@"Tumor Characteristics"];
        [dict setObject:self.fuhrmanGrade forKey:@"Fuhrman Grade"];
        [dict setObject:self.preOperativeBun forKey:@"Pre-Operative Bun"];
        [dict setObject:self.preOperativeCreatinine forKey:@"Pre-Operative Creatinine"];
        [dict setObject:self.postOperativeBun forKey:@"Post-Operative Bun"];
        [dict setObject:self.postOperativeCreatinine forKey:@"Post-Operative Creatinine"];
        [dict setObject:self.margins forKey:@"Margins"];
        [dict setObject:self.deepMargin forKey:@"Deep Margin"];
        [dict setObject:self.lengthOfStay forKey:@"Post-Operative Hospital Stay"];
        [dict setObject:self.complications forKey:@"Complications"];
        [dict setObject:self.additionalDiagnosis forKey:@"Additional Diagnosis"];
    }
    @catch (NSException *exception) {
        NSLog(@"OKOngoing data exception in twoWeeksItems: %@",exception);
    }
    return dict;
}


-(NSOrderedDictionary*)sixWeeksItems
{
    NSMutableOrderedDictionary *dict = [[NSMutableOrderedDictionary alloc]init];
    @try {
        [dict setObject:self.chestXray forKey:@"Chest X-ray"];
        [dict setObject:self.Bun forKey:@"Bun"];
        [dict setObject:self.Creatinine forKey:@"Creatinine"];
        [dict setObject:self.liverEnzymes forKey:@"Liver Enzymes"];
        [dict setObject:self.portSiteHemia forKey:@"Port Site Hernia"];
        [dict setObject:self.other forKey:@"Other"];
        [dict setObject:self.CtScan forKey:@"CT-Scan"];
    }
    @catch (NSException *exception) {
        NSLog(@"OKOngoing data exception in sixWeeksItems: %@",exception);
    }

    return dict;
}


-(NSDictionary*)twoWeeksDictionaryForSending
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    unsigned i;
    for (i = 0; i < 15; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        
        id obj = [self valueForKey:name];
        if(!obj){
            obj = @"";
            NSLog(@"%@", name);
        }
        [dict setObject:obj forKey:name];
    }
    
    free(properties);
    return dict;
}


-(NSDictionary*)sixWeeksDictionaryForSending
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    unsigned i;
    for (i = 14; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        
        id obj = [self valueForKey:name];
        if(!obj)
            obj = @"";
        [dict setObject:obj forKey:name];
    }
    
    free(properties);
    return dict;
}


-(BOOL)checkTwoWeeksData
{
    BOOL allDataFilled = YES;
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    unsigned i;
    for (i = 1; i < 15; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];

        id obj = [self valueForKey:name];
        if(!obj){
            allDataFilled = NO;
            break;
        }
    }
    free(properties);
    return allDataFilled;
}


-(BOOL)checkSixWeeksData
{
    BOOL allDataFilled = YES;
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    unsigned i;
    for (i = 15; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        
        id obj = [self valueForKey:name];
        if(!obj){
            allDataFilled = NO;
            break;
        }
    }
    free(properties);
    return allDataFilled;
}


@end









//{
//    complications = Death;
//    deepMargin = Negative;
//    fuhrmanGrade = "4/4";
//    lengthOfStay = "4 Night(s)";
//    mStage = M1;
//    margins = Positive;
//    nStage = N;
//    postOperativeBun = 315325;
//    postOperativeCreatinine = 3125235;
//    preOperativeBun = 421124;
//    preOperativeCreatinine = 23452345;
//    procedureID = 2;
//    tStage = T3a;
//    tumorChar = Chromophobe;
//   
//    userID = 266;
//    caseID = 401;
//    timePointID = 1;
//}
//
//+ (void)addTwoWeeksOngoingClinicalDetail:(NSString *)caseID withTimePointID:(NSString *)timePointID withDictionary:(NSMutableDictionary *)data withUserID:(NSString *)userID withDelegate:(id)del{
//
//{
//    additionalDiagnosis = ooooooooooooooooo;
//    complications = Ileus;
//    deepMargin = Negative;
//    fuhrmanGrade = "1/4";
//    lengthOfStay = "1 Night(s)";
//    mStage = M0;
//    margins = Negative;
//    nStage = N0;
//    postOperativeBun = 124124;
//    postOperativeCreatinine = 124124;
//    preOperativeBun = 124;
//    preOperativeCreatinine = 124;
//    procedureID = 2;
//    tStage = T1a;
//    tumorChar = "Clear Cell";
//}
