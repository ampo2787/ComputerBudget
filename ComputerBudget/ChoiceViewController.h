//
//  ChoiceViewController.h
//  ComputerBudget
//
//  Created by JihoonPark on 2018. 8. 3..
//  Copyright © 2018년 JihoonPark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoiceViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>{
    NSArray* purposeArray;
}

@property NSString *selectResult;

@end
