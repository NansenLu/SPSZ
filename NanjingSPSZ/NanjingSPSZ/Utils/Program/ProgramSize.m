//
//  ProgramSize.m
//  NanjingSPSZ
//
//  Created by Nansen on 2018/5/19.
//  Copyright © 2018年 nansen. All rights reserved.
//

#import "ProgramSize.h"

@implementation ProgramSize

/**
 判断是否是 iPhone X
 */
+ (BOOL)isIPhoneX
{
    return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO;
}

+ (CGSize)mainScreenSize
{
    return [UIScreen mainScreen].bounds.size;
}

+ (CGFloat)mainScreenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)mainScreenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)statusBarHeight
{
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

+ (CGFloat)statusBarAndNavigationBarHeight
{
    return (44 + [[UIApplication sharedApplication] statusBarFrame].size.height);
}

/**
 底部高度,适配 iPhone X
 */
+ (CGFloat)bottomHeight
{
    return [self mainScreenHeight] == 812 ? 34 : 0;
}

/**
 根据屏幕宽度进行等比缩放的尺寸.
 */
+ (CGFloat)fitSize:(CGFloat)designSize
{
    CGFloat screenWidth = [self mainScreenWidth];
    CGFloat fitSize = (designSize * screenWidth / 375.0);
    return fitSize;
}



@end
