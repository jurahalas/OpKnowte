//
//  OKIndicationTemplateViewController.m
//  OpKnowte
//
//  Created by Olegek on 07.05.14.
//  Copyright (c) 2014 OpKnowte Corp. All rights reserved.
//

#import "OKIndicationTemplateViewController.h"
#import "OKProcedureTemplateVariablesModel.h"

@interface OKIndicationTemplateViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *indicationPicker;
@property (strong, nonatomic) IBOutlet UITextView *indicationTextView;
@property (strong, nonatomic) IBOutlet UIView *pickerBGView;


@end

@implementation OKIndicationTemplateViewController


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
    _indicationPicker.delegate = self;
    _indicationPicker.dataSource = self;
    [self addRightButtonToNavbar];
    NSString *indicationText = _templateModel.indicationText;
    for (OKProcedureTemplateVariablesModel *model in _variablesArray){
        indicationText = [indicationText stringByReplacingOccurrencesOfString:model.value withString:[NSString stringWithFormat:@"(%@)", model.ID]];
    }
    _indicationTextView.text = indicationText;
    
    
    
}
-(void) addRightButtonToNavbar
{
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStyleBordered target:self action:@selector(rightButtonTapped)];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
}

-(void) rightButtonTapped {
    _indicationPicker.hidden = !_indicationPicker.hidden;
    _pickerBGView.hidden = !_pickerBGView.hidden;
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
    NSAttributedString *pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    return pickerAttributedString;
}

- (IBAction)backButton:(id)sender {
    NSString *indicationText =  _indicationTextView.text;
    for (OKProcedureTemplateVariablesModel *model in _variablesArray){
        indicationText = [indicationText stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"(%@)", model.ID] withString:model.value];
    }
    _templateModel.indicationText = indicationText;
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate updateTemplateModelWith:_templateModel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
