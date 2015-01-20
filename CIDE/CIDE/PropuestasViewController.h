//
//  PropuestasViewController.h
//  CIDE
//
//  Created by Nayely Vergara on 10/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FacebookInfoDataSource <NSObject>

@property (copy, nonatomic) NSString *facebookId;
@property (copy, nonatomic) NSString *facebookName;

@end

@interface PropuestasViewController : UIViewController <FacebookInfoDataSource>

@end
