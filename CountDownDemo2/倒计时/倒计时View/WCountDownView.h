//
//  CountDownView.h
//  倒计时
//
//  Created by ylgwhyh on 16/12/9.
//  Copyright © 2016年 郑文明. All rights reserved.
//  自定义倒计时View(纯代码版)

#import <UIKit/UIKit.h>

@interface WCountDownView : UIView

+ (instancetype)initCountDownViewWithRect:(CGRect)rect;
-(void)startLongLongStartStamp:(long long)strtLL longlongFinishStamp:(long long)finishLL;

@end
