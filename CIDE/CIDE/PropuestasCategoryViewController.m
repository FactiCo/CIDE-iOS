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
#import "ArgumentosViewController.h"
#import "PropTableViewCell.h"

@interface PropuestasCategoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *categoryTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) NSArray *imageData;
@property (nonatomic, retain) NSDictionary *currentPropuesta;
@property (strong, nonatomic) IBOutlet UIImageView *imageCategory;
@property (weak, nonatomic) IBOutlet UILabel *noDataLabel;

@end

@implementation PropuestasCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageData = @[[UIImage imageNamed:@"iconos_categorias-02.png"], [UIImage imageNamed:@"iconos_categorias-03.png"], [UIImage imageNamed:@"iconos_categorias-04.png"], [UIImage imageNamed:@"iconos_categorias-05.png"], [UIImage imageNamed:@"iconos_categorias-06.png"],[UIImage imageNamed:@"iconos_categorias-07.png"]];
    
    self.imageCategory.image = [self.imageData objectAtIndex:self.pageIndex];
    
    self.categoryTitle.text = self.category;
    [self.tableView setSeparatorColor:[UIColor greenColor]];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.hidden = YES;
    self.noDataLabel .hidden = YES;
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

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"PropuestaDetail"]) {
//        UITabBarController *tabController = segue.destinationViewController;
//        PropuestaDetailViewController *controller = tabController.viewControllers[0];
//        controller.propuesta = self.currentPropuesta;
//        controller.facebookDataSource = self.facebookDataSource;
//        
//        ArgumentosViewController *argumentosController = tabController.viewControllers[1];
//        argumentosController.propuesta = self.currentPropuesta;
//        argumentosController.delegate = controller;
//        argumentosController.facebookDataSource = self.facebookDataSource;
//    }
//}

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
            if ([_propuestas count]) {
                self.tableView.hidden = NO;
                [self.tableView reloadData];
            } else {
                self.noDataLabel.hidden = NO;
            }
            
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
    cell.titleLabel.text = data[@"title"];
    cell.countLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[self countVotes:data]];
    
    return cell;
}

- (void)setUserImageWithPropuesta:(NSDictionary *)propuesta cell:(PropTableViewCell *)cell {
    NSString *imageURL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=square", @"123"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        cell.genderImage.image = responseObject;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
    }];
    [requestOperation start];
}

- (NSUInteger)countVotes:(NSDictionary *)propuesta {
    NSUInteger count = 0;
    count += [propuesta[@"votes"][@"favor"][@"participantes"] count];
    count += [propuesta[@"votes"][@"contra"][@"participantes"] count];
    count += [propuesta[@"votes"][@"abstencion"][@"participantes"] count];
    
    return count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentPropuesta = self.propuestas[indexPath.row];
    [self.delegate propuestasCategoryController:self didSelectPropuesta:self.currentPropuesta];
//    [self performSegueWithIdentifier:@"PropuestaDetail" sender:self];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
