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

@interface CategoryDescriptionViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) NSArray *imageData;
@property (nonatomic, retain) NSArray *descriptionData;
@property (nonatomic, retain) NSArray *nameData;

@property (weak, nonatomic) IBOutlet UILabel *navigationTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageCategory;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (weak, nonatomic) IBOutlet UIButton *addTest;
@property (weak, nonatomic) IBOutlet UIButton *seeTest;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *tableContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *controlView;

@property (strong, nonatomic) NSMutableArray *testimonials;

@property (strong, nonatomic) UIImage *femeninoImage, *masculinoImage;

@end

@implementation CategoryDescriptionViewController
{
    UIView * aux;
}
- (void)viewDidLoad {
    aux=[[UIView alloc]initWithFrame:CGRectMake(10, 30, self.view.frame.size.width-20, self.view.frame.size.height-40)];
    aux.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:aux];
    aux.hidden=TRUE;
    
    UIButton *close=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-50, 0, 30, 30)];
    close.backgroundColor=[UIColor clearColor];
    [close addTarget:self
             action:@selector(closeMoreDetail)
   forControlEvents:UIControlEventTouchDown];
    [close setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [aux addSubview:close];
    
    [super viewDidLoad];
    self.imageData = @[[UIImage imageNamed:@"trabajo.png"], [UIImage imageNamed:@"familia.png"], [UIImage imageNamed:@"vecinal.png"], [UIImage imageNamed:@"funcionarios.png"], [UIImage imageNamed:@"emprendedores.png"]];
    
    self.descriptionData = @[@"La Justicia Laboral es un tema pendiente en México. Actualmente, los procesos para obtener justicia en el trabajo son caros, complejos y las figuras de justicia alternativa se utilizan poco. ", @"Justicia en las Familias trata diversos temas y conflictos como el divorcio, sucesiones, pensiones alimenticias, entre otros. Es un tema complejo, pues intervienen relaciones de poder y vínculos afectivos. Las mujeres suelen ser las personas más desfavorecidas. ", @"La convivencia vecinal y comunitaria es probablemente el mayor tema de conflictos diarios entre personas que habitan un mismo espacio o territorio. Conflictos derivados de los espacios públicos y uso de suelo se tratarán en este apartado. ", @"Los ciudadanos tienen la facultad de defenderse frente a actos injustos de las autoridades. Sin embargo, en muchas ocasiones estos procesos resultan mucho más largos y complejos que la reparación del daño. La responsabilidad patrimonial del Estado es un tema fundamental.", @"Emprender es un reto constante en términos legales. Los micro, pequeños y medianos empresarios se enfrentan a numerosos obstáculos y las alternativas de justicia son pocas. "];
    
    //SET FONT
    self.descriptionTextView.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:53.0];
    self.addTest.titleLabel.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:16.0];
    self.seeTest.titleLabel.font = [UIFont fontWithName:@"RobotoSlab-Regular" size:16.0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMoreDetail)];
    
    [_descriptionTextView addGestureRecognizer:tap];
    
    
    self.nameData = @[@"Justicia en el trabajo", @"Justicia para familias", @"Justicia vecinal y comunitaria", @"Justicia para ciudadanos", @"Justicia para emprendedores"];
    
    self.femeninoImage = [UIImage imageNamed:@"femenino.png"];
    self.masculinoImage = [UIImage imageNamed:@"masculino.png"];
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:(108/255.0) green:(218/255.0) blue:(132/255.0) alpha:1]];
    self.tableContainer.hidden = YES;
    
    [self.activityIndicator startAnimating];
    
    [self setDataCategory: self.option];
}
-(void)showMoreDetail{
    aux.hidden=FALSE;
    _imageCategory.hidden=TRUE;
    _descriptionTextView.hidden=TRUE;
    _addTest.hidden=TRUE;
    


}
-(void)closeMoreDetail{
    aux.hidden=TRUE;
    _imageCategory.hidden=FALSE;
    _descriptionTextView.hidden=FALSE;
    _addTest.hidden=FALSE;
    

}
- (void)setDataCategory:(NSInteger )option {
    self.navigationTitle.text = self.nameData[option];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"iconos_categorias-0%ld.png", option + 2]];
    self.imageCategory.image = image;
    [self.view bringSubviewToFront:self.imageCategory];
    self.descriptionTextView.text = [self.descriptionData objectAtIndex:option];
    
    [self.view bringSubviewToFront:self.descriptionTextView];
    [_descriptionTextView sizeToFit];
    [self.view bringSubviewToFront:self.addTest];
    [self.view bringSubviewToFront:self.seeTest];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToFormulario"]) {
        TestimonialFormViewController *controller = segue.destinationViewController;
        controller.option = self.option;
    }
    if ([segue.identifier isEqualToString:@"goToSeeTest"]) {
        TestimonialsListViewController *controller = segue.destinationViewController;
        controller.option = self.option;
        controller.testimonials = self.testimonials;
        
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
            
            for (NSDictionary *item in responseObject[@"items"]) {
                if ([item[@"category"] isEqualToString:self.nameData[self.option]]) {
                    [_testimonials addObject:item];
                }
                if ([_testimonials count] >= 3) {
                    break;
                }
            }
            [self showTableWithCount:[_testimonials count]];
            if ([_testimonials count]) {
                [self.tableView reloadData];
            }
            else{
                self.tableView.hidden=TRUE;
                self.seeTest.hidden=TRUE;
                UILabel *empty = [[UILabel alloc]initWithFrame:CGRectMake(16, self.view.frame.size.height - 100, self.view.frame.size.width - 32, 40)];
                empty.textAlignment = NSTextAlignmentCenter;
                empty.backgroundColor = [UIColor whiteColor];
                
                empty.text = @"Sin testimonios en esta categoría";
                [self.view addSubview:empty];
            }
            
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
    CGFloat height = 70 * count + 30;
    height = MIN(height, self.controlView.bounds.size.height);
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
