//
//  MapViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 07/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webPage;
@property (nonatomic) NSString *urlMap;
@property (nonatomic) NSURLConnection *connection;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.urlMap = @"http://www.carloscastellanos.com.mx/mapas/mexico.html";
    NSURL *targetURL = [NSURL URLWithString:self.urlMap];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    self.webPage.delegate = self;
    [self.webPage loadRequest:request];
    [self.view addSubview:self.webPage];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    // [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
