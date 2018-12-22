//
//  ViewController.m
//  ComputerBudget
//
//  Created by JihoonPark on 2018. 8. 3..
//  Copyright © 2018년 JihoonPark. All rights reserved.
//

#import "ViewController.h"
#import "Lottie/Lottie.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfBudget;
@property (weak, nonatomic) IBOutlet UITextField *tfPurpose;
@property LOTAnimationView *testAnimation;
@property BOOL buttonIsTouched;
@property (weak, nonatomic) IBOutlet UIButton *pushNextViewBtn;


@end

@implementation ViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.layer.borderWidth, 40)];
    [toolbar setCenter:self.view.center];
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc]initWithTitle:@"선택" style:UIBarButtonItemStyleDone target:self action:@selector(pickerViewDone:)];
    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc]initWithTitle:@"취소" style:UIBarButtonItemStyleDone target:self action:@selector(pickerViewCancel:)];
    [self LottieViewSetup];
    
    [toolbar setItems:[NSArray arrayWithObjects:btnDone,btnCancel, nil] animated:YES];
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
    self.tfBudgetText = self.tfBudget.text;
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
    self.tfPurposeText = self.tfPurpose.text;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setHidden:YES];
    [self.pushNextViewBtn setEnabled:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lottie Animation
- (void) LottieViewSetup{
    NSString *myFilePath = [[NSBundle mainBundle] pathForResource:@"coding_ape" ofType:@"json"];
    
    NSData *myData = [NSData dataWithContentsOfFile:myFilePath];
    
    NSError *error = nil;
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:myData
                                                             options:kNilOptions
                                                               error:&error];
    
    self.testAnimation = [LOTAnimationView animationFromJSON:jsonDict];
    [self.testAnimation setBackgroundColor:[UIColor lightGrayColor]];
    [self.testAnimation setFrame:CGRectMake(0, 0, self.view.frame.size.width, 500)];
    [self.view addSubview:self.testAnimation];
    
    /*
    NSLog(@"subviews - %@", self.view.subviews);
    NSLog(@"testanim - %@", testAnimation.description);
    if (testAnimation.isAnimationPlaying)
    {
        NSLog(@"is playing");
    }
     */
}

-(void)LottiePlay{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.testAnimation setLoopAnimation:YES];
        [self.testAnimation play];
    });
}

#pragma mark - PickerView Delegate & DataSource

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

#pragma mark - Action

-(void)pickerViewDone:(UIBarButtonItem *)sender{
        [self.tfBudget setText:self.tfBudgetText];
        [self.tfBudget resignFirstResponder];
        [budgetPickerView removeFromSuperview];

        [self.tfPurpose setText:self.tfPurposeText];
        [self.tfPurpose resignFirstResponder];
        [purposePickerView removeFromSuperview];
}

-(void)pickerViewCancel:(UIBarButtonItem *)sender{
    [self.tfBudget resignFirstResponder];
    [self.tfPurpose resignFirstResponder];
    [purposePickerView removeFromSuperview];
    [budgetPickerView removeFromSuperview];
}

- (IBAction)pushTableView:(UIButton *)sender {
    [self.pushNextViewBtn setEnabled:NO];
    [self parsingData];
}

-(void)parsingData{
    TableViewController *tableView = [self.storyboard instantiateViewControllerWithIdentifier:@"tableView"];
    priceCalculate *calculator = [[priceCalculate alloc]init];
    parseEngine *engine = [[parseEngine alloc]init];
    [self LottiePlay];
    [calculator setBudget:[NSNumber numberWithInt:[self.tfBudget.text intValue]]];
    [calculator setTarget:self.tfPurpose.text];
    [engine setPriceList:calculator.getListDictionary];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            BOOL res = [engine parse];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(res){
                    [tableView setProductList:[engine productList]];
                    [tableView setPriceList:[engine finalPriceList]];
                    [tableView setImageList:[engine ImageList]];
                    [self.testAnimation stop];
                    [self.navigationController pushViewController:tableView animated:YES];
                }
            });
        });
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return NO;
}


@end
