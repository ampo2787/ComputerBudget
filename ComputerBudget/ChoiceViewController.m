//
//  ChoiceViewController.m
//  ComputerBudget
//
//  Created by JihoonPark on 2018. 8. 3..
//  Copyright © 2018년 JihoonPark. All rights reserved.
//

#import "ChoiceViewController.h"
#import "ViewController.h"

@interface ChoiceViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *pvPurpose;

@end

@implementation ChoiceViewController
@synthesize selectResult;

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
    
}

- (IBAction)ChoiceComplete:(id)sender {
    NSDictionary *notiDic=nil;
    
    notiDic=[[NSDictionary alloc]initWithObjectsAndKeys:selectResult,@"playTime", nil];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"setPlaytimes" object:nil userInfo:notiDic];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController isNavigationBarHidden];
    self.pvPurpose.delegate = self;
    
    purposeArray = [[NSArray alloc]initWithObjects:@"간단한 사무 + 웹서핑",@"적당한 게이밍",@"고사양 게임 or 그래픽 작업", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIPickerViewDataSource

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return purposeArray.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [purposeArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    selectResult = [purposeArray objectAtIndex:row];
    }

@end
