//
//  LoginFBViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 10/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import "LoginFBViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface LoginFBViewController () <FBLoginViewDelegate>
@property (strong, nonatomic) IBOutlet FBLoginView *loginButton;

@end

@implementation LoginFBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.loginButton setReadPermissions:@[@"basic_info"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    if (self.navigationController.topViewController == self) {
        [self performSegueWithIdentifier:@"goToPropuestas" sender:self];
    }
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
