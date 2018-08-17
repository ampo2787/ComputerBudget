//
//  ViewController.m
//  ComputerBudget
//
//  Created by JihoonPark on 2018. 8. 3..
//  Copyright © 2018년 JihoonPark. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfBudget;
@property (weak, nonatomic) IBOutlet UITextField *tfPurpose;


@end

@implementation ViewController


- (IBAction)ChoiceFinish:(id)sender {
    NextViewController *nextView = [self.storyboard instantiateViewControllerWithIdentifier:@"nextView"];
    [self.navigationController pushViewController:nextView animated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.layer.borderWidth, 40)];
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pickerViewDone:)];
    
    [toolbar setItems:[NSArray arrayWithObjects:btnDone, nil] animated:YES];
    //pickerView의 toolbar와 done버튼 추가.
    
    budgetArray = [NSMutableArray arrayWithCapacity:4];
    [budgetArray addObject:@"50만원 이하"];
    [budgetArray addObject:@"100만원 이하"];
    [budgetArray addObject:@"150만원 이하"];
    [budgetArray addObject:@"가격 상관 없음"];
    //예산 배열
    
    budgetPickerView = [[UIPickerView alloc]init];
    [budgetPickerView setDelegate:self];
    [budgetPickerView setDataSource:self];
    
    
    
    [self.tfBudget setInputView:budgetPickerView];
    [self.tfBudget setInputAccessoryView:toolbar];

    //예산 PickerView 추가.
    
    self.tfBudget.text = @"50만원 이하";
    //기본값 설정.
    //예산 관련 pickerView 완료.
    
    purposeArray = [NSMutableArray arrayWithCapacity:4];
    [purposeArray addObject:@"간단한 사무용, 동영상 감상"];
    [purposeArray addObject:@"가벼운 게임, 적당한 활용"];
    [purposeArray addObject:@"고오급 게임, 그래픽 작업"];
    [purposeArray addObject:@"그래픽 필요없음, 코딩용"];
    //목적 배열.
    
    purposePickerView = [[UIPickerView alloc]init];
    [purposePickerView setDelegate:self];
    [purposePickerView setDataSource:self];
    [self.tfPurpose setInputAccessoryView:toolbar];
    [self.tfPurpose setInputView:purposePickerView];
    //목적 PickerView 추가.
    self.tfPurpose.text = @"간단한 사무용, 동영상 감상";
  
    
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - budgetPickerView Delegate & DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(pickerView == budgetPickerView){
        return budgetArray.count;
    }else{
        return purposeArray.count;
    }
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(pickerView == budgetPickerView){
        self.tfBudgetText = [budgetArray objectAtIndex:row];
        return [budgetArray objectAtIndex:row];
    }else{
        self.tfPurposeText = [purposeArray objectAtIndex:row];
        return [purposeArray objectAtIndex:row];
    }
    
}

-(void)pickerViewDone:(id)sender{
    NSLog(@"눌림");
    [self.tfBudget setText:self.tfBudgetText];
    [self.tfPurpose setText:self.tfPurposeText];
    
    [self.tfBudget resignFirstResponder];
    [self.tfPurpose resignFirstResponder];
    
    [purposePickerView removeFromSuperview];

}



@end
