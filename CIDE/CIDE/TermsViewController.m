//
//  TermsViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 15/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import "TermsViewController.h"

@interface TermsViewController ()
@property (strong, nonatomic) IBOutlet UITextView *termsText;
@property (strong, nonatomic) IBOutlet UILabel *navigationTitle;

@end

@implementation TermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.termsText.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:14.0];
    self.navigationTitle.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:18.0];
}
- (IBAction)doneAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
