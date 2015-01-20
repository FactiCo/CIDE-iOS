//
//  PropuestasCategoryViewController.h
//  CIDE
//
//  Created by Nayely Vergara on 10/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropuestasViewController.h"

@interface PropuestasCategoryViewController : UIViewController

@property (strong, nonatomic) NSString *category;
@property (nonatomic) NSUInteger pageIndex;
@property (strong, nonatomic) NSMutableArray *propuestas;

@property (weak, nonatomic) id<FacebookInfoDataSource> facebookDataSource;

@end
