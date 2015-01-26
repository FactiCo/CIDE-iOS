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
#import <QuartzCore/QuartzCore.h>
#import "CorePlot-CocoaTouch.h"
#import "CIDEColors.h"

@interface PropuestaDetailViewController () <UINavigationControllerDelegate, CPTPieChartDataSource, UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *propuestaLabel;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;

@property (strong, nonatomic) IBOutlet UIButton *voteButton1;
@property (strong, nonatomic) IBOutlet UIButton *voteButton2;
@property (strong, nonatomic) IBOutlet UIButton *voteButton3;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (strong, nonatomic) IBOutlet UIButton *button4;
@property (strong, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet UILabel *voteResultLabel;
@property (strong, nonatomic) IBOutlet UILabel *uselessView;

@property (strong, nonatomic) IBOutlet UIView *questionView;
@property (strong, nonatomic) IBOutlet CPTGraphHostingView *chartView;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *voteButtons;
@property (strong, nonatomic) NSDictionary *voteImagesDisabled;
@property (nonatomic) NSUInteger questionCount;
@property (strong, nonatomic) IBOutlet UIView *voteView1;
@property (strong, nonatomic) IBOutlet UIView *voteView2;
@property (strong, nonatomic) IBOutlet UIView *voteView3;
@property (strong, nonatomic) IBOutlet UIView *voteView4;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *buttonConstraint1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *buttonConstraint2;

@property (strong, nonatomic) CPTXYGraph *graph;
@property (strong, nonatomic) NSMutableArray *answersData;
@property (strong, nonatomic) NSMutableArray *answerTitles;
@property (nonatomic) NSInteger answerIndex;
@property (strong, nonatomic) NSMutableArray *answerColors;
@property (strong, nonatomic) NSArray *answerUIColors;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *webViewHeightConstraint;
@property (strong, nonatomic) IBOutlet UILabel *respondeLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *questionHeightConstraint;

@property (strong, nonatomic) NSArray *chartData;
@property (nonatomic) BOOL allowVote;

@end

@implementation PropuestaDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.voteImagesDisabled = @{@"favor": [UIImage imageNamed:@"botones_votacion-04.png"],
                                @"abstencion": [UIImage imageNamed:@"botones_votacion-05.png"],
                                @"contra": [UIImage imageNamed:@"botones_votacion-06.png"]};
    
    self.answerUIColors = @[[UIColor midGreen], [UIColor strongGreen], [UIColor lightGreen], [UIColor normalGreen]];
    self.answerColors = [NSMutableArray arrayWithCapacity:4];
    for (UIColor *color in self.answerUIColors) {
        [self.answerColors addObject:[CPTFill fillWithColor:[CPTColor colorWithCGColor:[color CGColor]]]];
    }
    
    self.chartView.hidden = YES;
    self.graph = [[CPTXYGraph alloc] initWithFrame:self.chartView.bounds];
    self.graph.masksToBorder = NO;
    self.graph.axisSet = nil;
    self.chartView.hostedGraph = self.graph;
    
    [self setupQuestion:self.propuesta[@"question"]];
    
    CGFloat radius = self.chartView.bounds.size.height / 2.0 - 20.0;
    CPTPieChart *pieChart = [[CPTPieChart alloc] init];
    pieChart.dataSource = self;
    pieChart.pieRadius = radius - 30.0;
    pieChart.centerAnchor = CGPointMake(0.5, 0.7);
    pieChart.startAngle = M_PI_4;
    pieChart.sliceDirection = CPTPieDirectionCounterClockwise;
    
    [self.graph addPlot:pieChart];
    
    CPTLegend *theLegend = [CPTLegend legendWithGraph:self.graph];
    [theLegend setNumberOfColumns:2];
    [self.graph setLegend:theLegend];
    [self.graph setLegendAnchor:CPTRectAnchorBottom];
    [self.graph setLegendDisplacement:CGPointMake(0.0, radius / 10.0)];
    
    self.voteResultLabel.hidden = YES;
    [self setupVotes:self.propuesta[@"votes"]];
    
    self.button1.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.button2.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.button3.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.categoryLabel.text = self.propuesta[@"category"];
    self.propuestaLabel.text = self.propuesta[@"title"];
    NSString *html = self.propuesta[@"description"];
    [self setupHtml:html];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.contentView.bounds.size.height);
    
    self.tabBarController.tabBar.tintColor = [UIColor colorWithRed:(80/255.0) green:(184/255.0) blue:(98/255.0) alpha:1];
    
    self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.width / 2.0;
    self.userImageView.layer.masksToBounds = YES;
    if (self.userImage) {
        self.userImageView.image = self.userImage;
    }
    self.authorLabel.text = self.propuesta[@"author"][@"name"];
}

- (void)setupHtml:(NSString *)html {
    NSMutableString *resultHtml = [NSMutableString stringWithString:html];
    NSError *error;
    
    NSRegularExpression *reWidth = [[NSRegularExpression alloc] initWithPattern:@"width=\"\\d+\"" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSRegularExpression *reHeight = [[NSRegularExpression alloc] initWithPattern:@"height=\"\\d+\"" options:NSRegularExpressionCaseInsensitive error:&error];
    
    [reWidth replaceMatchesInString:resultHtml options:0 range:NSMakeRange(0, [html length]) withTemplate:@"width=\"100%\""];
    
    [reHeight replaceMatchesInString:resultHtml options:0 range:NSMakeRange(0, [html length]) withTemplate:@"height=\"auto\""];
    
    NSRegularExpression *reYoutube = [[NSRegularExpression alloc] initWithPattern:@"<iframe src=\"//www" options:NSRegularExpressionCaseInsensitive error:&error];
    
    [reYoutube replaceMatchesInString:resultHtml options:0 range:NSMakeRange(0, [html length]) withTemplate:@"<iframe src=\"http://www"];
    
    [self.webView loadHTMLString:resultHtml baseURL:nil];
}

- (void)setupVotes:(NSDictionary *)votes {
    NSString *key = nil;
    for (NSString *voteKey in [votes allKeys]) {
        NSDictionary *value = votes[voteKey];
        for (NSDictionary *participante in value[@"participantes"]) {
            if ([self.facebookDataSource.facebookId isEqualToString:participante[@"fcbookid"]]) {
                key = voteKey;
                break;
            }
        }
        if (key) {
            break;
        }
    }
    if (key) {
        [self highlightVote:key];
        [self updateVoteResult:key];
    } else {
        self.allowVote = YES;
    }
}

- (void)setupQuestion:(NSDictionary *)question {
    self.answerIndex = -1;
    self.answersData = [NSMutableArray array];
    self.answerTitles = [NSMutableArray array];
    self.chartData = question[@"answers"];
    for (NSDictionary *answer in question[@"answers"]) {
        if ([answer[@"title"] length] == 0) {
            break;
        }
        [self.answersData addObject:answer[@"count"]];
        [self.answerTitles addObject:answer[@"title"]];
        self.questionCount += 1;
    }
    self.questionTextView.text = question[@"title"];
    NSInteger index = 0;
    for (UIButton *button in @[self.button1, self.button2, self.button3, self.button4]) {
        if (index < self.questionCount) {
            [button setTitle:question[@"answers"][index][@"title"] forState:UIControlStateNormal];
        } else {
            button.superview.hidden = YES;
            button.enabled = NO;
        }
        index++;
    }
    if (self.questionCount <= 2) {
        self.buttonConstraint1.constant = 8.0;
        self.buttonConstraint2.constant = 8.0;
    }
    if (self.questionCount == 0) {
        self.questionView.hidden = YES;
        self.respondeLabel.hidden = YES;
        self.questionHeightConstraint.constant = 1.0;
    }
    [self validateAnswers:question[@"answers"]];
}

- (void)validateAnswers:(NSArray *)answers {
    BOOL found = NO;
    NSString *title = nil;
    NSInteger count = 0;
    for (NSDictionary *answer in answers) {
        for (NSDictionary *participante in answer[@"participantes"]) {
            if ([self.facebookDataSource.facebookId isEqualToString:participante[@"fcbookid"]]) {
                found = YES;
                title = answer[@"title"];
                self.answerIndex = count;
                break;
            }
        }
        if (found) {
            break;
        }
        count++;
    }
    if (found) {
        [self updateAnswerResult:answers];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)voteAction:(UIButton *)sender {
    if (!self.facebookDataSource.facebookId || !self.allowVote) {
        return;
    }
    self.allowVote = NO;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = @"http://justiciacotidiana.mx:8080/justiciacotidiana/api/v1/votos";
    manager.requestSerializer = [[AFJSONRequestSerializer alloc] init];
    manager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    static NSString *values[] = {@"favor", @"abstencion", @"contra"};
    NSDictionary *params = @{@"proposalId": self.propuesta[@"_id"], @"fcbookid": self.facebookDataSource.facebookId, @"value": values[sender.tag]};
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"Success");
        [self updateVoteResult:values[sender.tag]];
        [self showAlertWithTitle:@"Gracias" message:@"Tu voto ha sido registrado"];
        [self highlightVote:values[sender.tag]];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error %@", error);
        self.allowVote = YES;
    }];
}

- (IBAction)answerAction:(UIButton *)sender {
    if (!self.facebookDataSource.facebookId) {
        return;
    }
    [self buttonsEnabled:NO];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = [NSString stringWithFormat:@"http://justiciacotidiana.mx:8080/justiciacotidiana/api/v1/preguntas/%@?answer=%@", self.propuesta[@"question"][@"_id"], self.propuesta[@"question"][@"answers"][sender.tag][@"_id"]];
    self.answerIndex = sender.tag;
    manager.requestSerializer = [[AFJSONRequestSerializer alloc] init];
    manager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
    [manager POST:url parameters:@{@"fcbookid": self.facebookDataSource.facebookId} success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"%@", responseObject);
        [self showAlertWithTitle:@"Gracias" message:@"Tu respuesta ha sido registrada"];
        [self buttonsEnabled:YES];
        [self updateAnswerResult:responseObject[@"statistics"]];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error %@", error);
        [self buttonsEnabled:YES];
    }];
}

- (void)updateVoteResult:(NSString *)key {
    NSDictionary *dict = @{@"favor": @"a favor", @"abstencion": @"abstinencia", @"contra": @"en contra"};
    self.voteResultLabel.hidden = NO;
    NSUInteger count = [self.propuesta[@"votes"][key][@"participantes"] count] + 1;
    self.voteResultLabel.text = [NSString stringWithFormat:@"%lu personas han votado %@ como tú", (unsigned long)count, dict[key]];
    self.voteResultLabel.hidden = NO;
}

- (void)updateAnswerResult:(NSArray *)data {
    self.chartData = data;
    [self.graph reloadData];
    for (UIView *view in self.questionView.subviews) {
        view.hidden = YES;
    }
    self.uselessView.hidden = NO;
    self.questionView.hidden = NO;
    self.chartView.hidden = NO;
    [self.questionView bringSubviewToFront:self.chartView];
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

- (void)voteButtonsHidden:(BOOL)hidden {
    for (UIButton *button in self.voteButtons) {
        button.hidden = hidden;
    }
}

- (void)voteButtonsEnabled:(BOOL)enabled {
    for (UIButton *button in self.voteButtons) {
        button.enabled = enabled;
    }
}

- (void)highlightVote:(NSString *)key {
    NSDictionary *voteValues = @{@"favor": self.voteButton1, @"abstencion": self.voteButton2, @"contra": self.voteButton3};
    for (NSString *voteKey in [voteValues allKeys]) {
        if (![key isEqualToString:voteKey]) {
            [voteValues[voteKey] setImage:self.voteImagesDisabled[voteKey] forState:UIControlStateNormal];
        }
    }
}

- (void)argumentosControllerWillDismiss:(ArgumentosViewController *)controller
{
    self.propuesta = controller.propuesta;
}

#pragma mark - Pie chart

- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return self.questionCount;
}

- (NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx {
    return self.chartData[idx][@"count"];
}

- (NSString *)legendTitleForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)idx
{
    return self.answerTitles[idx];
}

- (NSAttributedString *)attributedLegendTitleForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)idx
{
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:self.answerTitles[idx]];
    UIColor *color = idx == self.answerIndex ? self.answerUIColors[idx] : [UIColor blackColor];
    [string addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, [string length])];
    return string;
}

- (CPTFill *)sliceFillForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)idx {
    return self.answerColors[idx];
}

#pragma mark - Web view delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGSize fittingSize = [webView sizeThatFits:webView.bounds.size];
    self.webViewHeightConstraint.constant = fittingSize.height;
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
