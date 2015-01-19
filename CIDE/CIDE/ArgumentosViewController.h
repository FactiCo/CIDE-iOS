//
//  ArgumentosViewController.h
//  CIDE
//
//  Created by Nayely Vergara on 11/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ArgumentosControllerDelegate;
@protocol ArgumentosControllerDataSource;

@interface ArgumentosViewController : UIViewController

@property (strong, nonatomic) NSDictionary *propuesta;

@property (copy, nonatomic) NSString *facebookId;
@property (copy, nonatomic) NSString *facebookName;
@property (weak, nonatomic) id<ArgumentosControllerDelegate> delegate;
@property (weak, nonatomic) id<ArgumentosControllerDataSource> dataSource;

@end

@protocol ArgumentosControllerDelegate <NSObject>

@optional
- (void)argumentosControllerWillDismiss:(ArgumentosViewController *)controller;

@end

@protocol ArgumentosControllerDataSource <NSObject>

@property (copy, nonatomic) NSString *facebookId;
@property (copy, nonatomic) NSString *facebookName;

@end