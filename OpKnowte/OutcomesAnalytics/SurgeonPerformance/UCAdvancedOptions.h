//
//  UCAdvancedOptions.h
//  MZUroCapture
//
//  Created by Omer on 7/5/13.
//  Copyright (c) 2013 Ahmed Sadiq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UCAdvancedOptions : UIViewController
{
    IBOutlet UILabel * l_Header;
}

@property (nonatomic, retain) NSString *answer1;
@property (nonatomic, retain) NSString *answer2;
@property (nonatomic, retain) NSString *answer3;

-(IBAction)back:(id)sender;
@end
