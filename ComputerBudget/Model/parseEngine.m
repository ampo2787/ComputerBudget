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
- (void) parseMainBoard:(NSString*)cpuModel withPrice:(int)price;;
- (void) parseCooler:(int)price;;
- (void) parseCase:(int)price;

@end

@implementation parseEngine

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
- (void)parse{
    [self parseCPU:[[self.priceList objectForKey:@"cpu"] intValue]];
}

- (void)parseCPU:(int)price{
    NSString *htmlWillInsert;
    NSData *htmlData;
    TFHpple *xpathParser;
    NSArray *reh;
    if(price < 5){
        htmlWillInsert = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://prod.danawa.com/info/?pcode=6035613&keyword=intel%20pentium&cate=112747"] encoding:NSUTF8StringEncoding error:nil];
        htmlData = [htmlWillInsert dataUsingEncoding:NSUnicodeStringEncoding];
        xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];

    }else if(price < 15){
        htmlWillInsert = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://prod.danawa.com/info/?pcode=5530456&keyword=intel%20i3&cate=112747"] encoding:NSUTF8StringEncoding error:nil];
        htmlData = [htmlWillInsert dataUsingEncoding:NSUnicodeStringEncoding];
        xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];

    }else if(price < 25){
        htmlWillInsert = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://prod.danawa.com/info/?pcode=6020667&keyword=i5%208500&cate=112747"] encoding:NSUTF8StringEncoding error:nil];
        htmlData = [htmlWillInsert dataUsingEncoding:NSUnicodeStringEncoding];
        xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
        [self.productList setObject:@"i5 - 8500" forKey:@"cpu"];
    }else{
        htmlWillInsert = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://prod.danawa.com/info/?pcode=5530013&keyword=intel%20i7&cate=112747"] encoding:NSUTF8StringEncoding error:nil];
        htmlData = [htmlWillInsert dataUsingEncoding:NSUnicodeStringEncoding];
        xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];

    }
    reh= [xpathParser searchWithXPathQuery:@"//*[@id=\"blog_content\"]/div[2]/div[2]/div[1]/div[2]/div[1]/div[1]/span[2]/a/em"];
    TFHppleElement *data = [reh objectAtIndex:0];
    NSString *title = [data text];
    reh = [xpathParser searchWithXPathQuery:@"//*[@id=\"baseImage\"]"];
    data = [reh objectAtIndex:0];
    
    NSURL *imageUrl = [[NSURL alloc]initWithString:[[data attributes] objectForKey:@"src"]];
    [self.finalPriceList setObject:title forKey:@"cpu"];
    [self.ImageList setObject:imageUrl forKey:@"cpu"];

    NSLog(@"%@, %lu, cpu 가격 : %@", reh, (unsigned long)reh.count, title);
}

- (void)parseGPU:(int)price{
    
}

- (void)parseRam:(int)price{
    
}

- (void)parseDisk:(int)price{
    
}

- (void)parsePower:(int)price{
    
}

- (void) parseMainBoard:(NSString*)cpuModel withPrice:(int)price{

}

- (void)parseCooler:(int)price{
    
}

- (void)parseCase:(int)price{
    
}

@end
