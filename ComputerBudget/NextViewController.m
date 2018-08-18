//
//  NextViewController.m
//  ComputerBudget
//
//  Created by JihoonPark on 2018. 8. 3..
//  Copyright © 2018년 JihoonPark. All rights reserved.
//

#import "NextViewController.h"
#import "TFHpple.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *htmlWillInsert = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://prod.danawa.com/info/?pcode=5530356&keyword=i5-8400&cate=112747"] encoding:NSUTF8StringEncoding error:nil];
    NSData *htmlData = [htmlWillInsert dataUsingEncoding:NSUnicodeStringEncoding];
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
    NSArray *reh = [xpathParser searchWithXPathQuery:@"//*[@id=\"blog_content\"]/div[2]/div[2]/div[1]/div[2]/div[1]/div[1]/span[2]/a/em"];
    TFHppleElement *data = [reh objectAtIndex:0];
    NSString *title = [data text];
    NSLog(@"%@, %d, i5가격 : %@", reh, reh.count, title);
    
    
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

@end
