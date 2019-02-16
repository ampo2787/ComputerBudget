//
//  parseEngine.h
//  ComputerBudget
//
//  Created by JihoonPark on 05/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"
#import "product.h"
#import "ComputerBudget-Swift.h"

@interface parseEngine : NSObject

@property NSDictionary *priceList;
@property (nonatomic) NSMutableDictionary *productList;
@property (nonatomic) NSMutableDictionary *finalPriceList;
@property (nonatomic) NSMutableDictionary *ImageList;

- (BOOL)parse;

@end

