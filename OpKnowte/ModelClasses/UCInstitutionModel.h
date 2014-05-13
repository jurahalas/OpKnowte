//
//  UCInstitutionModel.h
//  MZUroCapture
//
//  Created by Omer on 5/27/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCInstitutionModel : NSObject

@property (strong, nonatomic)NSString *name;
@property (strong, nonatomic)NSString *streetAdress;
@property (strong, nonatomic)NSString *city;
@property (strong, nonatomic)NSString *state;
@property (strong, nonatomic)NSString *country;
@property (strong, nonatomic)NSString *zip;
@property (strong, nonatomic)NSString *fax;
@property (strong, nonatomic)NSString *email;

@end
