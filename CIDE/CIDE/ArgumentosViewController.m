//
//  ArgumentosViewController.m
//  CIDE
//
//  Created by Nayely Vergara on 11/01/15.
//  Copyright (c) 2015 Nayely Vergara. All rights reserved.
//

#import "ArgumentosViewController.h"
#import <AFHTTPRequestOperationManager.h>
#import "TestCellTableViewCell.h"

@interface ArgumentosViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property (nonatomic) BOOL keyboardIsShown;
@property (copy, nonatomic) NSString *propuestaId;

@end

@implementation ArgumentosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.keyboardIsShown = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissComment)];
    [self.view addGestureRecognizer:tap];
    
    [self.tableView setSeparatorColor:[UIColor greenColor]];
    self.tableView.estimatedRowHeight = 70.0;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        self.tableView.rowHeight = UITableViewAutomaticDimension;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)dismissComment {
    if ([self.commentTextField isFirstResponder]) {
        [self.commentTextField resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(argumentosControllerWillDismiss:)]) {
        [self.delegate argumentosControllerWillDismiss:self];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Keyboard

- (void)keyboardWillShow:(NSNotification *)notification
{
    if (self.keyboardIsShown) return;
    CGSize keyboardSize = [[notification userInfo][UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSTimeInterval duration = [[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    CGFloat height = self.containerView.bounds.size.height;
//    CGFloat top = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 52.0 : 44.0;
    
    CGFloat constant;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
        constant = keyboardSize.height;
    } else {
        constant = UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? keyboardSize.width : keyboardSize.height;
    }
//    constant = constant + top - height;
    self.bottomConstraint.constant = constant;
    [self.view setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    self.keyboardIsShown = YES;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    CGFloat height = self.containerView.bounds.size.height;
    
    self.bottomConstraint.constant = 0.0;
    [self.view setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    self.keyboardIsShown = NO;
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)commentAction:(UIButton *)sender {
    if ([self.commentTextField.text length] && self.facebookDataSource.facebookId) {
        sender.enabled = NO;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *url = @"http://justiciacotidiana.mx:8080/justiciacotidiana/api/v1/comentarios";
        manager.requestSerializer = [[AFJSONRequestSerializer alloc] init];
        manager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
        
        NSDictionary *params = @{@"parent": @"", @"proposalId": self.propuesta[@"_id"], @"from": @{@"fcbookid": self.facebookDataSource.facebookId, @"name": self.facebookDataSource.facebookName}, @"message": self.commentTextField.text};
        [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
            NSLog(@"Success");
            self.propuestaId = self.propuesta[@"_id"];
            self.propuesta = nil;
            [self.tableView reloadData];
            [self showAlertWithTitle:@"Gracias" message:@"Tu comentario ha sido registrado"];
            sender.enabled = YES;
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error %@", error);
            sender.enabled = YES;
        }];
        [self.commentTextField resignFirstResponder];
    } else {
//        TODO alert
    }
}

#pragma mark - data

/*- (NSDictionary *)propuesta
{
    if (!_propuesta) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"http://justiciacotidiana.mx:8080/justiciacotidiana/api/v1/propuestas" parameters:@{} success:^(AFHTTPRequestOperation *operation, id responseObject){
//            [self.activityIndicator stopAnimating];
            for (NSDictionary *item in responseObject[@"items"]) {
                if ([item[@"_id"] isEqualToString:self.propuestaId]) {
                    _propuesta = item;
                    break;
                }
            }
            [self.tableView reloadData];
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error %@", error);
//            [self.activityIndicator stopAnimating];
        }];
    }
    return _propuesta;
}*/

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.propuesta[@"comments"][@"data"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleCell = @"ArgumentCell";
    TestCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleCell];
    if (cell == nil) {
        cell = [[TestCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleCell];
    }
    NSDictionary *comment = self.propuesta[@"comments"][@"data"][indexPath.row];
    cell.nameLabel.text = comment[@"from"][@"name"];
    cell.explanationTextView.text = comment[@"message"];
    
    cell.nameLabel.font = [UIFont fontWithName:@"SourceSansPro-Bold" size:16.0];
    cell.explanationTextView.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:14.0];
    cell.profileImageView.layer.cornerRadius = cell.profileImageView.bounds.size.width / 2.0;
    cell.profileImageView.layer.masksToBounds = YES;
    
    [self setUserImageWithComment:comment cell:cell];
    cell.identifier = comment[@"_id"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestCellTableViewCell *testCell = (TestCellTableViewCell *)cell;
    testCell.profileImageView.image = [UIImage imageNamed:@"masculino.png"];
}

- (void)setUserImageWithComment:(NSDictionary *)comment cell:(TestCellTableViewCell *)cell {
    NSString *imageURL = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=square", comment[@"from"][@"fcbookid"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([cell.identifier isEqualToString:comment[@"_id"]]) {
            cell.profileImageView.image = responseObject;
        } else {
            NSLog(@"cell different id");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
    }];
    [requestOperation start];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestCellTableViewCell *cell = (TestCellTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    CGSize size = [cell.explanationTextView sizeThatFits:cell.explanationTextView.bounds.size];
    return size.height + 40;
//    return UITableViewAutomaticDimension;
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
    [alert show];
}

@end
