
//
//  OKLTemplateViewController.m
//  OpKnowte
//
//  Created by Olegek on 02.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKLTemplateViewController.h"
#import "OKProcedureTemplateVariablesModel.h"
@interface OKLTemplateViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIPickerView *procedurePicker;
@property (strong, nonatomic) IBOutlet UIView *pickerBGView;
@property (strong, nonatomic) IBOutlet UITextView *procedureTextView;
@property (nonatomic, strong) UIButton * doneButtonForDatePicker;

@end

@implementation OKLTemplateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBottomTabBar];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    _procedurePicker.delegate = self;
    _procedurePicker.dataSource = self;
    _pickerBGView.backgroundColor = [UIColor colorWithRed:24/255. green:59/255. blue:85/255. alpha:.90];
    [self addRightButtonToNavbar];
    NSString *procedureText = _templateModel.procedureText;
    procedureText = [procedureText stringByReplacingOccurrencesOfString:@")" withString:@""];
    procedureText = [procedureText stringByReplacingOccurrencesOfString:@"(" withString:@""];
    for (OKProcedureTemplateVariablesModel *model in _variablesArray){
        procedureText = [procedureText stringByReplacingOccurrencesOfString:model.value withString:[NSString stringWithFormat:@"%@", model.ID]];
    }
    _procedureTextView.text = procedureText;
    if (!IS_IOS7) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
    
    
    [self.view bringSubviewToFront:_pickerBGView];
    _doneButtonForDatePicker = [UIButton buttonWithType:UIButtonTypeCustom];
    [_doneButtonForDatePicker addTarget:self action:@selector(doneButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [_doneButtonForDatePicker setTitle:@"Done" forState:UIControlStateNormal];
    if (IS_IOS7) {
        _doneButtonForDatePicker.frame = CGRectMake(210, _pickerBGView.frame.origin.y-35, 100, 30);
    }else {
        _doneButtonForDatePicker.frame = CGRectMake(210, _pickerBGView.frame.origin.y-80, 100, 30);
    }
    _doneButtonForDatePicker.backgroundColor = [UIColor colorWithRed:228/255.0 green:34/255.0 blue:57/255.0 alpha:1];
    _doneButtonForDatePicker.layer.cornerRadius = 14;
    _doneButtonForDatePicker.clipsToBounds = YES;
    _doneButtonForDatePicker.hidden = YES;
    [self.view addSubview:_doneButtonForDatePicker];
    
    
}
-(void) doneButtonTapped{
    _procedurePicker.hidden = !_procedurePicker.hidden;
    _pickerBGView.hidden = !_pickerBGView.hidden;
    _doneButtonForDatePicker.hidden = !_doneButtonForDatePicker.hidden;
    
    [self.view endEditing:YES];
    
}
-(void) addLeftButtonToNavbar
{
    UIButton *right = [[UIButton alloc] init];
    right.bounds = CGRectMake( 0, 0, [UIImage imageNamed:@"back"].size.width +27, [UIImage imageNamed:@"back"].size.height );
    [right setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:right];
    self.navigationItem.leftBarButtonItem = anotherButton;
}
-(void) addRightButtonToNavbar
{
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStyleBordered target:self action:@selector(rightButtonTapped)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
}

-(void) rightButtonTapped {
    _procedurePicker.hidden = !_procedurePicker.hidden;
    _pickerBGView.hidden = !_pickerBGView.hidden;
    _doneButtonForDatePicker.hidden = !_doneButtonForDatePicker.hidden;

     [self.view endEditing:YES];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _variablesArray.count;
}
-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    OKProcedureTemplateVariablesModel *model = (OKProcedureTemplateVariablesModel*) _variablesArray[row];
    NSString *pickerString = [NSString stringWithFormat:@"%@: %@",model.ID, model.key];
    if (IS_IOS7) {
        NSAttributedString *pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
        return pickerAttributedString;
    }else{
        NSAttributedString *pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
        return pickerAttributedString;
    }
}

- (IBAction)backButton:(id)sender {
    NSString *procedureText =  _procedureTextView.text;
    for (OKProcedureTemplateVariablesModel *model in _variablesArray){
        procedureText = [procedureText stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@", model.ID] withString:[NSString stringWithFormat:@"(%@)",model.value]];
    }
    _templateModel.procedureText = procedureText;

    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate updateTemplateModelWith:_templateModel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
