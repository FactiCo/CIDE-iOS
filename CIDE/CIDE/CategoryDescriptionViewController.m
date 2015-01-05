//
//  CategoryDescriptionViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 31/12/14.
//  Copyright (c) 2014 Nayely Vergara. All rights reserved.
//

#import "CategoryDescriptionViewController.h"
#import "TestimonialsTableViewController.h"
#import "SeeTestTableViewController.h"

@interface CategoryDescriptionViewController ()
@property (nonatomic, retain) NSArray *imageData;
@property (nonatomic, retain) NSArray *descriptionData;
@property (nonatomic, retain) NSArray *nameData;

@property (weak, nonatomic) IBOutlet UIImageView *imageCategory;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation CategoryDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageData = @[[UIImage imageNamed:@"trabajo.png"], [UIImage imageNamed:@"familia.png"], [UIImage imageNamed:@"vecinal.png"], [UIImage imageNamed:@"funcionarios.png"], [UIImage imageNamed:@"emprendedores.png"]];
    
    self.descriptionData = @[@"Esta es la descripcion  de justicia en el trabajo",@"Esta es la descripcion de justicia en la familia", @"Esta es la descripción de Justicia vecinal y comunitaria", @"Esta es la descripción de justicia para funcionarios", @"Esta es la descripción de Justicia para emprendedores"];
    self.nameData = @[@"Justicia en el trabajo", @"Justicia en la familia", @"Justicia vecinal y comunitaria", @"Justicia para funcionarios", @"Justicia para emprendedores"];
    [self setDataCategory: self.option];
}

- (void)setDataCategory:(NSInteger )option {
    self.imageCategory.image = [self.imageData objectAtIndex:option];
    self.descriptionTextView.text = [self.descriptionData objectAtIndex:option];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToFormulario"]) {
        TestimonialsTableViewController *controller = segue.destinationViewController;
        controller.option = self.option;
    }
    if ([segue.identifier isEqualToString:@"goToSeeTest"]) {
        SeeTestTableViewController *controller = segue.destinationViewController;
        controller.category = [self.nameData objectAtIndex:self.option];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
