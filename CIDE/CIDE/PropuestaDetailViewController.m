//
//  PropuestaDetailViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 11/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import "PropuestaDetailViewController.h"
#import <AFHTTPRequestOperationManager.h>
#import <FacebookSDK/FacebookSDK.h>

@interface PropuestaDetailViewController () <UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *propuestaLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (strong, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet UILabel *voteResultLabel;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *voteButtons;
@property (strong, nonatomic) NSArray *voteImages;
@property (strong, nonatomic) NSArray *voteImagesDisabled;

@end

@implementation PropuestaDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.button1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.button2.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.button3.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.categoryLabel.text = self.propuesta[@"category"];
    self.propuestaLabel.text = self.propuesta[@"title"];
   // self.detailTextView.text = self.propuesta[@"description"];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[_propuesta[@"description"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.voteResultLabel.hidden = YES;
    self.detailTextView.attributedText = attributedString;
    [self setupQuestion:self.propuesta[@"question"]];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.contentView.bounds.size.height);
    
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:(80/255.0) green:(184/255.0) blue:(98/255.0) alpha:1];
    
    self.voteImages = @[[UIImage imageNamed:@"botones_votacion-01.png"], [UIImage imageNamed:@"botones_votacion-02.png"], [UIImage imageNamed:@"botones_votacion-03.png"]];
    
    self.voteImagesDisabled = @[[UIImage imageNamed:@"botones_votacion-04.png"], [UIImage imageNamed:@"botones_votacion-05.png"], [UIImage imageNamed:@"botones_votacion-06.png"]];
}

- (void)setupQuestion:(NSDictionary *)question {
    self.questionTextView.text = question[@"title"];
    self.button1.titleLabel.text = question[@"answers"][0][@"title"];
    self.button2.titleLabel.text = question[@"answers"][1][@"title"];
    self.button3.titleLabel.text = question[@"answers"][2][@"title"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)voteAction:(UIButton *)sender {
    if (!self.facebookDataSource.facebookId) {
        return;
    }
    [self voteButtonsEnabled:NO];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = @"http://justiciacotidiana.mx:8080/justiciacotidiana/api/v1/votos";
    manager.requestSerializer = [[AFJSONRequestSerializer alloc] init];
    manager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    static NSString *values[] = {@"favor", @"abstinencia", @"contra"};
    NSDictionary *params = @{@"proposalId": self.propuesta[@"_id"], @"fcbookid": self.facebookDataSource.facebookId, @"value": values[sender.tag]};
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"Success");
        [self updateVoteResult];
        [self showAlertWithTitle:@"Gracias" message:@"Tu voto ha sido registrado"];
        [self voteButtonsEnabled:YES];
        [self highlightVote:sender.tag];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error %@", error);
        [self voteButtonsEnabled:YES];
    }];
}

- (IBAction)answerAction:(UIButton *)sender {
    if (!self.facebookDataSource.facebookId) {
        return;
    }
    [self buttonsEnabled:NO];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"http://justiciacotidiana.mx:8080/justiciacotidiana/api/v1/preguntas/%@?answer=%@", self.propuesta[@"question"][@"_id"], self.propuesta[@"question"][@"answers"][sender.tag][@"_id"]];
    manager.requestSerializer = [[AFJSONRequestSerializer alloc] init];
    manager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    [manager POST:url parameters:@{@"fcbookid": self.facebookDataSource.facebookId} success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"Success");
        [self showAlertWithTitle:@"Gracias" message:@"Tu respuesta ha sido registrada"];
        [self buttonsEnabled:YES];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error %@", error);
        [self buttonsEnabled:YES];
    }];
}

- (void)updateVoteResult {
    [self buttonsHidden:YES];
    self.voteResultLabel.hidden = NO;
    // TODO asignar texto
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)buttonsEnabled:(BOOL)enabled {
    for (UIButton *button in @[self.button1, self.button2, self.button3]) {
        button.enabled = enabled;
    }
}

- (void)buttonsHidden:(BOOL)hidden {
    for (UIButton *button in @[self.button1, self.button2, self.button3]) {
        button.hidden = hidden;
    }
}

- (void)voteButtonsEnabled:(BOOL)enabled {
    for (UIButton *button in self.voteButtons) {
        button.enabled = enabled;
    }
}

- (void)highlightVote:(NSInteger)index {
    NSArray *buttons = @[self.button1, self.button2, self.button3];
    for (NSInteger i = 0; i < 3; i++) {
        if (index == i) {
            [buttons[i] setImage:self.voteImages[i] forState:UIControlStateNormal];
        } else {
            [buttons[i] setImage:self.voteImagesDisabled[i] forState:UIControlStateNormal];
        }
    }
}

- (void)argumentosControllerWillDismiss:(ArgumentosViewController *)controller
{
    self.propuesta = controller.propuesta;
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
