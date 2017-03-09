//
//  ViewController.m
//  表情键盘
//
//  Created by 刘健 on 2017/3/7.
//  Copyright © 2017年 刘健. All rights reserved.
//

#import "ViewController.h"
#import "LJKeyboardEmoticonViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *customTextView;

@property (nonatomic, strong) LJKeyboardEmoticonViewController *keyboardEmoticonVC;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.keyboardEmoticonVC];
    
    self.customTextView.inputView = self.keyboardEmoticonVC.view;
    
}

- (LJKeyboardEmoticonViewController *)keyboardEmoticonVC {
    if (_keyboardEmoticonVC == nil) {
        _keyboardEmoticonVC = [[LJKeyboardEmoticonViewController alloc] init];
    }
    return _keyboardEmoticonVC;
}

@end
