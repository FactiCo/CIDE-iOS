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

@property (weak, nonatomic) IBOutlet UIButton *addTest;
@property (weak, nonatomic) IBOutlet UIButton *seeTest;

@end

@implementation CategoryDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageData = @[[UIImage imageNamed:@"trabajo.png"], [UIImage imageNamed:@"familia.png"], [UIImage imageNamed:@"vecinal.png"], [UIImage imageNamed:@"funcionarios.png"], [UIImage imageNamed:@"emprendedores.png"]];
    
    self.descriptionData = @[@"La Justicia Laboral es un tema pendiente en México. Actualmente, los procesos para obtener justicia en el trabajo son caros, complejos y las figuras de justicia alternativa se utilizan poco. ",@"Justicia en las Familias trata diversos temas y conflictos como el divorcio, sucesiones, pensiones alimenticias, entre otros. Es un tema complejo, pues intervienen relaciones de poder y vínculos afectivos. Las mujeres suelen ser las personas más desfavorecidas. ", @"La convivencia vecinal y comunitaria es probablemente el mayor tema de conflictos diarios entre personas que habitan un mismo espacio o territorio. Conflictos derivados de los espacios públicos y uso de suelo se tratarán en este apartado. ", @"Esta es la descripción de justicia para funcionarios", @"Emprender es un reto constante en términos legales. Los micro, pequeños y medianos empresarios se enfrentan a numerosos obstáculos y las alternativas de justicia son pocas. "];
    self.nameData = @[@"Justicia en el trabajo", @"Justicia en la familia", @"Justicia vecinal y comunitaria", @"Justicia para funcionarios", @"Justicia para emprendedores"];
    [self setDataCategory: self.option];
}

- (void)setDataCategory:(NSInteger )option {
    self.imageCategory.image = [self.imageData objectAtIndex:option];
    [self.view bringSubviewToFront:self.imageCategory];
    self.descriptionTextView.text = [self.descriptionData objectAtIndex:option];
    [self.view bringSubviewToFront:self.descriptionTextView];
    [self.view bringSubviewToFront:self.addTest];
    [self.view bringSubviewToFront:self.seeTest];
    
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
