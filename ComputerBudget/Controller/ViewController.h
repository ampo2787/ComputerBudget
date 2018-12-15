//
//  ViewController.h
//  ComputerBudget
//
//  Created by JihoonPark on 2018. 8. 3..
//  Copyright © 2018년 JihoonPark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "priceCalculate.h"
#import "parseEngine.h"
#import "TableViewController.h"

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>{
    UIPickerView *budgetPickerView;
    UIPickerView *purposePickerView;

    NSMutableArray *budgetArray;
    NSMutableArray *purposeArray;
}

@property (nonatomic, weak) NSString *tfPurposeText;
@property (nonatomic, weak) NSString *tfBudgetText;

@property NSMutableArray * listArray;

@end

