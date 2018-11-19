//
//  product.h
//  ComputerBudget
//
//  Created by JihoonPark on 05/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#ifndef product_h
#define product_h

typedef enum _CpuGeneration{
    6th, 7th, 8th
}CpuGeneration;

typedef enum _Cpu{
    pentium, i3, i5, i7, i9
}Cpu;

typedef enum _Graphic{
    gtx750, gtx960, gtx1050, gtx1060, gtx1080
}Graphic;

typedef enum _Ram{
    8, 16, 32
}Ram;

typedef enum _Disk{
    h250, h500, h1T, s128, s256, s512
}Disk;

typedef enum _Power{
    500w, 600w, 700w, 800w
}Power;

typedef enum _MainBoard{
    
}MainBoard;

typedef enum _Cooler{
    
}Cooler;

#endif /* product_h */
