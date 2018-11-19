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

@property int cpuPrice;
@property int gpuPrice;
@property int ramPrice;
@property int diskPrice;
@property int powerPrice;
@property int mainBoardPrice;
@property int coolerPrice;
@property int casePrice;

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
        [self.priceList setObject:@"15" forKey:@"cpu"];
        [self.priceList setObject:@"0" forKey:@"gpu"];
        [self.priceList setObject:@"10" forKey:@"ram"];
        [self.priceList setObject:@"10" forKey:@"disk"];
        [self.priceList setObject:@"5" forKey:@"power"];
        [self.priceList setObject:@"5" forKey:@"mainBoard"];
        [self.priceList setObject:@"0" forKey:@"cooler"];
        [self.priceList setObject:@"5" forKey:@"case"];
    }
    else if(entry < easyMoney && easyMoney <= middle) {
        [self.priceList setObject:@"25" forKey:@"cpu"];
        [self.priceList setObject:@"15" forKey:@"gpu"];
        [self.priceList setObject:@"20" forKey:@"ram"];
        [self.priceList setObject:@"20" forKey:@"disk"];
        [self.priceList setObject:@"5" forKey:@"power"];
        [self.priceList setObject:@"5" forKey:@"mainBoard"];
        [self.priceList setObject:@"5" forKey:@"cooler"];
        [self.priceList setObject:@"5" forKey:@"case"];
    }
    else if(high < easyMoney && easyMoney <= maximum) {
        [self.priceList setObject:@"35" forKey:@"cpu"];
        [self.priceList setObject:@"35" forKey:@"gpu"];
        [self.priceList setObject:@"25" forKey:@"ram"];
        [self.priceList setObject:@"30" forKey:@"disk"];
        [self.priceList setObject:@"10" forKey:@"power"];
        [self.priceList setObject:@"10" forKey:@"mainBoard"];
        [self.priceList setObject:@"5" forKey:@"cooler"];
        [self.priceList setObject:@"5" forKey:@"case"];
    }
    else{
        [self.priceList setObject:@"50" forKey:@"cpu"];
        [self.priceList setObject:@"50" forKey:@"gpu"];
        [self.priceList setObject:@"30" forKey:@"ram"];
        [self.priceList setObject:@"30" forKey:@"disk"];
        [self.priceList setObject:@"10" forKey:@"power"];
        [self.priceList setObject:@"20" forKey:@"mainBoard"];
        [self.priceList setObject:@"10" forKey:@"cooler"];
    }
    
    return self.priceList;
}

-(void)targetAnalysis{ //목적 분석 -> 0원짜리나 주 투자처 구분.
    if([self.target isEqualToString:@"basic"]){
        self.gpuPrice = 0;
        self.coolerPrice = 0;
    }
    else if([self.target isEqualToString:@"movie"]){
        self.cpuPrice = 10;
    }
    else if([self.target isEqualToString:@"game"]){
        
    }
    else if([self.target isEqualToString:@"hardcore"]){
    }
    else if([self.target isEqualToString:@"coding"]){
        
    }else{
        NSLog(@"Target Analysis Error!!");
    }
}

-(NSDictionary *)getListDictionary{
    [self targetAnalysis];
    [self.priceList setDictionary:[self moneyAnalysis:self.budget]];
    return self.priceList;
}


@end

