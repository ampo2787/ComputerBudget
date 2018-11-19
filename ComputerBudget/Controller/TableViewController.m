//
//  TableViewController.m
//  ComputerBudget
//
//  Created by JihoonPark on 05/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    UIImage *cellImage = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[self.imageList objectForKey:@"cpu"]]];
    [cell.imageView setImage:cellImage];
    [cell.lbProduct setText:[self.productList objectForKey:@"cpu"]];
    [cell.lbPrice setText:[self.priceList objectForKey:@"cpu"]];
    return cell;
}


@end
