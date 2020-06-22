//
//  RoFPlatformViewFactory.m
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

        

#import "RoFPlatformViewFactory.h"
#import "RoFWKWebView.h"

@implementation RoFPlatformViewFactory

- (NSObject <FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args
{
    RoFWKWebView *wkWebView = [[RoFWKWebView alloc] initWithFrame:frame viewId:viewId args:args];
    return wkWebView;
}

@end
