//
//  priceCalculate.m
//  ComputerBudget
//
//  Created by JihoonPark on 07/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import "priceCalculate.h"

#define entry   50
#define middle  100
#define high    150
#define maximum     200

@interface priceCalculate()

@property (nonatomic) NSMutableDictionary *priceList;
-(NSDictionary *)moneyAnalysis:(NSNumber *)money;
-(void)targetAnalysis;

@end

@implementation priceCalculate


#pragma mark - Lazy Instiation

- (NSMutableDictionary *)priceList{
    if(_priceList == nil){
        _priceList = [[NSMutableDictionary alloc]init];
    }
    return _priceList;
}

-(NSDictionary *)moneyAnalysis:(NSNumber *)money{ //돈을 분석해서 품목 리스트 리턴.
    int easyMoney = [money intValue];

    if (easyMoney <= entry) {
        [self priceListSetting:@"15" withPrice:CPU];
        [self priceListSetting:@"0" withPrice:GPU];
        [self priceListSetting:@"10" withPrice:RAM];
        [self priceListSetting:@"10" withPrice:DISK];
        [self priceListSetting:@"5" withPrice:POWER];
        [self priceListSetting:@"5" withPrice:MAIN];
        [self priceListSetting:@"0" withPrice:COOLER];
        [self priceListSetting:@"5" withPrice:CASE];
    }
    else if(entry < easyMoney && easyMoney <= middle) {
        [self priceListSetting:@"25" withPrice:CPU];
        [self priceListSetting:@"15" withPrice:GPU];
        [self priceListSetting:@"20" withPrice:RAM];
        [self priceListSetting:@"20" withPrice:DISK];
        [self priceListSetting:@"5" withPrice:POWER];
        [self priceListSetting:@"5" withPrice:MAIN];
        [self priceListSetting:@"5" withPrice:COOLER];
        [self priceListSetting:@"5" withPrice:CASE];
    }
    else if(high < easyMoney && easyMoney <= maximum) {
        [self priceListSetting:@"35" withPrice:CPU];
        [self priceListSetting:@"35" withPrice:GPU];
        [self priceListSetting:@"25" withPrice:RAM];
        [self priceListSetting:@"30" withPrice:DISK];
        [self priceListSetting:@"10" withPrice:POWER];
        [self priceListSetting:@"10" withPrice:MAIN];
        [self priceListSetting:@"5" withPrice:COOLER];
        [self priceListSetting:@"5" withPrice:CASE];
    }
    else{
        [self priceListSetting:@"50" withPrice:CPU];
        [self priceListSetting:@"50" withPrice:GPU];
        [self priceListSetting:@"30" withPrice:RAM];
        [self priceListSetting:@"30" withPrice:DISK];
        [self priceListSetting:@"10" withPrice:POWER];
        [self priceListSetting:@"20" withPrice:MAIN];
        [self priceListSetting:@"10" withPrice:COOLER];
        [self priceListSetting:@"10" withPrice:CASE];
    }
    
    return self.priceList;
}

-(void)targetAnalysis{ //목적 분석 -> 0원짜리나 주 투자처 구분.
    if([self.target isEqualToString:@"간단한 사무용, 동영상 감상"]){
        [self priceListSetting:@"0" withPrice:GPU];
        [self priceListSetting:@"0" withPrice:COOLER];
    }
    else if([self.target isEqualToString:@"가벼운 게임, 적당한 활용"]){
        [self priceListSetting:@"10" withPrice:CPU];
    }
    else if([self.target isEqualToString:@"고오급 게임, 그래픽 작업"]){
        
    }
    else if([self.target isEqualToString:@"hardcore"]){
        
    }
    else if([self.target isEqualToString:@"그래픽 필요없음, 코딩용"]){
        [self priceListSetting:@"0" withPrice:GPU];
    }
    else{
        NSLog(@"Target Analysis Error!!");
    }
}

-(void)priceListSetting:(NSString *)product withPrice:(NSString *)price {
    if(![self.priceList.allValues containsObject:product])
        [self.priceList setObject:product forKey:price];
}

-(NSDictionary *)getListDictionary{
    [self targetAnalysis];
    [self.priceList setDictionary:[self moneyAnalysis:self.budget]];
    return self.priceList;
}


@end

