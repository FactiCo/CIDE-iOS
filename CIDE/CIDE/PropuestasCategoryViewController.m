//
//  PropuestasCategoryViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 10/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import "PropuestasCategoryViewController.h"
#import <AFHTTPRequestOperationManager.h>
#import <QuartzCore/QuartzCore.h>
#import "PropuestaDetailViewController.h"
#import "ArgumentosViewController.h"
#import "PropTableViewCell.h"

@interface PropuestasCategoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *categoryTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) NSArray *imageData;
@property (strong, nonatomic) IBOutlet UIImageView *imageCategory;
@property (weak, nonatomic) IBOutlet UILabel *noDataLabel;

@end

@implementation PropuestasCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageData = @[[UIImage imageNamed:@"iconos_categorias-02.png"], [UIImage imageNamed:@"iconos_categorias-03.png"], [UIImage imageNamed:@"iconos_categorias-04.png"], [UIImage imageNamed:@"iconos_categorias-05.png"], [UIImage imageNamed:@"iconos_categorias-06.png"], [UIImage imageNamed:@"iconos_categorias-07.png"]];
    
    self.imageCategory.image = [self.imageData objectAtIndex:self.pageIndex];
    
    self.categoryTitle.text = self.category;
    [self.tableView setSeparatorColor:[UIColor greenColor]];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.hidden = YES;
    self.noDataLabel .hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.activityIndicator];
    self.propuestas = nil;
    self.tableView.hidden = YES;
    [self.activityIndicator startAnimating];
    [self.tableView reloadData];
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
    cell.genderImage.layer.cornerRadius = cell.genderImage.bounds.size.width / 2.0;
    cell.genderImage.layer.masksToBounds = YES;
    NSString *fcbookid = data[@"author"][@"fcbookid"];
    if (![fcbookid isEqual:[NSNull null]]) {
        [self setUserImageWithPropuesta:data cell:cell];
    }
    cell.identifier = data[@"_id"];
    
    return cell;
}

- (void)setUserImageWithPropuesta:(NSDictionary *)propuesta cell:(PropTableViewCell *)cell {
    NSString *imageURL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=square", propuesta[@"author"][@"fcbookid"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([cell.identifier isEqualToString:propuesta[@"_id"]]) {
            cell.genderImage.image = responseObject;
        } else {
            NSLog(@"cell different id");
        }
        
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
    PropTableViewCell *cell = (PropTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSDictionary *propuesta = self.propuestas[indexPath.row];
    [self.delegate propuestasCategoryController:self didSelectPropuesta:propuesta withImage:cell.genderImage.image];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
