//
//  SeeTestTableViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 04/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import "SeeTestTableViewController.h"
#import <AFHTTPRequestOperationManager.h>
#import "TestCellTableViewCell.h"

@interface SeeTestTableViewController ()
@property (strong, nonatomic) NSMutableArray *testimonials;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation SeeTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSMutableArray *)testimonials {
    if (!_testimonials) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://justiciacotidiana.mx:8080/justiciacotidiana/api/v1/testimonios" parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject){
            NSLog(@"JSON : %@", responseObject);
            _testimonials = [NSMutableArray arrayWithArray:responseObject[@"items"]];
            [self.tableView reloadData];
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error %@", error);
        }];
        _testimonials = [NSMutableArray array];
    }
    return _testimonials;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.testimonials count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleCell = @"SimpleCell";
    TestCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleCell];
    if (cell == nil) {
        cell = [[TestCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleCell];
    }
    NSDictionary *data = self.testimonials[indexPath.row];
    cell.nameLabel.text = data[@"name"];
    cell.explanationLabel.text = data[@"explanation"];
    return cell;
}

@end
