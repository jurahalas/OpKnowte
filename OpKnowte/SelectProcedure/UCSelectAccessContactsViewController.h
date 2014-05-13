//
//  UCSelectAccessContactsViewController.h
//  MZUroCapture
//
//  Created by Atif Joyia on 05/06/2013.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCSelectAccessContactsViewController : UIViewController


@property (nonatomic, retain) IBOutlet UILabel *headerLbl;
@property (nonatomic, retain) IBOutlet UITableView *contactsTable;

@property (nonatomic, retain) NSMutableArray *contactsArray;
@end
