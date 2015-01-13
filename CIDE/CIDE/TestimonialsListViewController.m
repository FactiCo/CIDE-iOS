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

@property (nonatomic, retain) NSArray *nameData;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImage *femeninoImage, *masculinoImage;

@end

@implementation TestimonialsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameData = @[@"Justicia en el trabajo", @"Justicia para familias", @"Justicia vecinal y comunitaria", @"Justicia para ciudadanos", @"Justicia para emprendedores"];
    self.femeninoImage = [UIImage imageNamed:@"femenino.png"];
    self.masculinoImage = [UIImage imageNamed:@"masculino.png"];
    [self.tableView setSeparatorColor:[UIColor colorWithRed:(108/255.0) green:(218/255.0) blue:(132/255.0) alpha:1]];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - data
/*
- (NSMutableArray *)testimonials {
    if (!_testimonials) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://justiciacotidiana.mx:8080/justiciacotidiana/api/v1/testimonios" parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject){
            [self.activityIndicator stopAnimating];
            self.activityIndicator.hidden = YES;
            _testimonials = [NSMutableArray array];
            for (NSDictionary *item in responseObject[@"items"]) {
                if ([item[@"category"] isEqualToString:self.nameData[self.option]]) {
                    [_testimonials addObject:item];
                }
            }
            [self.tableView reloadData];
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error %@", error);
            [self.activityIndicator stopAnimating];
            self.activityIndicator.hidden = YES;
        }];
        _testimonials = [NSMutableArray array];
    }
    return _testimonials;
}*/

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
    
    //SET FONT
    cell.nameLabel.font = [UIFont fontWithName:@"SourceSansPro-Bold" size:16.0];
    cell.explanationTextView.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:14.0];
    
    cell.nameLabel.text = data[@"name"];
    
    // TEST Size
    
    
    cell.explanationTextView.text = data[@"explanation"];
    if ([data[@"gender"] isEqualToString:@"Mujer"]) {
        cell.profileImageView.image = self.femeninoImage;
    } else {
        cell.profileImageView.image = self.masculinoImage;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
