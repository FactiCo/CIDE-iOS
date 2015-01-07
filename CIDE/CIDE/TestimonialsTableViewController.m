//
//  TestimonialsTableViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 25/12/14.
//  Copyright (c) 2014 Nayely Vergara. All rights reserved.
//

#import "TestimonialsTableViewController.h"
#import <AFHTTPRequestOperationManager.h>
#import <Social/Social.h>

@interface TestimonialsTableViewController () <UITextFieldDelegate, UIPickerViewDelegate, UIAlertViewDelegate, UIPickerViewDataSource, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextView *explanationTextView;

@property (weak, nonatomic) IBOutlet UIPickerView *agePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *genderPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *educationPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *entityPicker;

@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *educationLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *entityLabel;
@property (weak, nonatomic) IBOutlet UILabel *explanationLabel;

@property (nonatomic, retain) NSArray *ageData;
@property (nonatomic, retain) NSArray *genderData;
@property (nonatomic, retain) NSArray *educationData;
@property (nonatomic, retain) NSArray *categoryData;
@property (nonatomic, retain) NSArray *entityData;
@property (nonatomic, retain) NSDictionary *params;
@property (nonatomic) NSInteger entityId;

@property (nonatomic) BOOL isAgeSelected;
@property (nonatomic) BOOL isGenderSelected;
@property (nonatomic) BOOL isEducationSelected;
@property (nonatomic) BOOL isCategorySelected;
@property (nonatomic) BOOL isEntitySelected;

@end

@implementation TestimonialsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.genderData = @[@"Hombre", @"Mujer", @"Sin especificar"];
    self.educationData = @[@"Sin estudios", @"Primaria", @"Secundaria", @"Técnico", @"Medio superior", @"Superior", @"Posgrado", @"Sin especificar"];
    self.categoryData = @[@"Justicia en el trabajo", @"Justicia en las familias", @"Justicia vecinal y comunitaria", @"Justicia para ciudadanos", @"Justicia para emprendedores"];
    self.entityData = @[@"Aguascalientes", @"Baja California", @"Baja California Sur", @"Campeche", @"Chiapas", @"Chihuahua", @"Coahuila", @"Colima", @"Distrito Federal", @"Durango",@"Estado de México", @"Guanajuato", @"Guerrero", @"Hidalgo", @"Jalisco", @"Michoacán", @"Morelos", @"Nayarit", @"Nuevo León", @"Oaxaca", @"Puebla", @"Querétaro", @"Quintana Roo", @"San Luis Potosí", @"Sinaloa", @"Sonora", @"Tabasco", @"Tamaulipas", @"Tlaxcala", @"Veracruz", @"Yucatán", @"Zacatecas"];
    self.ageData = @[@"Menos de 18 años", @"18 - 25 años", @"26 - 30 años",
                     @"31 - 35 años", @"36 - 40 años", @"41 - 45 años",
                     @"46 - 50 años", @"51 - 55 años", @"56 - 60 años",
                     @"61 - 65 años", @"66 - 70 años", @"Más de 70 años"];
    
    self.ageLabel.text = [self.ageData objectAtIndex:0];
    self.genderLabel.text = [self.genderData objectAtIndex:0];
    self.educationLabel.text = [self.educationData objectAtIndex:0];
    self.categoryLabel.text = [self.categoryData objectAtIndex:self.option];
    self.entityLabel.text = [self.entityData objectAtIndex:0];
    self.entityId = 1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)doneAction:(id)sender {
    BOOL data = [self verifyCorrectData];
    if (data) {
        [self collectData];
    }
}


- (BOOL)verifyCorrectData {
    if ([self.emailTextField.text length] > 0) {
        if (![self validateEmail: self.emailTextField.text]) {
            [self showAlert:@"Datos incorrectos" msg:@"Ingresa una dirección de correo válida"];
            return NO;
        }
    }
    if ([self.explanationTextView.text length] == 0) {
        [self showAlert:@"Datos incompletos" msg:@"Ingresa una explicación"];
        return NO;
    }
    
    return YES;
}

- (void)collectData {
    NSString *entity = [NSString stringWithFormat: @"%ld", (long)self.entityId];
    NSLog(@"%s",[self.ageLabel.text UTF8String]);
    NSString *ageAux= [NSString stringWithFormat:@"%s",[self.ageLabel.text UTF8String]];
    //NSLog(@"%s",[self.explanationTextView.text UTF8String]);
    NSString *explanationAux=[NSString stringWithFormat:@"%s",[self.explanationTextView.text UTF8String]];
    NSString *gradeAux=[NSString stringWithFormat:@"%s",[self.educationLabel.text UTF8String]];
    self.params = @{@"name":self.nameTextField.text, @"email":self.emailTextField.text, @"age":ageAux, @"gender":self.genderLabel.text, @"grade":gradeAux, @"category":self.categoryLabel.text, @"state":entity, @"explanation": explanationAux  };
    [self sendData];
}

- (void)sendData {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:@"http://justiciacotidiana.mx:8080/justiciacotidiana/api/v1/testimonios" parameters:self.params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"¡Gracias!" message:@"Gracias por enviar tu testimonio" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Compartir", nil];
        [alert setTag:1];
        [alert show];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            [alertView dismissWithClickedButtonIndex:1 animated:YES];
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Compartir vía:" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Facebook", @"Twitter", nil];
            [sheet showInView:self.view];
        }
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self postToFacebook];
    } else if (buttonIndex == 1) {
        [self postToTwitter];
    }
}

- (void)postToTwitter {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Acabo de compartir mi testimonio desde #JusticiaCotidiana www.justiciacotidiana.mx"];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    
}

- (void)postToFacebook {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:@"Acabo de compartir mi testimonio desde #JusticiaCotidiana www.justiciacotidiana.mx"];
        [self presentViewController:controller animated:YES completion:Nil];
    }
    
}

- (void)showAlert:(NSString *)title msg:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
    [alert show];
}

- (BOOL)validateAge:(NSString *)age {
    NSString *ageRegex =@"[0-9]+";
    NSPredicate *ageTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ageRegex];
    BOOL valid = [ageTest evaluateWithObject:age];
    if (!valid) {
        return NO;
    }
    NSInteger number=[age intValue];
    if (number > 0 && number < 120) {
        return YES;
    }
    return NO;
}

- (BOOL)validateEmail:(NSString *)candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}


- (BOOL)validateExplanationLength:(NSUInteger)length {
    return length <= 2000;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)string {
    return [self validateExplanationLength:self.explanationTextView.text.length + string.length - range.length];
}

- (void)hideNumericKeyboard {
    if ([self.emailTextField isFirstResponder])
        [self.emailTextField resignFirstResponder];
}

#pragma mark - textField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nameTextField) {
        [self.emailTextField becomeFirstResponder];
    } else if (textField == self.emailTextField) {
        [self.emailTextField resignFirstResponder];
    }
    return NO;
}

#pragma mark - pickers

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        if (self.isAgeSelected) {
            return 219;
        } else {
            return 44;
        }
    }
    else if (indexPath.section == 1 && indexPath.row == 1) {
        if (self.isGenderSelected) {
            return 219;
        } else {
            return 44;
        }
    } else if (indexPath.section == 1 && indexPath.row == 2){
        if (self.isEducationSelected) {
            return 219;
        } else {
            return 44;
        }
    } else if (indexPath.section == 2 && indexPath.row == 0){
        if (self.isCategorySelected) {
            return 219;
        } else {
            return 44;
        }
    } else if (indexPath.section == 2 && indexPath.row == 1){
        if (self.isEntitySelected) {
            return 219;
        } else {
            return 44;
        }
    } else if (indexPath.section == 2 && indexPath.row == 2){
        return 150;
    } else {
        return self.tableView.rowHeight;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self hidePickersExcept:&_isAgeSelected newValue:!self.isAgeSelected];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        [self hidePickersExcept:&_isGenderSelected newValue:!self.isGenderSelected];
    } else if (indexPath.section == 1 && indexPath.row == 2) {
        [self hidePickersExcept:&_isEducationSelected newValue:!self.isEducationSelected];
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        [self hidePickersExcept:&_isCategorySelected newValue:!self.isCategorySelected];
    } else if (indexPath.section == 2 && indexPath.row == 1) {
        [self hidePickersExcept:&_isEntitySelected newValue:!self.isEntitySelected];
    }
    [self hideNumericKeyboard];
}

- (void)hidePickersExcept:(BOOL *)flag newValue:(BOOL)value {
    self.isAgeSelected = NO;
    self.isGenderSelected = NO;
    self.isEducationSelected = NO;
    self.isCategorySelected = NO;
    self.isEntitySelected = NO;
    *flag = value;
    
    [self hideNumericKeyboard];
    [self.nameTextField resignFirstResponder];
    [self.explanationTextView resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.agePicker) {
        return [self.ageData count];
    } else if (pickerView == self.genderPicker) {
        return [self.genderData count];
    } else if (pickerView == self.educationPicker) {
        return [self.educationData count];
    } else if (pickerView == self.categoryPicker) {
        return [self.categoryData count];
    } else if (pickerView == self.entityPicker) {
        return [self.entityData count];
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.agePicker) {
        return [self.ageData objectAtIndex:row];
    } else if (pickerView == self.genderPicker) {
        return [self.genderData objectAtIndex:row];
    } else if (pickerView == self.educationPicker) {
        return [self.educationData objectAtIndex:row];
    } else if (pickerView == self.categoryPicker) {
        return [self.categoryData objectAtIndex:row];
    } else if (pickerView == self.entityPicker) {
        return [self.entityData objectAtIndex:row];
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.agePicker) {
        self.ageLabel.text = [self.ageData objectAtIndex:row];
    } else if (pickerView == self.genderPicker) {
        self.genderLabel.text = [self.genderData objectAtIndex:row];
    } else if (pickerView == self.educationPicker) {
        self.educationLabel.text = [self.educationData objectAtIndex:row];
    } else if (pickerView == self.categoryPicker) {
        self.categoryLabel.text = [self.categoryData objectAtIndex:row];
    } else if (pickerView == self.entityPicker) {
        self.entityLabel.text = [self.entityData objectAtIndex:row];
        self.entityId = row + 1;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self hideNumericKeyboard];
}

#pragma mark - textView explicacion

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (![textView hasText]) {
        self.explanationLabel.hidden = NO;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if(![textView hasText]) {
        self.explanationLabel.hidden = NO;
    } else {
        self.explanationLabel.hidden = YES;
    }
}

@end
