//
//  AppDelegate.h
//  ComputerBudget
//
//  Created by JihoonPark on 2018. 8. 3..
//  Copyright © 2018년 JihoonPark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

