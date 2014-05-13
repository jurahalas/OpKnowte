//
//  UCAnesthesiologistModel.h
//  MZUroCapture
//
//  Created by Atif Joyia on 09/05/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCAnesthesiologistModel : NSObject

@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *email;
@property(strong,nonatomic)NSString *response;
@property(strong,nonatomic)NSArray *anesthesiologists;

@end
