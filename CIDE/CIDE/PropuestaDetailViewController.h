//
//  PropuestaDetailViewController.h
//  CIDE
//
//  Created by Nayely Vergara on 11/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArgumentosViewController.h"

@interface PropuestaDetailViewController : UIViewController <ArgumentosControllerDelegate, ArgumentosControllerDataSource>

@property (strong, nonatomic) NSDictionary *propuesta;

@end
