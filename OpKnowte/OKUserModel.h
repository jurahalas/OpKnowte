//
//  OKUserModel.h
//  OpKnowte
//
//  Created by Artem Frolow on 4/15/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseModel.h"

@interface OKUserModel : OKBaseModel
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *userID;
@property (nonatomic, retain) NSString *status;


@end
