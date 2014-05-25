//
//  OKBaseProcedureElement.h
//  OpKnowte
//
//  Created by Eugene on 05.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OKCustomTextField.h"

@protocol OKBaseProcedureElementDelegate <NSObject>

- (void)updateField:(NSString*)field withData:(NSArray*)data;
- (void)updateField:(NSString*)name withValue:(NSString*)newValue andTag:(NSInteger) tag;
- (void)updateField:(NSString*)name withBoolValue:(BOOL)newValue;

- (void)goToNextElementFrom:(id)sender;
- (void) hidePickersWhenTextFieldBeginsEditing;
@end

@interface OKBaseProcedureElement : UIControl

@property (strong, nonatomic) NSString *fieldName;
@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) NSString *placeHolder;

- (void) setup;
@end
