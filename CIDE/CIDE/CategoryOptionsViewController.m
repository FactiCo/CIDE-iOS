//
//  CategoryOptionsViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 31/12/14.
//  Copyright (c) 2014 Nayely Vergara. All rights reserved.
//

#import "CategoryOptionsViewController.h"
#import "CategoryDescriptionViewController.h"
#import "MapViewController.h"
@interface CategoryOptionsViewController ()
@property (nonatomic)NSInteger option;

@end

@implementation CategoryOptionsViewController
{
    UIView *viewWhitOption1;
    UIView *viewWhitOption2;
    UIView *viewWhitOption3;
    UIView *viewWhitOption4;
    UIView *viewWhitOption5;
    UIImageView *background;
    float unitH;
    float unitw;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Test
    unitH=(self.view.frame.size.height/100);
    unitw=(self.view.frame.size.width/100);
    
    background=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20)];
    background.image=[UIImage imageNamed:@"fondo1.png"];
    [self.view addSubview:background];
    
    UIButton *back=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/100, 27, 80, 30)];
    back.backgroundColor=[UIColor clearColor];
    [back addTarget:self
                 action:@selector(backAction:)
       forControlEvents:UIControlEventTouchDown];
    [back setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    //[back setTitle:@"Regresar" forState:UIControlStateNormal];
    [back.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    
    UIButton *map=[[UIButton alloc]initWithFrame:CGRectMake(unitw*29, self.view.frame.size.height-unitH*4-50, unitw*42, 50)];
    map.backgroundColor=[UIColor colorWithRed:(108/255.0) green:(218/255.0) blue:(132/255.0) alpha:1];
    [map setTitle:@"Mapa de testimonios" forState:UIControlStateNormal];
   // [[map layer] setBorderWidth:2.0f];
    [map addTarget:self
             action:@selector(goToMAp:)
   forControlEvents:UIControlEventTouchDown];
    //[[map layer] setBorderColor:[UIColor whiteColor].CGColor];
     [map.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [self.view addSubview:map];
    [self.view addSubview:back];
    [self makeViews];

    
    
    // Do any additional setup after loading the view.
}
-(void)makeViews{
    
    //Views like buttons
    viewWhitOption1=[[UIView alloc]init];
    viewWhitOption1.frame=CGRectMake(unitw*5, 90,unitw*29, unitH*31);
    viewWhitOption1.backgroundColor=[UIColor whiteColor];
    viewWhitOption1.tag=0;
    
    
    /***************************************/
    /*  Codigo Gesto Touch para View     */
    /***************************************/
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    
    [viewWhitOption1 addGestureRecognizer:tapGesture];
    
    // Set Category Image
    UIImageView *category1=[[UIImageView alloc]initWithFrame:CGRectMake((viewWhitOption1.frame.size.width/10)*1, (viewWhitOption1.frame.size.height/10)*2, (viewWhitOption1.frame.size.width/10)*8, (viewWhitOption1.frame.size.width/10)*8)];
    category1.image=[UIImage imageNamed:@"iconos_categorias-02.png"];
    [viewWhitOption1 addSubview:category1];
    [self.view addSubview:viewWhitOption1];
    UILabel *textCategory1=[[UILabel alloc]initWithFrame:CGRectMake(category1.frame.origin.x, category1.frame.origin.y+category1.frame.size.height +5 , category1.frame.size.width, 30)];
    textCategory1.backgroundColor=[UIColor clearColor];
    textCategory1.text=@"Justicia en el trabajo";
    textCategory1.numberOfLines=2;
    textCategory1.textColor=[UIColor colorWithRed:(108/255.0) green:(218/255.0) blue:(132/255.0) alpha:1];
    [textCategory1 setFont:[UIFont boldSystemFontOfSize:10 ]];
    textCategory1.textAlignment=NSTextAlignmentCenter;

    [viewWhitOption1 addSubview: textCategory1];
    
    
    //Views like buttons
    viewWhitOption2=[[UIView alloc]init];
    viewWhitOption2.frame=CGRectMake(unitw*35, 90, unitw*29, unitH*31);
    viewWhitOption2.backgroundColor=[UIColor whiteColor];
    viewWhitOption2.tag=1;
    
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [viewWhitOption2 addGestureRecognizer:tapGesture2];
    
    // Set Category Image
    UIImageView *category2=[[UIImageView alloc]initWithFrame:CGRectMake((viewWhitOption2.frame.size.width/10)*1, (viewWhitOption2.frame.size.height/10)*2, (viewWhitOption2.frame.size.width/10)*8, (viewWhitOption2.frame.size.width/10)*8)];
    category2.image=[UIImage imageNamed:@"iconos_categorias-03.png"];
    [viewWhitOption2 addSubview:category2];
    [self.view addSubview:viewWhitOption2];
    UILabel *textCategory2=[[UILabel alloc]initWithFrame:CGRectMake(category2.frame.origin.x, category2.frame.origin.y+category2.frame.size.height +5 , category2.frame.size.width, 30)];
    textCategory2.backgroundColor=[UIColor clearColor];
    textCategory2.text=@"Justicia para familias";
    textCategory2.numberOfLines=2;
    textCategory2.textColor=[UIColor colorWithRed:(108/255.0) green:(218/255.0) blue:(132/255.0) alpha:1];
    [textCategory2 setFont:[UIFont boldSystemFontOfSize:10 ]];
    textCategory2.textAlignment=NSTextAlignmentCenter;
    
    [viewWhitOption2 addSubview: textCategory2];
    [self.view addSubview:viewWhitOption2];
    
    
    viewWhitOption3=[[UIView alloc]init];
    viewWhitOption3.frame=CGRectMake(unitw*65, 90, unitw*29, unitH*31);
    viewWhitOption3.backgroundColor=[UIColor whiteColor];
    viewWhitOption3.tag=2;
    /***************************************/
    /*  Codigo Gesto Touch para View     */
    /***************************************/
    
    UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    
    [viewWhitOption3 addGestureRecognizer:tapGesture3];
    
    // Set Category Image
    UIImageView *category3=[[UIImageView alloc]initWithFrame:CGRectMake((viewWhitOption3.frame.size.width/10)*1, (viewWhitOption3.frame.size.height/10)*2, (viewWhitOption3.frame.size.width/10)*8, (viewWhitOption3.frame.size.width/10)*8)];
    category3.image=[UIImage imageNamed:@"iconos_categorias-04.png"];
    [viewWhitOption3 addSubview:category3];
    [self.view addSubview:viewWhitOption3];
    UILabel *textCategory3=[[UILabel alloc]initWithFrame:CGRectMake(category3.frame.origin.x, category3.frame.origin.y+category3.frame.size.height +5 , category3.frame.size.width, 30)];
    textCategory3.backgroundColor=[UIColor clearColor];
    textCategory3.text=@"Justicia vecinal y comunitaria";
    textCategory3.numberOfLines=2;
    textCategory3.textColor=[UIColor colorWithRed:(108/255.0) green:(218/255.0) blue:(132/255.0) alpha:1];    [textCategory3 setFont:[UIFont boldSystemFontOfSize:10 ]];
    textCategory3.textAlignment=NSTextAlignmentCenter;
    
    [viewWhitOption3 addSubview: textCategory3];
    
    [self.view addSubview:viewWhitOption3];
    
    //view4
    
    viewWhitOption4=[[UIView alloc]init];
    viewWhitOption4.frame=CGRectMake(unitw*5, 90+viewWhitOption3.frame.size.height+unitH*3, unitw*29, unitH*31);
    viewWhitOption4.backgroundColor=[UIColor whiteColor];
    viewWhitOption4.tag=3;
    /***************************************/
    /*  Codigo Gesto Touch para View     */
    /***************************************/
    
    UITapGestureRecognizer *tapGesture4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    
    [viewWhitOption4 addGestureRecognizer:tapGesture4];
    
    // Set Category Image
    UIImageView *category4=[[UIImageView alloc]initWithFrame:CGRectMake((viewWhitOption4.frame.size.width/10)*1, (viewWhitOption4.frame.size.height/10)*2, (viewWhitOption4.frame.size.width/10)*8, (viewWhitOption4.frame.size.width/10)*8)];
    category4.image=[UIImage imageNamed:@"iconos_categorias-05.png"];
    [viewWhitOption4 addSubview:category4];
    [self.view addSubview:viewWhitOption4];
    UILabel *textCategory4=[[UILabel alloc]initWithFrame:CGRectMake(category4.frame.origin.x, category4.frame.origin.y+category4.frame.size.height +5 , category4.frame.size.width, 30)];
    textCategory4.backgroundColor=[UIColor clearColor];
    textCategory4.text=@"Justicia para ciudadanos";
    textCategory4.numberOfLines=2;
    textCategory4.textColor=[UIColor colorWithRed:(108/255.0) green:(218/255.0) blue:(132/255.0) alpha:1];
    [textCategory4 setFont:[UIFont boldSystemFontOfSize:10 ]];
    textCategory4.textAlignment=NSTextAlignmentCenter;
    
    [viewWhitOption4 addSubview: textCategory4];
    
    [self.view addSubview:viewWhitOption4];

    // View 5
    
    viewWhitOption5=[[UIView alloc]init];
    viewWhitOption5.frame=CGRectMake(unitw*35, 90+viewWhitOption1.frame.size.height+unitH*3, unitw*29, unitH*31);
    viewWhitOption5.backgroundColor=[UIColor whiteColor];
    viewWhitOption5.tag=3;
    /***************************************/
    /*  Codigo Gesto Touch para View     */
    /***************************************/
    
    UITapGestureRecognizer *tapGesture5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    
    [viewWhitOption5 addGestureRecognizer:tapGesture5];
    
    // Set Category Image
    UIImageView *category5=[[UIImageView alloc]initWithFrame:CGRectMake((viewWhitOption5.frame.size.width/10)*1, (viewWhitOption5.frame.size.height/10)*2, (viewWhitOption5.frame.size.width/10)*8, (viewWhitOption5.frame.size.width/10)*8)];
    category5.image=[UIImage imageNamed:@"iconos_categorias-06.png"];
    [viewWhitOption5 addSubview:category5];
    [self.view addSubview:viewWhitOption5];
    UILabel *textCategory5=[[UILabel alloc]initWithFrame:CGRectMake(category5.frame.origin.x, category5.frame.origin.y+category5.frame.size.height +5 , category5.frame.size.width, 30)];
    textCategory5.backgroundColor=[UIColor clearColor];
    textCategory5.text=@"Justicia para emprendedores";
    textCategory5.numberOfLines=4;
    textCategory5.textColor=[UIColor colorWithRed:(108/255.0) green:(218/255.0) blue:(132/255.0) alpha:1];
    [textCategory5 setFont:[UIFont boldSystemFontOfSize:10 ]];
    textCategory5.textAlignment=NSTextAlignmentCenter;
    
    [viewWhitOption5 addSubview: textCategory5];
    
    [self.view addSubview:viewWhitOption5];


}
-(void)goToDescription2:(int)option{

    CategoryDescriptionViewController *description;
    description.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    description=[[self storyboard] instantiateViewControllerWithIdentifier:@"description"];
    description.option=option;
    [self presentViewController:description animated:NO completion:NULL];

}
-(void) tapView:(UITapGestureRecognizer *)gestureRecognizer{
    
    //Get the View Tag
     int option =(int)gestureRecognizer.view.tag;
    [self goToDescription2:option];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToDescription:(id)sender {
    self.option = [sender tag];
    [self performSegueWithIdentifier:@"goToDescription" sender:self];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    }

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToDescription"]) {
        CategoryDescriptionViewController *controller = segue.destinationViewController;
        controller.option = self.option;
    }
}
-(IBAction)goToMAp:(id)sender{
    MapViewController *mapa;
    mapa.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    mapa=[[self storyboard] instantiateViewControllerWithIdentifier:@"mapa"];
    
    [self presentViewController:mapa animated:NO completion:NULL];

}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
