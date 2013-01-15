//
//  ViewController.m
//  IBWebTOPNGDemo
//
//  Created by Ibrahim Qraiqe on 15.01.13.
//  Copyright (c) 2013 Ibrahim Qraiqe. All rights reserved.
//

#import "ViewController.h"
#import "IBWebToPNG.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.iphoneislam.com"]]];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    self.shareBtn.enabled = NO;
    [self.shareBtn setTitle:@"loading the page... wait" forState:UIControlStateNormal];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.shareBtn.enabled = YES;
    [self.shareBtn setTitle:@"SHARE" forState:UIControlStateNormal];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage*)loadImage:(NSString*)imageName {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", imageName]];
    
    return [UIImage imageWithContentsOfFile:fullPath];
    
}

- (IBAction)shareBtnDidTapped:(id)sender {
    [IBWebToPNG creatPNGSFromWebView:self.myWebView width:self.myWebView.bounds.size.width resultFileName:@"iphoneislam.png"];
    NSArray *activityItems = [NSArray arrayWithObjects:@"Converted WEB PAGE to PNG Image",[self loadImage:@"iphoneislam"], nil];
    
    UIActivityViewController *avc = [[UIActivityViewController alloc]
                                     initWithActivityItems: activityItems applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];

    
}
@end
