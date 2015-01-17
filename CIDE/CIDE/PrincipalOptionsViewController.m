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

@property (strong, nonatomic) IBOutlet UILabel *headerLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *descriptionLabels;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *titlesLabel;

@end

@implementation PrincipalOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for(UILabel *lbl in self.descriptionLabels) {
       
        [lbl setFont:[UIFont fontWithName:@"SourceSansPro-Light" size:14.0]];
    }

    for (UILabel *label in self.titlesLabel) {
        [label setFont:[UIFont fontWithName:@"SourceSansPro-Regular" size:20.0]];
    }
    NSLog(@"%f",self.view.frame.size.height);
    if(self.view.frame.size.height<=480){
         self.headerLabel.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:11.0];
    }else if(self.view.frame.size.height==568){
        self.headerLabel.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:11.0];
    }else
    self.headerLabel.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:14.0];
}

/*- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL tutorialViewed = [defaults boolForKey:@"tutorial_viewed"];
    if (!tutorialViewed) {
        [self performSegueWithIdentifier:@"goToTutorial" sender:self];
        [defaults setBool:YES forKey:@"tutorial_viewed"];
    }
}*/

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

/*- (IBAction)propuestasAction:(id)sender {
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded || FBSession.activeSession.state == FBSessionStateOpen) {
        [self performSegueWithIdentifier:@"goToPropuestas" sender:self];
    } else {
        [self performSegueWithIdentifier:@"goToLogin" sender:self];
    }
}*/

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
