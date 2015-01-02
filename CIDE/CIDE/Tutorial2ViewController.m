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
@end

@implementation Tutorial2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    self.scrollView.contentSize = CGSizeMake(width, height * 5);
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:self.view.bounds];
    image1.image = [UIImage imageNamed:@"pag1.png"];
    [self.scrollView addSubview:image1];
    
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, height, width, height)];
    image2.image = [UIImage imageNamed:@"pag2.png"];
    [self.scrollView addSubview:image2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
