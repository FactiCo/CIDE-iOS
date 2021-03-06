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
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *navigationTitle;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _navigationTitle.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:18.0];
    
    self.urlMap = @"http://justiciacotidiana.mx/es/JusticiaCotidiana/mapatestimonios";
    NSURL *targetURL = [NSURL URLWithString:self.urlMap];
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    self.webPage.delegate = self;
    [self.webPage loadRequest:request];
    [self.view addSubview:self.webPage];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.activityIndicator];
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

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
}

@end
