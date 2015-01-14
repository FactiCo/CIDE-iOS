//
//  Tutorial2ViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 31/12/14.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import "Tutorial2ViewController.h"

@interface Tutorial2ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) UIImageView *image1;
@property (nonatomic) CGFloat height;

@end

@implementation Tutorial2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageControl.transform = CGAffineTransformMakeRotation(M_PI_2);
}

- (void)viewDidLayoutSubviews
{
    if (self.image1 == nil) {
        [self setupViews];
    }
}

- (void)setupViews {
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    self.height = height;
    
    self.scrollView.contentSize = CGSizeMake(width, height * 3);
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    image1.image = [UIImage imageNamed:@"justicia-ciudadana-postal01.jpg"];
    [self.scrollView addSubview:image1];
    self.image1 = image1;
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, height, width, height)];
    image2.image = [UIImage imageNamed:@"Justicia-Ciudadana-postal02.jpg"];
    [self.scrollView addSubview:image2];
    
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, (height) * 2, width, height)];
    image3.image = [UIImage imageNamed:@"justicia-ciudadana-postal03.jpg"];
    [self.scrollView addSubview:image3];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = self.scrollView.contentOffset.y / self.height;
}

- (IBAction)pageChanged:(UIPageControl *)sender {
    [self.scrollView setContentOffset:CGPointMake(0, sender.currentPage * self.height) animated:YES];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
