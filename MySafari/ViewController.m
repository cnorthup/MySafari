//
//  ViewController.m
//  MySafari
//
//  Created by Charles Northup on 3/12/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIScrollViewDelegate, UINavigationBarDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UITextField *myURLTextField;
@property (weak, nonatomic) IBOutlet UIButton *isBackButtonAbleToWork;
@property (weak, nonatomic) IBOutlet UIButton *isForwardButtonAbleToWork;
@property (weak, nonatomic) IBOutlet UIButton *isStopButtonAbleToWork;
@property (weak, nonatomic) IBOutlet UIButton *isReloadButtonAbleToWork;
@property(nonatomic, getter=isNetworkActivityIndicatorVisible) BOOL networkActivityIndicatorVisible;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBarTitle;
//@property (nonatomic) float placeOnScreen;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSString *urlString = @"http://www.google.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
    self.myWebView.scrollView.delegate = self;
    //self.networkActivityIndicatorVisible = YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *header = @"http://";
    NSString *lazyHeader = @"www.";
    NSString *enteredURL = _myURLTextField.text;
    NSString *correctURL = @"";
    NSString *isHeaderThere = [enteredURL substringToIndex:7];
    NSString *isLazyHeaderThere = [enteredURL substringToIndex:4];
    NSLog(@"%@", isLazyHeaderThere);
    
    if ([isHeaderThere isEqualToString:header]) {
        correctURL = enteredURL;
        
    }
    else {
        
        if([isLazyHeaderThere isEqualToString:lazyHeader]){
            correctURL = [header stringByAppendingString:enteredURL];
        }
        else{
            
        correctURL = [header stringByAppendingString:[lazyHeader stringByAppendingString:enteredURL]];
        }
    }

    
    NSLog(@"%@", correctURL);
    _myURLTextField.text = correctURL;
    NSURL *url = [NSURL URLWithString:_myURLTextField.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myURLTextField resignFirstResponder];
    [self.myWebView loadRequest:request];
    NSString *title = [correctURL substringWithRange:NSMakeRange(11,(correctURL.length - 15))];
    NSLog(@"%@", title);
    [self.navBarTitle setTitle:title];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.myWebView.canGoBack == YES) {
        self.isBackButtonAbleToWork.enabled = YES;
        
    } else if (self.myWebView.canGoBack == NO){
        self.isBackButtonAbleToWork.enabled = NO;
    }
    
    if (self.myWebView.canGoForward == YES) {
        self.isForwardButtonAbleToWork.enabled = YES;
        
    } else if (self.myWebView.canGoForward == NO){
        self.isForwardButtonAbleToWork.enabled = NO;
    }
    self.isStopButtonAbleToWork.enabled = NO;
    self.isReloadButtonAbleToWork.enabled = YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.isStopButtonAbleToWork.enabled = YES;
    self.isReloadButtonAbleToWork.enabled = NO;
}

- (IBAction)onBackButtonPressed:(id)sender {
    [self.myWebView goBack];
}
- (IBAction)onForwardButtonPressed:(id)sender {
    [self.myWebView goForward];
}
- (IBAction)onStopLoadingButtonPressed:(id)sender {
    [self.myWebView stopLoading];
}
- (IBAction)onReloadButtonPressed:(id)sender {
    [self.myWebView reload];
}
- (IBAction)onTeaserButtonPressed:(id)sender {
    UIAlertView *teaser = [[UIAlertView alloc] initWithTitle:@"Get a Life!" message:@"Feature Coming soon!" delegate:self cancelButtonTitle:@"Go Back" otherButtonTitles:nil];
    [teaser show];
}
- (IBAction)onClearButtonPressed:(id)sender {
    _myURLTextField.text =@"";
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /*        CGRect newSize = self.myWebView.frame;
     CGRect textSize = self.myURLTextField.frame;
     newSize.size.height = newSize.size.height + textSize.size.height;
     //newSize.origin.y = textSize.origin.y;
     //self.myWebView.frame = newSize;
     */
    
    NSLog(@"%f", self.myWebView.scrollView.contentOffset.y);
    if (self.myWebView.scrollView.contentOffset.y > 100) {
        [[self myURLTextField] setHidden:YES];
        
        
    }
    else{
        [[self myURLTextField] setHidden:NO];
    }
    
}
@end
