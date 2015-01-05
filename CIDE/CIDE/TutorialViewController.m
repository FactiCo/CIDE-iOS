//
//  TutorialViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 31/12/14.
//  Copyright (c) 2014 Nayely Vergara. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView *image1;
@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews
{
    if (self.image1 == nil) {
        [self setupViews];
    }
}

- (void)setupViews {
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat gap = 3.0;
    
    self.scrollView.contentSize = CGSizeMake(width, (height + gap) * 4 - gap);
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    image1.image = [UIImage imageNamed:@"tut1.png"];
    [self.scrollView addSubview:image1];
    self.image1 = image1;
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, height + gap, width, height)];
    image2.image = [UIImage imageNamed:@"tut2.png"];
    [self.scrollView addSubview:image2];
    
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, (height + gap) * 2, width, height)];
    image3.image = [UIImage imageNamed:@"tut3.png"];
    [self.scrollView addSubview:image3];
    
    UIImageView *image4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, (height + gap) * 3, width, height)];
    image4.image = [UIImage imageNamed:@"tut4.png"];
    [self.scrollView addSubview:image4];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
