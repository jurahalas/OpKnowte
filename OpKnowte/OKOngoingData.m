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

-(NSOrderedDictionary*)shockwaveItems
{
    NSMutableOrderedDictionary *dict = [[NSMutableOrderedDictionary alloc]init];
    
    @try {
        if ([self.stoneFragmentation5 isEqualToString:@""] && [self.stoneFragmentation4 isEqualToString:@""] && [self.stoneFragmentation3 isEqualToString:@""] && [self.stoneFragmentation2 isEqualToString:@""]) {
            [dict setObject:self.stoneFragmentation1 forKey:@"Stone fragmentation #1, mm"];
            [dict setObject:self.postprocedureComplications forKey:@"Postprocedure complications"];
        }else if ([self.stoneFragmentation5 isEqualToString:@""] && [self.stoneFragmentation4 isEqualToString:@""] && [self.stoneFragmentation3 isEqualToString:@""]){
            [dict setObject:self.stoneFragmentation1 forKey:@"Stone fragmentation #1, mm"];
            [dict setObject:self.stoneFragmentation2 forKey:@"Stone fragmentation #2, mm"];
            [dict setObject:self.postprocedureComplications forKey:@"Postprocedure complications"];
        }else if ([self.stoneFragmentation5 isEqualToString:@""] && [self.stoneFragmentation4 isEqualToString:@""]){
            [dict setObject:self.stoneFragmentation1 forKey:@"Stone fragmentation #1, mm"];
            [dict setObject:self.stoneFragmentation2 forKey:@"Stone fragmentation #2, mm"];
            [dict setObject:self.stoneFragmentation3 forKey:@"Stone fragmentation #3, mm"];
            [dict setObject:self.postprocedureComplications forKey:@"Postprocedure complications"];
        }else if ([self.stoneFragmentation5 isEqualToString:@""]){
            [dict setObject:self.stoneFragmentation1 forKey:@"Stone fragmentation #1, mm"];
            [dict setObject:self.stoneFragmentation2 forKey:@"Stone fragmentation #2, mm"];
            [dict setObject:self.stoneFragmentation3 forKey:@"Stone fragmentation #3, mm"];
            [dict setObject:self.stoneFragmentation4 forKey:@"Stone fragmentation #4, mm"];
            [dict setObject:self.postprocedureComplications forKey:@"Postprocedure complications"];
        }else{
            [dict setObject:self.stoneFragmentation1 forKey:@"Stone fragmentation #1, mm"];
            [dict setObject:self.stoneFragmentation2 forKey:@"Stone fragmentation #2, mm"];
            [dict setObject:self.stoneFragmentation3 forKey:@"Stone fragmentation #3, mm"];
            [dict setObject:self.stoneFragmentation4 forKey:@"Stone fragmentation #4, mm"];
            [dict setObject:self.stoneFragmentation5 forKey:@"Stone fragmentation #5, mm"];
            
            [dict setObject:self.postprocedureComplications forKey:@"Postprocedure complications"];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"OKOngoing data exception in shockwaveItems: %@",exception);
    }
    return dict;
}


-(NSOrderedDictionary*)roboticItems
{
    
    NSMutableOrderedDictionary *dict = [[NSMutableOrderedDictionary alloc]init];
    
    @try {
        [dict setObject:self.T forKey:@"T"];
        [dict setObject:self.N forKey:@"N"];
        [dict setObject:self.gleason forKey:@"Gleason"];
        [dict setObject:self.positiveMargin forKey:@"Positive Margin"];
        [dict setObject:self.cystogram forKey:@"Cystogram"];
        [dict setObject:self.Ileus forKey:@"Ileus, %"];
        [dict setObject:self.transfusion forKey:@"Transfusion, %"];
        [dict setObject:self.woundInfection forKey:@"Wound Infection, %"];
        [dict setObject:self.urineLeak forKey:@"Urine leak, %"];
        [dict setObject:self.bowelInjury forKey:@"Bowel Injury, %"];
        [dict setObject:self.DVT forKey:@"DVT, %"];
        [dict setObject:self.PE forKey:@"PE, %"];
        [dict setObject:self.reAdmission forKey:@"Re-admission within 30 days, %"];
        [dict setObject:self.returnToORWithin forKey:@"Return to the OR within 30 days, %"];
        [dict setObject:self.death forKey:@"Death, %"];
        
        [dict setObject:self.complications forKey:@"Complications"];
        [dict setObject:self.lengthOfStay forKey:@"Length of Stay, night(s)"];

    }
    @catch (NSException *exception) {
        NSLog(@"OKOngoing data exception in roboticItems: %@",exception);
    }
    return dict;
    
}

-(NSOrderedDictionary*)penileItems
{
    NSMutableOrderedDictionary *dict = [[NSMutableOrderedDictionary alloc]init];
    
    @try {
        [dict setObject:self.averageCyclingTime forKey:@"Average time to begin cycling of device"];
        [dict setObject:self.percentOfErosion forKey:@"Occurrence of erosion, %"];
        [dict setObject:self.percentOfInfection forKey:@"Occurrence of infection, %"];
        [dict setObject:self.percentOfMechnicalFailure forKey:@"Occurrence of mechanical failure, %"];
    }
    @catch (NSException *exception) {
        NSLog(@"OKOngoing data exception in penileItems: %@",exception);
    }
    return dict;
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


-(NSDictionary*)shockwaveDictionaryForSending
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    unsigned i;
    for (i = 0; i < 40; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        
        id obj = [self valueForKey:name];
        if(!obj){
            obj = @"";
            NSLog(@"%@", name);
            [dict removeObjectForKey:name];
        }
        [dict setObject:obj forKey:name];
    }
    
    free(properties);
    return dict;
}



-(NSDictionary*)roboticDictionaryForSending
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    unsigned i;
    for (i = 6; i < 43; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        
        id obj = [self valueForKey:name];
        if(!obj){
            obj = @"";
            NSLog(@"%@", name);
            [dict removeObjectForKey:name];
        }
        [dict setObject:obj forKey:name];
    }
    
    free(properties);
    return dict;
}


-(NSDictionary*)penileDictionaryForSending
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    unsigned i;
    for (i = 20; i < 27; i++)
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

-(NSDictionary*)twoWeeksDictionaryForSending
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    unsigned i;
    for (i = 20; i < 43; i++)
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
    for (i = 25; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        
        id obj = [self valueForKey:name];
        if(!obj){
            obj = @"";
        }
        if ([name isEqualToString:@"chestXray"] && [obj isEqualToString:@""]) {
            obj = @"Negative";
            [dict setObject:obj forKey:name];
        }else if ([name isEqualToString:@"liverEnzymes"] && [obj isEqualToString:@""]){
            obj = @"Normal";
            [dict setObject:obj forKey:name];
        }
        [dict setObject:obj forKey:name];
    }

    free(properties);
    return dict;
}


-(BOOL)checkPenileData
{
    BOOL allDataFilled = YES;
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    unsigned i;
    for (i = 1; i < 5; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        
        id obj = [self valueForKey:name];
        if(!obj){
            allDataFilled = NO;
            NSLog(@"%@", name);
            break;
        }
    }
    free(properties);
    return allDataFilled;
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
    for (i = 19; i < count; i++)
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