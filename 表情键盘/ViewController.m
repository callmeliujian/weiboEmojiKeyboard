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
    __weak typeof(self) weakSelf = self;
    if (_keyboardEmoticonVC == nil) {
        _keyboardEmoticonVC = [[LJKeyboardEmoticonViewController alloc] initWithEmoticonBlock:^void (LJKeyboardEmoticon *emoticon) {
            
            // 1.emoji表情图文混排
            if (emoticon.emojiStr) {
                // 取出光标所在位置
                UITextRange *range = weakSelf.customTextView.selectedTextRange;
                [weakSelf.customTextView replaceRange:range withText:emoticon.emojiStr];
            }
            
            // 2.新浪的图片的图文混排
            if (emoticon.pngPath) {
                // 创建原有文字属性字符串
                NSMutableAttributedString *attrMStr = [[NSMutableAttributedString alloc] initWithAttributedString:weakSelf.customTextView.attributedText];
                // 创建图片属性字符串
                LJKeyboardAttachment *attachment = [[LJKeyboardAttachment alloc] init];
                attachment.emoticonChs = emoticon.chs;
                attachment.bounds = CGRectMake(0, -4, weakSelf.customTextView.font.lineHeight, weakSelf.customTextView.font.lineHeight);
                attachment.image = [UIImage imageWithContentsOfFile:emoticon.pngPath];
                NSAttributedString *imageAttrStr = [NSAttributedString attributedStringWithAttachment:attachment];
                // 将光标所在位置的字符串进行替换
                NSRange range = weakSelf.customTextView.selectedRange;
                [attrMStr replaceCharactersInRange:range withAttributedString:imageAttrStr];
                // 显示
                weakSelf.customTextView.attributedText = attrMStr;
                // 重新设置光标位置
                weakSelf.customTextView.selectedRange = NSMakeRange(range.location + 1, 0);
                // 重新设置大小
                weakSelf.customTextView.font = [UIFont systemFontOfSize:14.0];
            }
            
            // 3.删除最近一个文字或者表情
            if (emoticon.isRemoveBtn) {
                [weakSelf.customTextView deleteBackward];
            }
            
        }];
    }
    return _keyboardEmoticonVC;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSRange range = NSMakeRange(0, self.customTextView.attributedText.length);
    NSMutableString *mutableStr = [[NSMutableString alloc] init];
    
    [self.customTextView.attributedText enumerateAttributesInRange:range options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        LJKeyboardAttachment *tempAttachment = attrs[@"NSAttachment"];
        if (tempAttachment) {
            [mutableStr appendString:tempAttachment.emoticonChs];
        } else {
            [mutableStr appendString:[self.customTextView.text substringWithRange:range]];
        }
    }];
    
    NSLog(@"%@",mutableStr);
    
}

@end
