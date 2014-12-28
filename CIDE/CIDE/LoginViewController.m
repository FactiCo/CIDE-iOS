//
//  LoginViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 27/12/14.
//  Copyright (c) 2014 Nayely Vergara. All rights reserved.
//

#import "LoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <AFHTTPRequestOperationManager.h>
#import <Parse/PFTwitterUtils.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.center = self.view.center;
    [self.view addSubview:loginView];
    
    /*[PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Twitter login.");
            return;
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in with Twitter!");
        } else {
            NSLog(@"User logged in with Twitter!");
        }     
    }];*/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendData {
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     [manager POST:@"http://example.com/resources.json" parameters:self.params success:^(AFHTTPRequestOperation *operation, id responseObject) {
     NSLog(@"JSON: %@", responseObject);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     NSLog(@"Error: %@", error);
     }];
}


@end
