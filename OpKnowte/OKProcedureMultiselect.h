//
//  OKProcedureMultiselect.h
//  OpKnowte
//
//  Created by Eugene on 05.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OKProcedureMultiselectDelegate <NSObject>

-(void)updateField:(NSString*)field withData:(NSArray*)data;
-(void)showMultiselectVCForFieldWithName:(NSString*)fieldName withData:(NSArray*)data sender:(id)sender;

@end

@interface OKProcedureMultiselect : UIControl

@property (nonatomic, strong) NSString *fieldName;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic, weak) id<OKProcedureMultiselectDelegate>delegate;
@property (nonatomic, strong) NSArray *dataArray;

- (IBAction)buttonTapped:(id)sender;
- (void)setPlaceHolder:(NSString*)placeHolder;

@end
