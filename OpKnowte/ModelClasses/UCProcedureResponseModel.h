//
//  UCProcedureResponseModel.h
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/29/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCProcedureResponseModel : NSObject
{
    NSString *response;
    NSArray *procedures;
}
@property(strong,nonatomic)NSString *response;
@property(strong,nonatomic)NSArray *procedures;

@end
