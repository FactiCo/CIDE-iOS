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
@property (strong, nonatomic) IBOutlet UILabel *navigationTitle;

@end

@implementation TestimonialsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameData = @[@"Justicia en el trabajo", @"Justicia para ciudadanos", @"Justicia para familias", @"Justicia para emprendedores", @"Justicia vecinal y comunitaria",@"Otros temas de Justicia Cotidiana"];
    self.femeninoImage = [UIImage imageNamed:@"femenino.png"];
    self.masculinoImage = [UIImage imageNamed:@"masculino.png"];
    [self.tableView setSeparatorColor:[UIColor colorWithRed:(108/255.0) green:(218/255.0) blue:(132/255.0) alpha:1]];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navigationTitle.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:18.0];
    
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
