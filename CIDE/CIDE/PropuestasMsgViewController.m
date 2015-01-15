//
//  PropuestasMsgViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 15/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import "PropuestasMsgViewController.h"

@interface PropuestasMsgViewController ()
@property (strong, nonatomic) IBOutlet UITextView *descriptionText;

@end

@implementation PropuestasMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.descriptionText.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:16.0];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
