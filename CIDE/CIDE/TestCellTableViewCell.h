//
//  TestCellTableViewCell.h
//  CIDE
//
//  Created by Nayely Vergara on 04/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *explanationTextView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (copy, nonatomic) NSString *identifier;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;

@end
