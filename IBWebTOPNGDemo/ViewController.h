//
//  ViewController.h
//  IBWebTOPNGDemo
//
//  Created by Ibrahim Qraiqe on 15.01.13.
//  Copyright (c) 2013 Ibrahim Qraiqe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
- (IBAction)shareBtnDidTapped:(id)sender;

@end
