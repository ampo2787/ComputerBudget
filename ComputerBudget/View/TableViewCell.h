//
//  TableViewCell.h
//  ComputerBudget
//
//  Created by JihoonPark on 07/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbProduct;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UIImageView *productView;

@end

NS_ASSUME_NONNULL_END
