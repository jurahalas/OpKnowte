//
//  OKOngoingData.m
//  OpKnowte
//
//  Created by Eugene on 21.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKOngoingData.h"

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
    
    return dict;
}


-(NSOrderedDictionary*)sixWeeksItems
{
    NSMutableOrderedDictionary *dict = [[NSMutableOrderedDictionary alloc]init];
    [dict setObject:self.chestXray forKey:@"Chest X-ray"];
    [dict setObject:self.Bun forKey:@"Bun"];
    [dict setObject:self.Creatinine forKey:@"Creatinine"];
    [dict setObject:self.liverEnzymes forKey:@"Liver Enzymes"];
    [dict setObject:self.portSiteHemia forKey:@"Port Site Hernia"];
    [dict setObject:self.other forKey:@"Other"];
    [dict setObject:self.CtScan forKey:@"CT-Scan"];
    
    return dict;
}


@end
