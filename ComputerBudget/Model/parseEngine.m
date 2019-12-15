//
//  parseEngine.m
//  ComputerBudget
//
//  Created by JihoonPark on 05/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import "parseEngine.h"

@interface parseEngine()

- (void) parseCPU:(int)price;
- (void) parseGPU:(int)price;
- (void) parseRam:(int)price;
- (void) parseDisk:(int)price;
- (void) parsePower:(int)price;
- (void) parseMainBoard:(NSString*)cpuModel withPrice:(int)price;
- (void) parseCooler:(int)price;;
- (void) parseCase:(int)price;
//각각의 부품에 대한 파싱.

@property TFHpple * xpathParser;
@property (nonatomic) NSArray * reh;
@property NSString * title;
@property NSURL * imageURL;
@property NSString * htmlWillInsert;
@property NSData * htmlData;
@property (nonatomic) TFHppleElement *data;
//파싱하는데 필요한 변수.

@property naverParseEngine *NEngine;

@property Boolean NAVER_ON;

@end

@implementation parseEngine

#pragma mark - Lazy Instantiate

- (NSArray *)reh{
    if(_reh == nil){
        _reh = [[NSArray alloc]init];
    }
    return _reh;
}

-(TFHppleElement *)data{
    if(_data == nil){
        _data = [[TFHppleElement alloc]init];
    }
    return _data;
}
- (NSMutableDictionary *)productList{
    if(_productList == nil){
        _productList = [[NSMutableDictionary alloc]init];
    }
    return _productList;
}

- (NSMutableDictionary *)finalPriceList{
    if(_finalPriceList == nil){
        _finalPriceList = [[NSMutableDictionary alloc]init];
    }
    return _finalPriceList;
}

- (NSMutableDictionary *)ImageList{
    if(_ImageList == nil){
        _ImageList = [[NSMutableDictionary alloc]init];
    }
    return _ImageList;
}

#pragma mark - private method
- (BOOL)parse{
    self.NAVER_ON = NO;
    
    if(!self.NAVER_ON){
        [self parseCPU:[[self.priceList objectForKey:CPU] intValue]];
        if(![[self.priceList objectForKey:GPU] isEqualToString:@"0"]){
            [self parseGPU:[[self.priceList objectForKey:GPU] intValue]];
        }
        else{
            [self.finalPriceList setObject:@"0" forKey:GPU];
        }
        [self parseRam:[[self.priceList objectForKey:RAM] intValue]];
        [self parseDisk:[[self.priceList objectForKey:DISK] intValue]];
        [self parsePower:[[self.priceList objectForKey:POWER] intValue]];
        if(![[self.priceList objectForKey:COOLER] isEqualToString:@"0"]){
            [self parseCooler:[[self.priceList objectForKey:COOLER] intValue]];
        }
        else{
            [self.finalPriceList setObject:@"0" forKey:COOLER];
        }
        
        [self parseCase:[[self.priceList objectForKey:CASE]intValue]];
        //mainboard는 cpu에서 이어서 파싱.
    }
    else{
        //처리해야할 것 : 상품명, 가격, imageURL
        self.NEngine = [[naverParseEngine alloc]init];
        [self.NEngine callURLWithSearch:@"i5 - 8500" key:CPU];
        [self.NEngine callURLWithSearch:@"gtx - 1050 Ti 4gb" key:GPU];
        [self.NEngine callURLWithSearch:@"samsung ddr4 8gb - 21300" key:RAM];
        [self.NEngine callURLWithSearch:@"ADATA Ultimate SU800 M.2 2280 STCOM (256GB)"  key:DISK];
        [self.NEngine callURLWithSearch:@"마이크로닉스 Classic II 500W +12V Single Rail 85+" key:POWER];
        [self.NEngine callURLWithSearch:@"GIGABYTE GA-H110M-DS2V 듀러블에디션 피씨디렉트" key:MAIN];
    }
    
    return true;
}


-(void)htmlInsert:(NSString *)url withType:(NSString*)type withProductName:(NSString *)name{
    self.htmlWillInsert = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSASCIIStringEncoding error:nil];
    self.htmlData = [self.htmlWillInsert dataUsingEncoding:NSUnicodeStringEncoding];
    self.xpathParser = [[TFHpple alloc] initWithHTMLData:self.htmlData];
    [self.productList setObject:name forKey:type];
}

-(void)listInsert:(NSString *)type{
    self.reh = [self.xpathParser searchWithXPathQuery:@"//*[@id=\"blog_content\"]/div[2]/div[2]/div[1]/div[2]/div[1]/div[1]/span[2]/a/em"];
    self.data = [self.reh objectAtIndex:0];
    self.title = [self.data text];
    self.reh = [self.xpathParser searchWithXPathQuery:@"//*[@id=\"baseImage\"]"];
    self.data = [self.reh objectAtIndex:0];
    self.imageURL = [[NSURL alloc]initWithString:[[self.data attributes] objectForKey:@"src"]];
    
    [self.finalPriceList setObject:self.title forKey:type];
    [self.ImageList setObject:self.imageURL forKey:type];
}

- (void)parseCPU:(int)price{
    if(price <= 5){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=6035613&keyword=intel%20pentium&cate=112747" withType:CPU withProductName:@"pentium"];
    }
    else if(price <= 15){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=5530456&keyword=intel%20i3&cate=112747" withType:CPU withProductName:@"i3 - 8100"];
    }
    else if(price <= 25){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=6020667&keyword=i5%208500&cate=112747" withType:CPU withProductName:@"i5 - 8500"];
    }
    else{
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=5530013&keyword=intel%20i7&cate=112747" withType:CPU withProductName:@"i7 - 8700"];
    }
    [self listInsert:CPU];
    [self parseMainBoard:[self.productList objectForKey:CPU] withPrice:[[self.priceList objectForKey:MAIN]intValue]];
}

- (void)parseGPU:(int)price{
    if(price <= 10){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=5743526&keyword=%EB%9D%BC%EB%8D%B0%EC%98%A8%20rx%20560&cate=112753" withType:GPU withProductName:@"rx - 560 2gb"];
    }
    else if(price <= 20){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=4597633&keyword=gtx%201050&cate=112753" withType:GPU withProductName:@"gtx - 1050 ti 4gb"];
    }
    else if(price <= 35){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=4360026&keyword=gtx%201060&cate=112753" withType:GPU withProductName:@"gtx - 1060 3gb"];
    }
    else{
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=4156202&keyword=gtx%201070&cate=112753" withType:GPU withProductName:@"gtx - 1070 8gb"];
    }
    [self listInsert:GPU];
}

- (void)parseRam:(int)price{
    if(price <= 10){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=5937666&keyword=%EC%82%BC%EC%84%B1%20ram%20ddr4%208g%2024000&cate=112752" withType:RAM withProductName:@"samsung ddr4 8gb - 21300"];
    }
    else if(price <= 20){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=5941995&keyword=%EC%82%BC%EC%84%B1%20ram%20ddr4%2016g%2024000&cate=112752" withType:RAM withProductName:@"samsung ddr4 16gb - 21300"];
    }
    else{
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=5941995&keyword=%EC%82%BC%EC%84%B1%20ram%20ddr4%2016g%2024000&cate=112752" withType:RAM withProductName:@"samsung ddr4 16gb - 21300 * 2ea"];
    }
    [self listInsert:RAM];
}

- (void)parseDisk:(int)price{
    if(price <= 5){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=6476417&keyword=ssd%20128gb&cate=112760" withType:DISK withProductName:@"ADATA Ultimate SU800 STCOM (128GB)"];
    }
    else if(price <= 10){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=6476446&keyword=ssd%20256gb&cate=112760" withType:DISK withProductName:@"ADATA Ultimate SU800 M.2 2280 STCOM (256GB)"];
    }
    else if(price <= 15){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=6476424&keyword=ssd%20512gb&cate=112760" withType:DISK withProductName:@"ADATA Ultimate SU800 STCOM (512GB)"];
    }
    else{
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=6096738&keyword=%EC%82%BC%EC%84%B1%20ssd%20512g&cate=112760" withType:DISK withProductName:@"삼성전자 970 PRO M.2 2280 (512GB)"];

    }
    [self listInsert:DISK];
}

- (void)parsePower:(int)price{
    if(price <= 5){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=1928673&keyword=500w%20power&cate=112777" withType:POWER withProductName:@"마이크로닉스 Classic II 500W +12V Single Rail 85+"];
    }
    else if(price <= 10){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=5045444&keyword=700w%20power&cate=112777" withType:POWER withProductName:@"마이크로닉스 Performance II PV 700W 80Plus Bronze Surge 4K"];
    }
    else if(price <= 15){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=3071154&keyword=%EB%A7%88%EC%9D%B4%ED%81%AC%EB%A1%9C%EB%8B%89%EC%8A%A4%20power&cate=112777" withType:POWER withProductName:@"마이크로닉스 Performance II HV 850W Bronze"];
    }
    else{
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=3071195&keyword=%EB%A7%88%EC%9D%B4%ED%81%AC%EB%A1%9C%EB%8B%89%EC%8A%A4%20power&cate=112777" withType:POWER withProductName:@"마이크로닉스 Performance II HV 1000W Bronze"];
        
    }
    [self listInsert:POWER];
}

- (void) parseMainBoard:(NSString*)cpuModel withPrice:(int)price{
    if(price <= 5){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=3535387&keyword=1151v2%20%EB%A9%94%EC%9D%B8%EB%B3%B4%EB%93%9C&cate=112751#bookmark_product_information" withType:MAIN withProductName:@"GIGABYTE GA-H110M-DS2V 듀러블에디션 피씨디렉트"];
    }
    else if(price <= 10){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=6016070&keyword=1151v2%20%EB%A9%94%EC%9D%B8%EB%B3%B4%EB%93%9C&cate=112751" withType:MAIN withProductName:@"GIGABYTE H310 D3 듀러블에디션 피씨디렉트"];
    }
    else if(price <= 15){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=6023637&keyword=1151v2%20%EB%A9%94%EC%9D%B8%EB%B3%B4%EB%93%9C&cate=112751" withType:MAIN withProductName:@"ASUS PRIME H370-PLUS STCOM"];
    }
    else{
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=6511733&keyword=1151v2%20%EB%A9%94%EC%9D%B8%EB%B3%B4%EB%93%9C&cate=112751" withType:MAIN withProductName:@"ASUS PRIME Z390-A STCOM"];
        
    }
    [self listInsert:MAIN];
}

- (void)parseCooler:(int)price{
    if(price <= 5){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=4954114&keyword=cpu%20%EC%BF%A8%EB%9F%AC&cate=112798" withType:COOLER withProductName:@"쿨러마스터 HYPER 212 LED Turbo RED"];
    }
    else if(price <= 10){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=5619275&keyword=%ED%83%80%EC%9B%8C%ED%98%95%20%EC%BF%A8%EB%9F%AC&cate=112798" withType:COOLER withProductName:@"쿨러마스터 MASTERAIR MA610P RGB"];
    }
    else{
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=2996635&keyword=%ED%83%80%EC%9B%8C%ED%98%95%20%EC%BF%A8%EB%9F%AC&cate=112798#bookmark_product_information" withType:COOLER withProductName:@"NOCTUA NH-D15"];
        
    }
    [self listInsert:COOLER];
}

- (void)parseCase:(int)price{
    if(price <= 5){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=4678115&keyword=%EC%BB%B4%ED%93%A8%ED%84%B0%20%EC%BC%80%EC%9D%B4%EC%8A%A4&cate=112775" withType:CASE withProductName:@"ABKO NCORE 아수라 풀 아크릴 블랙"];
    }
    else if(price <= 10){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=5568582&keyword=%EC%BB%B4%ED%93%A8%ED%84%B0%20%EC%BC%80%EC%9D%B4%EC%8A%A4&cate=112775" withType:CASE withProductName:@"ABKO SUITMASTER 513G 이지스 강화유리 HALO"];
    }
    else if(price <= 15){
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=6166486&keyword=%EC%BB%B4%ED%93%A8%ED%84%B0%20%EC%BC%80%EC%9D%B4%EC%8A%A4&cate=112775" withType:CASE withProductName:@"NZXT H500 Matte Black"];
    }
    else{
        [self htmlInsert:@"http://prod.danawa.com/info/?pcode=6554441&keyword=%EC%BB%B4%ED%93%A8%ED%84%B0%20%EC%BC%80%EC%9D%B4%EC%8A%A4&cate=112775" withType:CASE withProductName:@"Fractal Design Define S2 Blackout 강화유리"];
        
    }
    [self listInsert:CASE];
}

@end
