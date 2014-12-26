//
//  TestimonialsTableViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 25/12/14.
//  Copyright (c) 2014 Nayely Vergara. All rights reserved.
//

#import "TestimonialsTableViewController.h"

@interface TestimonialsTableViewController () <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextView *explanationTextView;

@property (weak, nonatomic) IBOutlet UIPickerView *genderPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *educationPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *entityPicker;

@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *educationLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *entityLabel;

@property (nonatomic, retain) NSArray *genderData;
@property (nonatomic, retain) NSArray *educationData;
@property (nonatomic, retain) NSArray *categoryData;
@property (nonatomic, retain) NSArray *entityData;

@property (nonatomic) BOOL isGenderSelected;
@property (nonatomic) BOOL isEducationSelected;
@property (nonatomic) BOOL isCategorySelected;
@property (nonatomic) BOOL isEntitySelected;

@end

@implementation TestimonialsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.genderData = @[@"Masculino", @"Femenino"];
    self.educationData = @[@"Primaria", @"Secundaria", @"Técnico", @"Medio superior", @"Superior", @"Maestría", @"Doctorado"];
    self.categoryData = @[@"Justicia en el trabajo", @"Justicia en la familia", @"Justicia vecinal y comunitaria", @"Justicia para funcionarios", @"Justicia para emprendedores"];
    self.entityData = @[@"Aguascalientes", @"Baja California", @"Baja California Sur", @"Campeche", @"Chiapas", @"Chihuahua", @"Coahuila", @"Colima", @"Distrito Federal", @"Durango",@"Estado de México", @"Guanajuato", @"Guerrero", @"Hidalgo", @"Jalisco", @"Michoacán", @"Morelos", @"Nayarit", @"Nuevo León", @"Oaxaca", @"Puebla", @"Querétaro", @"Quintana Roo", @"San Luis Potosí", @"Sinaloa", @"Sonora", @"Tabasco", @"Tamaulipas", @"Tlaxcala", @"Veracruz", @"Yucatán", @"Zacatecas"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)doneAction:(id)sender {
    [self verifyCorrectData];
}


- (void)verifyCorrectData {
    if ([self.emailTextField.text length] > 0) {
        if (![self validateEmail: self.emailTextField.text]) {
            [self showAlert:@"Datos incorrectos" msg:@"Ingresa una dirección de correo válida"];
        }
    }
    if ([self.ageTextField.text length] == 0) {
        [self showAlert:@"Datos incompletos" msg:@"Ingresa tu edad"];
    } else {
        if (![self validateAge:self.ageTextField.text]) {
            [self showAlert:@"Datos incorrectos" msg:@"Ingresa una edad válida"];
        }
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

- (void)hideNumericKeyboard {
    if ([self.ageTextField isFirstResponder])
        [self.ageTextField resignFirstResponder];
}

#pragma mark - textField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nameTextField) {
        [self.emailTextField becomeFirstResponder];
    } else if (textField == self.emailTextField) {
        [self.ageTextField becomeFirstResponder];
    } else if (textField == self.ageTextField){
        [textField resignFirstResponder];
    }
    return NO;
}

#pragma mark - pickers

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 1) {
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
    }
    else {
        return self.tableView.rowHeight;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 1) {
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
    if(pickerView == self.genderPicker) {
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
    if(pickerView == self.genderPicker) {
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
    if (pickerView == self.genderPicker) {
        self.genderLabel.text = [self.genderData objectAtIndex:row];
    } else if (pickerView == self.educationPicker) {
        self.educationLabel.text = [self.educationData objectAtIndex:row];
    } else if (pickerView == self.categoryPicker) {
        self.categoryLabel.text = [self.categoryData objectAtIndex:row];
    } else if (pickerView == self.entityPicker) {
        self.entityLabel.text = [self.entityData objectAtIndex:row];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self hideNumericKeyboard];
}

@end
