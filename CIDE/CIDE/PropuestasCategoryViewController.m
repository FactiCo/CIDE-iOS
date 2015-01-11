//
//  PropuestasCategoryViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 10/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import "PropuestasCategoryViewController.h"
#import <AFHTTPRequestOperationManager.h>

@interface PropuestasCategoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *categoryTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) NSMutableArray *propuestas;

@end

@implementation PropuestasCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.categoryTitle.text = self.category;
    [self.tableView setSeparatorColor:[UIColor greenColor]];
}

- (void)setCategory:(NSString *)category
{
    if (_category != category) {
        _category = category;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - data

- (NSMutableArray *)propuestas {
    if (!_propuestas) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://justiciacotidiana.mx:8080/justiciacotidiana/api/v1/propuestas" parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject){
            [self.activityIndicator stopAnimating];
            _propuestas = [NSMutableArray array];
            for (NSDictionary *item in responseObject[@"items"]) {
                if ([item[@"category"] isEqualToString:self.category]) {
                    [_propuestas addObject:item];
                }
            }
            [self.tableView reloadData];
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error %@", error);
            [self.activityIndicator stopAnimating];
        }];
        _propuestas = [NSMutableArray array];
    }
    return _propuestas;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.propuestas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleCell = @"PropuestaCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleCell];
    }
    NSDictionary *data = self.propuestas[indexPath.row];
    cell.textLabel.text = data[@"title"];
    
    return cell;
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
