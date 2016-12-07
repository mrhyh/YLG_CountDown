//
//  countDownView.h
//  倒计时
//
//  Created by ylgwhyh on 16/12/7.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownView : UIView

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *minuteLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;


/**
 *  快速创建一个footerView对象
 */
+ (instancetype)countDownView;

@end
