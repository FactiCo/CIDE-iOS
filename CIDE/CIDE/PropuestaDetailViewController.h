//
//  PropuestaDetailViewController.h
//  CIDE
//
//  Created by Nayely Vergara on 11/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArgumentosViewController.h"
#import "PropuestasViewController.h"

@interface PropuestaDetailViewController : UIViewController <ArgumentosControllerDelegate>

@property (strong, nonatomic) NSDictionary *propuesta;
@property (weak, nonatomic) id<FacebookInfoDataSource> facebookDataSource;
@property (strong, nonatomic) UIImage *userImage;

@end
