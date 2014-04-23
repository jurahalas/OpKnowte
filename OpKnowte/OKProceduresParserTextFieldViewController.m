//
//  OKProceduresParserTextFieldViewController.m
//  OpKnowte
//
//  Created by Artem Frolow on 4/23/14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKProceduresParserTextFieldViewController.h"

@interface OKProceduresParserTextFieldViewController ()
@property (strong, nonatomic) IBOutlet OKCustomTextField *customTextField;
@property (nonatomic, strong) NSString *fieldName;

@end

@implementation OKProceduresParserTextFieldViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setFieldName:(NSString*)name
{
    _fieldName = name;
}
-(void)setPlaceHolder:(NSString*)placeHolder{
    _customTextField.placeholder = placeHolder;
}
-(void)setType:(enum OKProcedureTextFieldType)type{
    if (OKProcedureSymbolicTF) {
        _customTextField.keyboardType = UIKeyboardTypeDefault;
    } else {
        _customTextField.keyboardType = UIKeyboardTypeDecimalPad;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.delegate updateField:self.fieldName withValue:self.customTextField.text];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
