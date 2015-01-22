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
    [super viewDidLayoutSubviews];
}

- (void)setupViews {
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.scrollView.frame.size.height;
    self.height = height;
    
    self.scrollView.contentSize = CGSizeMake(width, height * 5);
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    image1.image = [UIImage imageNamed:@"info1.png"];
    [self.scrollView addSubview:image1];
    self.image1 = image1;
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, height, width, height)];
    image2.image = [UIImage imageNamed:@"info2.png"];
    [self.scrollView addSubview:image2];
    
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, (height) * 2, width, height)];
    image3.image = [UIImage imageNamed:@"info3.png"];
    [self.scrollView addSubview:image3];
    
    UIImageView *image4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, (height) * 3, width, height)];
    image4.image = [UIImage imageNamed:@"info4.png"];
    [self.scrollView addSubview:image4];
    
    UIImageView *image5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, (height) * 4, width, height)];
    image5.image = [UIImage imageNamed:@"info5.png"];
    [self.scrollView addSubview:image5];
    
    UIView *fondo=[[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    fondo.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:fondo];
    
    
    UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(fondo.frame.size.width-30, 7, 30, 30)];
    back.backgroundColor=[UIColor whiteColor];
    [back addTarget:self
             action:@selector(doneAction:)
   forControlEvents:UIControlEventTouchDown];
    //[back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [back setTitle:@"X" forState:UIControlStateNormal];
   [back setTitleColor:[UIColor colorWithRed:(83/255.0) green:(197/255.0) blue:(147/255.0) alpha:1] forState:UIControlStateNormal] ;
    [back.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [fondo addSubview:back];
    UIImageView *log=[[UIImageView alloc]initWithFrame: CGRectMake((self.view.frame.size.width/2)-40, 26, 80, 80) ];
    log.image=[UIImage imageNamed:@"jd.png"];
    [self.view addSubview:log];
    
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
