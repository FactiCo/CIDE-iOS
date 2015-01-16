//
//  CategoryDescriptionViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 31/12/14.
//  Copyright (c) 2014 Nayely Vergara. All rights reserved.
//

#import "CategoryDescriptionViewController.h"
#import <AFHTTPRequestOperationManager.h>
#import "TestimonialsTableViewController.h"
#import "SeeTestTableViewController.h"
#import "TestCellTableViewCell.h"
#import "TestimonialFormViewController.h"
#import "TestimonialsListViewController.h"
#import "InfoViewController.h"

@interface CategoryDescriptionViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) NSArray *imageData;
@property (nonatomic, retain) NSArray *descriptionData;
@property (nonatomic, retain) NSArray *headers;
@property (nonatomic, retain) NSArray *descriptionLargeData;
@property (nonatomic, retain) NSArray *nameData;
@property (strong, nonatomic) IBOutlet UIView *tableHeaderContainer;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *mainContainer;
@property (strong, nonatomic) IBOutlet UILabel *recientesLabel;

@property (weak, nonatomic) IBOutlet UILabel *navigationTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageCategory;

@property (weak, nonatomic) IBOutlet UIButton *addTest;
@property (weak, nonatomic) IBOutlet UIButton *seeTest;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *tableContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *controlView;

@property (strong, nonatomic) IBOutlet UIView *descriptionContainer;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *descriptionHeightConstraint;

@property (strong, nonatomic) NSMutableArray *testimonials;
@property (strong, nonatomic) NSMutableArray *allTestimonials;

@property (strong, nonatomic) UIImage *femeninoImage, *masculinoImage;

@end

@implementation CategoryDescriptionViewController
{
    UIView * aux;
}
- (void)viewDidLoad {
    
    _navigationTitle.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:18.0];
    
    [super viewDidLoad];
    self.imageData = @[[UIImage imageNamed:@"iconos_categorias-02.png"], [UIImage imageNamed:@"iconos_categorias-03.png"], [UIImage imageNamed:@"iconos_categorias-04.png"], [UIImage imageNamed:@"iconos_categorias-05.png"], [UIImage imageNamed:@"iconos_categorias-06.png"],[UIImage imageNamed:@"iconos_categorias-07.png"]];
    
    NSString *header1 = @"Justicia en el trabajo";
    NSString *text1 = @"Despidos injustificados, prestaciones no entregadas, legislación laboral no aplicada, son algunos temas que se abordan en el Foro \"Justicia en el trabajo\".\n\nLugar: Aguascalientes\nFecha: 22 de enero de 2015\n\n¿Tienes alguna experiencia qué contar? Mándanos tu testimonio.";
    
    NSString *header2 = @"Justicia para ciudadanos";
    NSString *text2 = @"Una multa injusta, una licitación fuera de la ley o el mal mantenimiento de las calles son ejemplos de actos de autoridad que se combaten ante tribunal. Estos temas se tratan en “Justicia para ciudadanos”.\n\nLugar: Guanajuato\nFecha: 29 de enero de 2015\n\n¿Tienes alguna experiencia qué contar? Mándanos tu testimonio. ";
    
    NSString *header3 = @"Justicia para familias";
    NSString *text3 = @"Divorcios, herencias, pensiones, tutelas o violencia familiar son temas complejos, pues entran en juego sentimientos y relaciones de poder. Estos temas se tratan en el Foro “Justicia para familias”.\n\nLugar: Tijuana\nFecha: 4 de febrero de 2015\n\n¿Tienes alguna experiencia qué contar? Mándanos tu testimonio.";
    
    NSString *header4 = @"Justicia para emprendedores";
    NSString *text4 = @"Para las empresas es arriesgado invertir cuando no cuentan con las instituciones de justicia adecuadas. Estos temas se discuten en el Foro “Justicia para emprendedores”.\n\nLugar: Monterrey\nFecha: 12 de febrero de 2015\n\n¿Tienes alguna experiencia qué contar? Mándanos tu testimonio.";
    
    NSString *header5 = @"Justicia vecinal y comunitaria";
    NSString *text5 = @"Contaminación ambiental, usos de suelo y prevención de la violencia vecinal y comunitaria son temas que se tratan en el Foro “Justicia vecinal y comunitaria”.\n\nLugar: Tuxtla Gutiérrez\nFecha: 19 de febrero de 2015\n\n¿Tienes alguna experiencia qué contar? Mándanos tu testimonio.";
    
    NSString *header6 = @"Otros temas de Justicia Cotidiana";
    NSString *text6 = @"Conflictos agrarios, protección a consumidores y a usuarios del sistema bancario son temas que se abordan en el Foro “Otras Justicias”.\n\nLugar: Ciudad de México\nFecha: 26 de febrero de 2015";
    
    self.headers = @[header1, header2, header3, header4, header5, header6];
    self.descriptionData = @[text1, text2, text3, text4, text5, text6];
    
    
    //Info large
    //Textos que Jordy mando al mail 
    self.descriptionLargeData = @[@"",@"",@"",@"",@"",@""];
    //SET FONT
    self.descriptionTextView.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:553.0];
    self.addTest.titleLabel.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:16.0];
    self.seeTest.titleLabel.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:16.0];
    self.descriptionLabel.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:17.0];
    self.recientesLabel.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:17.0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMoreDetail)];
    
    [_descriptionTextView addGestureRecognizer:tap];
    
    self.nameData = @[@"Justicia en el trabajo", @"Justicia para ciudadanos", @"Justicia para familias", @"Justicia para emprendedores", @"Justicia vecinal y comunitaria",@"Otros temas de Justicia Cotidiana"];
    
    self.femeninoImage = [UIImage imageNamed:@"femenino.png"];
    self.masculinoImage = [UIImage imageNamed:@"masculino.png"];
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:(108/255.0) green:(218/255.0) blue:(132/255.0) alpha:1]];
    self.tableContainer.hidden = YES;
    
    [self.activityIndicator startAnimating];
    
    [self setDataCategory: self.option];
}

- (void)showMoreDetail {
    [self performSegueWithIdentifier:@"goToInfo" sender:self];
}

- (void)setDataCategory:(NSInteger )option {
    self.navigationTitle.text = self.nameData[option];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"iconos_categorias-0%ld.png", option + 2]];
    self.imageCategory.image = image;
    [self.view bringSubviewToFront:self.imageCategory];
    self.descriptionTextView.text = [self.descriptionData objectAtIndex:option];
    CGSize size = [self.descriptionTextView sizeThatFits:self.descriptionTextView.bounds.size];
    self.descriptionHeightConstraint.constant = size.height + 90.0;
    self.descriptionLabel.text = self.headers[option];
//    _descriptionTextView.textColor=[UIColor blackColor];
    self.descriptionTextView.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:14.0];
    [self.descriptionTextView setContentOffset:CGPointZero animated:YES];
    //[_descriptionTextView sizeToFit];
    [self.view bringSubviewToFront:self.descriptionTextView];
    
    [self.view bringSubviewToFront:self.addTest];
//    [self.view bringSubviewToFront:self.seeTest];
    
    self.scrollView.contentSize = self.mainContainer.bounds.size;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToFormulario"]) {
        TestimonialFormViewController *controller = segue.destinationViewController;
        controller.option = self.option;
    }
    else if ([segue.identifier isEqualToString:@"goToSeeTest"]) {
        TestimonialsListViewController *controller = segue.destinationViewController;
        controller.option = self.option;
        controller.testimonials = self.allTestimonials;
    }
    else if ([segue.identifier isEqualToString:@"goToInfo"]) {
        InfoViewController *controller = segue.destinationViewController;
        controller.option = self.option;
    }
}

- (IBAction)seeMore:(id)sender {
    [self performSegueWithIdentifier:@"goToSeeTest" sender:self];
}


- (IBAction)backAction:(id)sender {
   // [self.navigationController popViewControllerAnimated:YES];
       [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - data

- (NSMutableArray *)testimonials {
    if (!_testimonials) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://justiciacotidiana.mx:8080/justiciacotidiana/api/v1/testimonios" parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject){
            [self.activityIndicator stopAnimating];
            self.activityIndicator.hidden = YES;
            _testimonials = [NSMutableArray arrayWithCapacity:3];
            _allTestimonials = [NSMutableArray array];
            
            for (NSDictionary *item in responseObject[@"items"]) {
                if ([item[@"category"] isEqualToString:self.nameData[self.option]]) {
                    if ([_testimonials count] < 3) {
                        [_testimonials addObject:item];
                    }
                    [_allTestimonials addObject:item];
                }
            }
            [self showTableWithCount:[_testimonials count]];
            if ([_testimonials count]) {
                [self.tableView reloadData];
            }
            else{
                self.tableView.hidden=TRUE;
                self.seeTest.hidden=TRUE;
                self.tableHeaderContainer.hidden = YES;
                UILabel *empty = [[UILabel alloc]initWithFrame:CGRectMake(16, self.view.frame.size.height - 100, self.view.frame.size.width - 32, 40)];
                empty.textAlignment = NSTextAlignmentCenter;
                empty.backgroundColor = [UIColor whiteColor];
                
                empty.text = @"Sin testimonios en esta categoría";
                [self.view addSubview:empty];
            }
            self.scrollView.contentSize = self.mainContainer.bounds.size;
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error %@", error);
            [self.activityIndicator stopAnimating];
            self.activityIndicator.hidden = YES;
        }];
        _testimonials = [NSMutableArray array];
    }
    return _testimonials;
}

- (void)showTableWithCount:(NSInteger)count {
    CGFloat height = 70 * count + 80;
    self.tableHeightConstraint.constant = height;
    self.tableContainer.hidden = NO;
}

#pragma mark - table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.testimonials count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleCell = @"TestCell";
    TestCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleCell];
    if (cell == nil) {
        cell = [[TestCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleCell];
    }
    NSDictionary *data = self.testimonials[indexPath.row];
    //SET FONT
    cell.nameLabel.font = [UIFont fontWithName:@"SourceSansPro-Bold" size:16.0];
    cell.explanationTextView.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:14.0];
    
    cell.nameLabel.text = data[@"name"];
    cell.explanationTextView.text = data[@"explanation"];
    if ([data[@"gender"] isEqualToString:@"Mujer"]) {
        cell.profileImageView.image = self.femeninoImage;
    } else {
        cell.profileImageView.image = self.masculinoImage;
    }
    return cell;
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"goToSeeTest" sender:self];
}

@end
