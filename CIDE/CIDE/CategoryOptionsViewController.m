//
//  CategoryOptionsViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 31/12/14.
//  Copyright (c) 2014 Nayely Vergara. All rights reserved.
//

#import "CategoryOptionsViewController.h"
#import "CategoryDescriptionViewController.h"

@interface CategoryOptionsViewController ()
@property (nonatomic)NSInteger option;

@end

@implementation CategoryOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToDescription:(id)sender {
    self.option = [sender tag];
    [self performSegueWithIdentifier:@"goToDescription" sender:self];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToDescription"]) {
        CategoryDescriptionViewController *controller = segue.destinationViewController;
        controller.option = self.option;
    }
}

@end
