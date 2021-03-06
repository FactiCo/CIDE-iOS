//
//  PropuestasViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 10/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import "PropuestasViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <AFHTTPRequestOperationManager.h>
#import "PropuestasCategoryViewController.h"
#import "PropuestaDetailViewController.h"
#import "ArgumentosViewController.h"

@interface PropuestasViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, PropuestasCategoryDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSDictionary *propuesta;
@property (strong, nonatomic) UIImage *userImage;


@end

@implementation PropuestasViewController

@synthesize facebookId = _facebookId;
@synthesize facebookName = _facebookName;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    TODO cambiar la primer categoria
    
    
    self.categories = @[@"Justicia en el trabajo", @"Justicia para ciudadanos", @"Justicia para familias", @"Justicia para emprendedores", @"Justicia vecinal y comunitaria",@"Otros temas de Justicia Cotidiana"];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    PropuestasCategoryViewController *startingViewController = [self viewControllerAtIndex:0];
    [self.pageViewController setViewControllers:@[startingViewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self.view addSubview:self.pageViewController.view];
    
    CGRect pageViewRect = self.view.frame;
    self.pageViewController.view.frame = pageViewRect;
    [self.pageViewController didMoveToParentViewController:self];
    
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
    [self.view bringSubviewToFront:self.backButton];
    [self.view bringSubviewToFront:self.pageControl];
    
    [self getFacebookData];
}

- (void)getFacebookData {
    
    if (FBSession.activeSession.isOpen) {
        
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 self.facebookId = user.objectID;
                 self.facebookName = user.name;
             }
         }];
    } else if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"] allowLoginUI:NO completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
            [[FBRequest requestForMe] startWithCompletionHandler:
             ^(FBRequestConnection *connection,
               NSDictionary<FBGraphUser> *user,
               NSError *error) {
                 if (!error) {
                     self.facebookId = user.objectID;
                     self.facebookName = user.name;
                 }
             }];
            
        }];
    }
}

- (PropuestasCategoryViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (index < [self.categories count]) {
        PropuestasCategoryViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"PropuestasCategoryController"];
        controller.category = self.categories[index];
        controller.pageIndex = index;
        controller.facebookDataSource = self;
        controller.delegate = self;
        
        return controller;
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    PropuestasCategoryViewController *controller = (PropuestasCategoryViewController *)viewController;
    if (controller.pageIndex > 0) {
        return [self viewControllerAtIndex:controller.pageIndex - 1];
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    PropuestasCategoryViewController *controller = (PropuestasCategoryViewController *)viewController;
    if (controller.pageIndex < [self.categories count] - 1) {
        return [self viewControllerAtIndex:controller.pageIndex + 1];
    }
    return nil;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (!completed){return;}
    
    // Find index of current page
    PropuestasCategoryViewController *controller = (PropuestasCategoryViewController *)[self.pageViewController.viewControllers lastObject];
    NSUInteger indexOfCurrentPage = controller.pageIndex;
    ;
    self.pageControl.currentPage = indexOfCurrentPage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)pageChanged:(UIPageControl *)sender {
    UIViewController *controller = [self viewControllerAtIndex:sender.currentPage];
    [self.pageViewController setViewControllers:@[controller] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

#pragma mark - Propuesta delegate

- (void)propuestasCategoryController:(PropuestasCategoryViewController *)controller didSelectPropuesta:(NSDictionary *)propuesta withImage:(UIImage *)image
{
    self.propuesta = propuesta;
    self.userImage = image;
    [self performSegueWithIdentifier:@"PropuestaDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PropuestaDetail"]) {
        UITabBarController *tabController = segue.destinationViewController;
        PropuestaDetailViewController *controller = tabController.viewControllers[0];
        controller.propuesta = self.propuesta;
        controller.userImage = self.userImage;
        controller.facebookDataSource = self;
        
        ArgumentosViewController *argumentosController = tabController.viewControllers[1];
        argumentosController.propuesta = self.propuesta;
        argumentosController.delegate = controller;
        argumentosController.facebookDataSource = self;
    }
}

@end
