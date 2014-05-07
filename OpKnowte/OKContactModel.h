//
//  OKContactModel.h
//  OpKnowte
//
//  Created by Apple on 25.04.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseModel.h"

@interface OKContactModel : OKBaseModel

@property (strong,nonatomic) NSString* contactRoleID;
@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSString* contactEmail;
@property (strong,nonatomic) NSString* contactNumber;
@property (strong,nonatomic) NSString* contactStreetAddress;
@property (strong,nonatomic) NSString* contactCity;
@property (strong,nonatomic) NSString* contactState;
@property (strong,nonatomic) NSString* contactZip;
@property (strong,nonatomic) NSString* contactCountry;
@property (strong,nonatomic) NSString* contactFax;


@end
