//
//  OKSelectContact.h
//  OpKnowte
//
//  Created by Artem Frolow on 5/22/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseProcedureElement.h"
@protocol OKSelectContactDelegate <OKBaseProcedureElementDelegate>

-(void)goToSelectContactViewWithRoleID:(NSString*)roleID selectContactObject: (id)selectContactObject;


@end
@interface OKSelectContact : OKBaseProcedureElement
@property (nonatomic, weak) id<OKSelectContactDelegate>delegate;
@property (strong, nonatomic) IBOutlet OKCustomTextField *customTextField;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, strong) NSMutableArray *contactsArray;
@property (nonatomic, strong) NSString *contactIDs;
@property (nonatomic) NSInteger tagOfTextField;
@property (nonatomic, strong) NSString *roleID;

- (void) setRoleID:(NSString *)roleID;
-(void) setupWithValue:(NSString*)value;

@end
