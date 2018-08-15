//
//  ViewController.m
//  ComputerBudget
//
//  Created by JihoonPark on 2018. 8. 3..
//  Copyright © 2018년 JihoonPark. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
#import "ChoiceViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfBudget;
@property (weak, nonatomic) IBOutlet UITextField *tfPurpose;


@end

@implementation ViewController
@synthesize kindString;

- (IBAction)ChoiceFinish:(id)sender {
    NextViewController *nextView = [self.storyboard instantiateViewControllerWithIdentifier:@"nextView"];
    [self.navigationController pushViewController:nextView animated:YES];
}

- (IBAction)HowToUse:(id)sender {
    ChoiceViewController *choiceView = [self.storyboard instantiateViewControllerWithIdentifier:@"choiceView"];
    [self.navigationController pushViewController:choiceView animated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(setPlayTime:) name:@"setPlaytimes" object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tfPurpose setText:self.kindString];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setPlayTime:(NSNotification *)noti{
    
    NSDictionary *notiDic=[noti userInfo];
    
    kindString =[notiDic objectForKey:@"playTime"];
    
    NSLog(@"playtime=%@",kindString);
    
    
}


@end
