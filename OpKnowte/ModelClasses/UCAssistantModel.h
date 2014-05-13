//
//  UCAssistantModel.h
//  MZUroCapture
//
//  Created by Ahmed Sadiq on 3/29/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCAssistantModel : NSObject

@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *email;
@property(strong,nonatomic)NSString *response;
@property(strong,nonatomic)NSArray *assistants;

@end
