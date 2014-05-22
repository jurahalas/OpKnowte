//
//  OKSelectContactTypeVC.h
//  OpKnowte
//
//  Created by Apple on 13.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"
#import "OKSelectContactTypeCell.h"
#import "OKSelectContactsVC.h"

@protocol OKSelectContactTypeVCDelegate <NSObject>

-(void) setChoosedContactsArray:(NSMutableArray*)contactsArray;

@end


@interface OKSelectContactTypeVC : OKBaseViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) id <OKSelectContactTypeVCDelegate> delegate;

@property (strong, nonatomic) NSDictionary *dataDict;


@end