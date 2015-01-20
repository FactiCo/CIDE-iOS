//
//  PropTableViewCell.h
//  CIDE
//
//  Created by Nayely Vergara on 17/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *genderImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *votacionLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end
