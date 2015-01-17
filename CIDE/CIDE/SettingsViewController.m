//
//  SettingsViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 06/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (strong, nonatomic) IBOutlet UIButton *aboutButton;
@property (strong, nonatomic) IBOutlet UIButton *conditionsButton;
@property (strong, nonatomic) IBOutlet UITextView *textView;




@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.aboutButton.titleLabel setFont:[UIFont fontWithName:@"SourceSansPro-Bold" size:20.0]];
    if(self.view.frame.size.height<=480){
       [self.conditionsButton.titleLabel setFont:[UIFont fontWithName:@"SourceSansPro-Bold" size:14.0]];
    }else if(self.view.frame.size.height==568){
        [self.conditionsButton.titleLabel setFont:[UIFont fontWithName:@"SourceSansPro-Bold" size:15.0]];
    }else
    [self.conditionsButton.titleLabel setFont:[UIFont fontWithName:@"SourceSansPro-Bold" size:20.0]];
    
    
    self.textView.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:16.0];

}

- (IBAction)closeAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
