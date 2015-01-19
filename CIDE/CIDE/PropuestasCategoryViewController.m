//
//  PropuestasCategoryViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 10/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import "PropuestasCategoryViewController.h"
#import <AFHTTPRequestOperationManager.h>
#import "PropuestaDetailViewController.h"
#import "PropTableViewCell.h"

@interface PropuestasCategoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *categoryTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) NSArray *imageData;
@property (strong, nonatomic) IBOutlet UIImageView *imageCategory;

@end

@implementation PropuestasCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageData = @[[UIImage imageNamed:@"iconos_categorias-02.png"], [UIImage imageNamed:@"iconos_categorias-03.png"], [UIImage imageNamed:@"iconos_categorias-04.png"], [UIImage imageNamed:@"iconos_categorias-05.png"], [UIImage imageNamed:@"iconos_categorias-06.png"],[UIImage imageNamed:@"iconos_categorias-07.png"]];
    
    self.imageCategory.image = [self.imageData objectAtIndex:self.pageIndex];
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PropuestaDetail"]) {
        PropuestaDetailViewController *controller = segue.destinationViewController;
        controller.propuesta = sender;
        self.propuestas = nil;
    }
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
    PropTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleCell];
    if (cell == nil) {
        cell = [[PropTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleCell];
    }
    NSDictionary *data = self.propuestas[indexPath.row];
    cell.autorLabel.text = data[@"name"];
    cell.titleTextView.text = data[@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"PropuestaDetail" sender:self.propuestas[indexPath.row]];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
