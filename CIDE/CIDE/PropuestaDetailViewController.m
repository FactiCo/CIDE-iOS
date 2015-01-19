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
#import "ArgumentosViewController.h"

@interface PropuestaDetailViewController () <UINavigationControllerDelegate, ArgumentosControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *propuestaLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (strong, nonatomic) IBOutlet UITextView *questionTextView;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *voteButtons;

@property (copy, nonatomic) NSString *facebookId;
@property (copy, nonatomic) NSString *facebookName;

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
    _detailTextView.attributedText = attributedString;
    [self setupQuestion:self.propuesta[@"question"]];
    
    [self getFacebookData];
}

- (void)setupQuestion:(NSDictionary *)question {
    self.questionTextView.text = question[@"title"];
    self.button1.titleLabel.text = question[@"answers"][0][@"title"];
    self.button2.titleLabel.text = question[@"answers"][1][@"title"];
    self.button3.titleLabel.text = question[@"answers"][2][@"title"];
}

- (void)getFacebookData {
    FBSession *session = [[FBSession alloc] initWithPermissions:@[@"basic_info"]];
    [FBSession setActiveSession:session];
    
    [session openWithBehavior:FBSessionLoginBehaviorForcingWebView
            completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
        if (FBSession.activeSession.isOpen) {
            [[FBRequest requestForMe] startWithCompletionHandler:
             ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                 if (!error) {
                     self.facebookId = user.objectID;
                     self.facebookName = user.name;
                 }
             }];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)voteAction:(UIButton *)sender {
    if (!self.facebookId) {
        return;
    }
    [self voteButtonsEnabled:NO];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = @"http://justiciacotidiana.mx:8080/justiciacotidiana/api/v1/votos";
    manager.requestSerializer = [[AFJSONRequestSerializer alloc] init];
    manager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    static NSString *values[] = {@"favor", @"abstinencia", @"contra"};
    NSDictionary *params = @{@"proposalId": self.propuesta[@"_id"], @"fcbookid": self.facebookId, @"value": values[sender.tag]};
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"Success");
        [self showAlertWithTitle:@"Gracias" message:@"Tu voto ha sido registrado"];
        [self voteButtonsEnabled:YES];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error %@", error);
        [self voteButtonsEnabled:YES];
    }];
}

- (IBAction)answerAction:(UIButton *)sender {
    if (!self.facebookId) {
        return;
    }
    [self buttonsEnabled:NO];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"http://justiciacotidiana.mx:8080/justiciacotidiana/api/v1/preguntas/%@?answer=%@", self.propuesta[@"question"][@"_id"], self.propuesta[@"question"][@"answers"][sender.tag][@"_id"]];
    manager.requestSerializer = [[AFJSONRequestSerializer alloc] init];
    manager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    [manager POST:url parameters:@{@"fcbookid": self.facebookId} success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"Success");
        [self showAlertWithTitle:@"Gracias" message:@"Tu respuesta ha sido registrada"];
        [self buttonsEnabled:YES];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error %@", error);
        [self buttonsEnabled:YES];
    }];
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

- (void)voteButtonsEnabled:(BOOL)enabled {
    for (UIButton *button in self.voteButtons) {
        button.enabled = enabled;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"goToArgumentos"]) {
        ArgumentosViewController *controller = segue.destinationViewController;
        controller.propuesta = self.propuesta;
        controller.facebookId = self.facebookId;
        controller.facebookName = self.facebookName;
        controller.delegate = self;
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
