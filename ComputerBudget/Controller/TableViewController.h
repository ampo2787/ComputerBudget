//
//  TableViewController.h
//  ComputerBudget
//
//  Created by JihoonPark on 05/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"
#import "product.h"

@interface TableViewController : UITableViewController <UIDocumentInteractionControllerDelegate>

@property UIDocumentInteractionController * interactionController;
@property (weak, nonatomic) IBOutlet TableViewCell *tableViewCell;

@property NSDictionary *productList;
@property NSDictionary *priceList;
@property NSDictionary *imageList;

@end

