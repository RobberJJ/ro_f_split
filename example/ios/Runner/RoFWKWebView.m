//
//  RoFWKWebView.m
//  Runner
/**
 *      ┏┓     ┏┓
 *    ┏━┛┻━━━━━┛┻━┓
 *    ┃            ┃
 *    ┃     ━      ┃
 *    ┃  ┳┛   ┗┳  ┃
 *    ┃            ┃
 *    ┃     ┻      ┃
 *    ┃            ┃
 *    ┗━━┓     ┏━━┛Codes are far away from bugs with the animal protecting
 *       ┃　　　┃    神兽保佑,代码无bug
 *       ┃　　　┗━━━┓
 *       ┃         ┣━┓
 *       ┃         ┏━┛
 *       ┗┓┓┏━━┳┓┏━┛
 *        ┃┫┫  ┃┫┫
 *        ┗┻┛  ┗┻┛
 *
 *  Class Description:
        Input something to introduce this class.
 **/
 
//  Created by 陈杰 on 2020/6/19.
//  Copyright © 2020 . All rights reserved.

        
#import <WebKit/WebKit.h>
#import "RoFWKWebView.h"

@implementation RoFWKWebView {
    CGRect _frame;
    int64_t _viewId;
    id _args;
    UILabel *_subLabel;
    WKWebView * _webview;
    UIView * _myNativeView;
}

- (id)initWithFrame:(CGRect)frame viewId:(int64_t)viewId args:(id)args //channel:(FlutterMethodChannel *)channel
{
    if (self = [super init])
    {
        _frame = frame;
        _viewId = viewId;
        _args = args;
        
        _myNativeView = [[UIView alloc] initWithFrame:_frame];
        _myNativeView.backgroundColor = [UIColor purpleColor];

        _subLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 480, 44)];
        _subLabel.text = @"我是原生Label！！";
        _subLabel.textColor = [UIColor whiteColor];
        _subLabel.numberOfLines = 0;
        [_myNativeView addSubview:_subLabel];

        UIButton *subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [subBtn setFrame:CGRectMake(20, 120, 200, 200)];
        [subBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [subBtn setTitle:@"点我试试！" forState:UIControlStateNormal];
        subBtn.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
        [subBtn addTarget:self action:@selector(subBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_myNativeView addSubview:subBtn];
        _webview = [[WKWebView alloc] initWithFrame:_frame];
//        [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
        [_webview loadRequest:[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://www.baidu.com"] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:5]];
//        [channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
//
//            if ([call.method isEqualToString:@"loadUrl"]) {
//                NSString * url = call.arguments;
//                [self->_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
//            }
//        }];
    }
    return self;
}

- (UIView *)view
{
    

//    return _myNativeView;
    NSLog(@"wenview %@",_webview);
    
    return _webview;
}

- (void)subBtnClicked:(id)sender
{
    NSLog(@"点击了 点我试试");
    _subLabel.text = [NSString stringWithFormat:@"%@如果你觉得这篇文章有用，请给我点个赞吧！！", _subLabel.text];
    NSLog(@"%@",_subLabel.text);
}

@end
