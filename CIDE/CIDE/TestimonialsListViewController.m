//
//  TestimonialsListViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 07/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import "TestimonialsListViewController.h"
#import <AFHTTPRequestOperationManager.h>
#import "TestCellTableViewCell.h"

@interface TestimonialsListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *categoryKeys;
@property (strong, nonatomic) NSMutableArray *testimonials;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIImage *femeninoImage, *masculinoImage;

@end

@implementation TestimonialsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.categoryKeys = @[@"Justicia en el trabajo", @"Justicia en las familias", @"Justicia vecinal y comunitaria", @"Justicia para ciudadanos", @"Justicia para emprendedores"];
    self.femeninoImage = [UIImage imageNamed:@"femenino.png"];
    self.masculinoImage = [UIImage imageNamed:@"masculino.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - data

- (NSMutableArray *)testimonials {
    if (!_testimonials) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://justiciacotidiana.mx:8080/justiciacotidiana/api/v1/testimonios" parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject){
            _testimonials = [NSMutableArray array];
            for (NSDictionary *item in [responseObject[@"items"] reverseObjectEnumerator]) {
                if ([item[@"category"] isEqualToString:self.categoryKeys[self.option]]) {
                    [_testimonials addObject:item];
                }
            }
            [self.tableView reloadData];
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error %@", error);
        }];
        _testimonials = [NSMutableArray array];
    }
    return _testimonials;
}

#pragma mark - table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.testimonials count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleCell = @"TestCell";
    TestCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleCell];
    if (cell == nil) {
        cell = [[TestCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleCell];
    }
    NSDictionary *data = self.testimonials[indexPath.row];
    cell.nameLabel.text = data[@"name"];
    cell.explanationTextView.text = data[@"explanation"];
    if ([data[@"gender"] isEqualToString:@"Mujer"]) {
        cell.profileImageView.image = self.femeninoImage;
    } else {
        cell.profileImageView.image = self.masculinoImage;
    }
    return cell;
}

@end
