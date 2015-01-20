//
//  ArgumentosViewController.h
//  CIDE
//
//  Created by Nayely Vergara on 11/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropuestasViewController.h"

@protocol ArgumentosControllerDelegate;

@interface ArgumentosViewController : UIViewController

@property (strong, nonatomic) NSDictionary *propuesta;

@property (weak, nonatomic) id<ArgumentosControllerDelegate> delegate;
@property (weak, nonatomic) id<FacebookInfoDataSource> facebookDataSource;

@end

@protocol ArgumentosControllerDelegate <NSObject>

@optional
- (void)argumentosControllerWillDismiss:(ArgumentosViewController *)controller;

@end
