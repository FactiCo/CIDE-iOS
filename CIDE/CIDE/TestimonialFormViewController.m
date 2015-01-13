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
@property (weak, nonatomic) IBOutlet UIView *container;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation TestimonialFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sendButton.titleLabel.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:16.0];
    
    [self.view bringSubviewToFront:self.container];
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
       [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)sendAction:(id)sender {
    [self.formController doneAction:sender];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
