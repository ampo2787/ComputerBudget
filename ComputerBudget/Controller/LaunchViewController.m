//
//  LaunchViewController.m
//  ComputerBudget
//
//  Created by JihoonPark on 19/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import "LaunchViewController.h"
#import <Lottie/Lottie.h>

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self LottieViewSetup];
}

- (void) LottieViewSetup{
    NSString *myFilePath = [[NSBundle mainBundle] pathForResource:@"spirit_geek" ofType:@"json"];
    
    NSData *myData = [NSData dataWithContentsOfFile:myFilePath];
    
    NSError *error = nil;
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:myData
                                                             options:kNilOptions
                                                               error:&error];
    
    LOTAnimationView *testAnimation = [LOTAnimationView animationFromJSON:jsonDict];
    [testAnimation setFrame:CGRectMake(0, self.view.frame.origin.y/2 + 250, 500, 500)];
    [self.view addSubview:testAnimation];
    
    [testAnimation play];
    [testAnimation setLoopAnimation:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
