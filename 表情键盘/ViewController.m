//
//  ViewController.m
//  表情键盘
//
//  Created by 刘健 on 2017/3/7.
//  Copyright © 2017年 刘健. All rights reserved.
//

#import "ViewController.h"
#import "LJKeyboardEmoticonViewController.h"
#import "LJKeyboardAttachment.h"
#import "LJKeyboardTextView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet LJKeyboardTextView *customTextView;

@property (nonatomic, strong) LJKeyboardEmoticonViewController *keyboardEmoticonVC;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.keyboardEmoticonVC];
    
    self.customTextView.inputView = self.keyboardEmoticonVC.view;
    
}

- (LJKeyboardEmoticonViewController *)keyboardEmoticonVC {
    __weak typeof(self) weakSelf = self;
    if (_keyboardEmoticonVC == nil) {
        _keyboardEmoticonVC = [[LJKeyboardEmoticonViewController alloc] initWithEmoticonBlock:^void (LJKeyboardEmoticon *emoticon) {

            [weakSelf.customTextView insertEmoticon:emoticon];
            
        }];
    }
    return _keyboardEmoticonVC;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSRange range = NSMakeRange(0, self.customTextView.attributedText.length);
//    NSMutableString *mutableStr = [[NSMutableString alloc] init];
//    
//    [self.customTextView.attributedText enumerateAttributesInRange:range options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
//        LJKeyboardAttachment *tempAttachment = attrs[@"NSAttachment"];
//        if (tempAttachment) {
//            [mutableStr appendString:tempAttachment.emoticonChs];
//        } else {
//            [mutableStr appendString:[self.customTextView.text substringWithRange:range]];
//        }
//    }];
//    
//    NSLog(@"%@",mutableStr);
//}

@end
