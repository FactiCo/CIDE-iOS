//
//  PrincipalOptionsViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 31/12/14.
//  Copyright (c) 2014 Nayely Vergara. All rights reserved.
//

#import "PrincipalOptionsViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface PrincipalOptionsViewController () <UIActionSheetDelegate>

@end

@implementation PrincipalOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL tutorialViewed = [defaults boolForKey:@"tutorial_viewed"];
    if (!tutorialViewed) {
        [self performSegueWithIdentifier:@"goToTutorial" sender:self];
        [defaults setBool:YES forKey:@"tutorial_viewed"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self performSegueWithIdentifier:@"goToAviso" sender:self];
    } else if (buttonIndex == 1) {
        [self performSegueWithIdentifier:@"goToTutorial2" sender:self];
    }
}

- (IBAction)propuestasAction:(id)sender {
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        [self performSegueWithIdentifier:@"goToPropuestas" sender:self];
    } else {
        [self performSegueWithIdentifier:@"goToPropuestas" sender:self];
    }
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
