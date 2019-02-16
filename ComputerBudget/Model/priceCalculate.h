//
//  priceCalculate.h
//  ComputerBudget
//
//  Created by JihoonPark on 07/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "product.h"

NS_ASSUME_NONNULL_BEGIN

@interface priceCalculate : NSObject

@property NSNumber *budget;
@property NSString *target;

-(NSDictionary *)getListDictionary;

@end

NS_ASSUME_NONNULL_END
