//
//  TableViewController.m
//  ComputerBudget
//
//  Created by JihoonPark on 05/11/2018.
//  Copyright © 2018 JihoonPark. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
@property (nonatomic) NSMutableArray *productOkArray;
@property (nonatomic) NSString *titleString;
@property (nonatomic, strong) UIImage *image;


- (IBAction)btnShare:(UIBarButtonItem *)sender;

@end

@implementation TableViewController

#pragma mark - Lazy Instatiate
- (NSMutableArray *)productOkArray{
    if(_productOkArray == nil){
        _productOkArray = [[NSMutableArray alloc]init];
    }
    return _productOkArray;
}

- (NSString *)titleString{
    if(_titleString == nil){
        _titleString = [[NSString alloc]init];
    }
    return _titleString;
}

#pragma mark - Action

- (IBAction)btnShare:(UIBarButtonItem *)sender {
    UIImage *image = [self captureView:self.tableView];
    NSData *imageData = UIImagePNGRepresentation(image);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirPaths objectAtIndex:0];
    NSString *outputFilePath = [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"your_computer.png"]];
    
    [fileManager createFileAtPath:outputFilePath contents:imageData attributes:nil];

    NSURL *fileURL = [NSURL fileURLWithPath:outputFilePath];
    
    self.interactionController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    [self.interactionController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    
}

-(UIImage*)captureView:(UITableView *)theView
{
    UIImage *resultImage;
    UIGraphicsBeginImageContext(theView.contentSize);
    {
        CGPoint savedContentOffset = theView.contentOffset;
        CGRect saveFrame = theView.frame;
        
        theView.contentOffset = CGPointZero;
        theView.frame = CGRectMake(0, 0, theView.contentSize.width, theView.contentSize.height);
        
        [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        theView.contentOffset = savedContentOffset;
        theView.frame = saveFrame;
    }
    UIGraphicsEndImageContext();
    return resultImage;
}

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.interactionController setDelegate:self];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.productOkArray addObject:CPU];
    [self.productOkArray addObject:GPU];
    [self.productOkArray addObject:RAM];
    [self.productOkArray addObject:DISK];
    [self.productOkArray addObject:POWER];
    [self.productOkArray addObject:MAIN];
    [self.productOkArray addObject:COOLER];
    [self.productOkArray addObject:CASE];

    if([[self.priceList objectForKey:GPU] isEqualToString:@"0"]){
        [self.productOkArray removeObject:GPU];
    }
    
    if([[self.priceList objectForKey:COOLER] isEqualToString:@"0"]){
        [self.productOkArray removeObject:COOLER];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productOkArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = (id)[self.tableView cellForRowAtIndexPath:indexPath];
    if(cell == nil){
        cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
        UIImage *cellImage = self.image;
        cellImage = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[self.imageList objectForKey:[self.productOkArray objectAtIndex:indexPath.row]]]];
        [cell.imageView setImage:cellImage];
        [cell.lbProduct setText:[self.productList objectForKey:[self.productOkArray objectAtIndex:indexPath.row]]];
        [cell.lbPrice setText:[self.priceList objectForKey:[self.productOkArray objectAtIndex:indexPath.row]]];
    }
    else{
        [self loadingImage:[self.imageList objectForKey:[self.productOkArray objectAtIndex:indexPath.row]] withIndexPath:indexPath];
    }
    return cell;
}

#pragma mark - Image Loading
-(void)loadingImage:(NSURL *)url withIndexPath:(NSIndexPath*)indexPath{
    self.image = nil;
    if(url){
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error){
            UIImage *tempimage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
            dispatch_async(dispatch_get_main_queue(), ^{
                TableViewCell *updateCell = (id)[self.tableView cellForRowAtIndexPath:indexPath];
                if(updateCell){
                    [updateCell.imageView setImage:tempimage];
                    [updateCell.lbProduct setText:[self.productList objectForKey:[self.productOkArray objectAtIndex:indexPath.row]]];
                    [updateCell.lbPrice setText:[self.priceList objectForKey:[self.productOkArray objectAtIndex:indexPath.row]]];
                    [self.tableView setNeedsDisplay];
                }
            });
        }];
        [task resume];
    }
}

#pragma mark - UIDocumentInteractionControllerDelegate

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller{
    return self.view.frame;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller{
    return self.view;
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}



@end
