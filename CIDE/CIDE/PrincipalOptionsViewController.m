//
//  PrincipalOptionsViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 31/12/14.
//  Copyright (c) 2014 Nayely Vergara. All rights reserved.
//

#import "PrincipalOptionsViewController.h"

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

- (IBAction)configAction:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Aviso de Privacidad", @"Tutorial", nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self performSegueWithIdentifier:@"goToAviso" sender:self];
    } else if (buttonIndex == 1) {
        [self performSegueWithIdentifier:@"goToTutorial2" sender:self];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
