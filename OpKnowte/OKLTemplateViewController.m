
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
    for (OKProcedureTemplateVariablesModel *model in _variablesArray){
        procedureText = [procedureText stringByReplacingOccurrencesOfString:model.value withString:[NSString stringWithFormat:@"%@", model.ID]];
    }
    _procedureTextView.text = procedureText;
    if (!IS_IOS7) {
        [self.navigationItem setHidesBackButton:NO];
        [self addLeftButtonToNavbar];
    }
	// Do any additional setup after loading the view.
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
     [self.view endEditing:YES];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _variablesArray.count;
}
-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    UIColor * color = [UIColor whiteColor];
    
    OKProcedureTemplateVariablesModel *model = (OKProcedureTemplateVariablesModel*) _variablesArray[row];
    NSString *pickerString = [NSString stringWithFormat:@"%@: %@",model.ID, model.key];
    
    if (IS_IOS7) {
        NSAttributedString *pickerAttributedString = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName:color }];
        return pickerAttributedString;
    }
    else  {
        color = [UIColor blackColor];
    NSAttributedString *pickerAttributed = [[NSAttributedString alloc]initWithString:pickerString attributes:@{NSForegroundColorAttributeName: color}];
        return pickerAttributed;
    }
}

- (IBAction)backButton:(id)sender {
    NSString *procedureText =  _procedureTextView.text;
    for (OKProcedureTemplateVariablesModel *model in _variablesArray){
        procedureText = [procedureText stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@", model.ID] withString:model.value];
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
