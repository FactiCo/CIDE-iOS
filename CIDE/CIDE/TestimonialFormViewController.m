//
//  TestimonialFormViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 07/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import "TestimonialFormViewController.h"
#import "TestimonialsTableViewController.h"

@interface TestimonialFormViewController ()

@property (strong, nonatomic) TestimonialsTableViewController *formController;

@end

@implementation TestimonialFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"FormSegue"]) {
        self.formController = segue.destinationViewController;
        self.formController.option = self.option;
    }
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendAction:(id)sender {
    [self.formController doneAction:sender];
}

@end