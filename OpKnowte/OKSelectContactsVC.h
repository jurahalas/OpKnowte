//
//  OKSelectContactsVC.h
//  OpKnowte
//
//  Created by Apple on 13.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKBaseViewController.h"
#import "OKSelectContactsCell.h"
#import "OKLoadingViewController.h"
@protocol OKSelectContactsVCDelegate <NSObject>

-(void) setChoosedContactsArray:(NSMutableArray*)contactsArray;

@end


@interface OKSelectContactsVC : OKBaseViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) id <OKSelectContactsVCDelegate> delegate;

@property(strong, nonatomic) NSString *contactID;


@end
