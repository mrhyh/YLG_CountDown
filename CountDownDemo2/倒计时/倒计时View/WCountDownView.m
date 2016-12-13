//
//  CountDownView.m
//  倒计时
//
//  Created by ylgwhyh on 16/12/9.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "WCountDownView.h"
#import "Masonry.h"
#import "UIView+ArrangeSubview.h"
#import "CountDown.h"

@interface WCountDownView ()

@property (strong, nonatomic)  UILabel *dayLabel;
@property (strong, nonatomic)  UILabel *hourLabel;
@property (strong, nonatomic)  UILabel *minuteLabel;
@property (strong, nonatomic)  UILabel *secondLabel;
@property (strong, nonatomic)  UIView  *contentView;

@property (strong, nonatomic)  CountDown *countDownForBtn;
@property (strong, nonatomic)  CountDown *countDownForLabel;

@property (strong, nonatomic)  UIColor *borderColor;

@end

@implementation WCountDownView {
    CGFloat label_width;
    CGFloat label_Height;
}


+ (instancetype)initCountDownViewWithRect:(CGRect)rect {
    WCountDownView *view = [[WCountDownView alloc] initWithFrame:rect];
    return view;
}

- (instancetype)initWithFrame: (CGRect)frame
{
    if (self = [super initWithFrame: frame]) {
        
        label_width = 30;
        label_Height = 20;
        
        _borderColor = [UIColor grayColor];
        
        self.contentView = [UIView new];
        [self addSubview:self.contentView];
        
        self.dayLabel = [self createDayLabel];
        [self.contentView addSubview:self.dayLabel];
        
        
        self.hourLabel = [self createDayLabel];
        [self.contentView addSubview:self.hourLabel];
        
        
        self.minuteLabel = [self createDayLabel];
        [self.contentView addSubview:self.minuteLabel];
        
        
        self.secondLabel = [self createDayLabel];
        [self.contentView addSubview:self.secondLabel];
        
        _countDownForLabel = [[CountDown alloc] init];
        _countDownForBtn = [[CountDown alloc] init];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews]; // 注意，一定不要忘记调用父类的layoutSubviews方法！
    
    //    self.button.frame = ... // 设置button的frame
    //    self.label.frame = ...  // 设置label的frame
    [self initUI];
    
    ///方法一倒计时测试
    long long startLongLong = 1467713971000;
    long long finishLongLong = 1467714322000;
    [self startLongLongStartStamp:startLongLong longlongFinishStamp:finishLongLong];
    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* startDate = [formater dateFromString:@"2015-12-31 19:23:20"];
    NSDate* finishDate = [formater dateFromString:@"2015-12-31 19:24:20"];
    //    [self startWithStartDate:startDate finishDate:finishDate];
}

///布局UI
-(void)initUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(4*label_width, label_Height));
        make.center.equalTo(self);
    }];
    
    
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@[self.hourLabel,self.minuteLabel,self.secondLabel]);
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(label_width);
        make.height.equalTo(self.contentView);
    }];
    
    
    //冒号
    UILabel *colonLabel1 = [self createColonLabel];
    UILabel *colonLabel2 = [self createColonLabel];
    UILabel *colonLabel3 = [self createColonLabel];
    
    [self.contentView addSubview:colonLabel1];
    [self.contentView addSubview:colonLabel2];
    [self.contentView addSubview:colonLabel3];
    
    [colonLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dayLabel);
    }];
    
    [colonLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@[colonLabel2,colonLabel3]);
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(10);
        make.height.equalTo(self.contentView);
    }];
    
    [colonLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(colonLabel1);
    }];
    
    [colonLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(colonLabel1);
    }];
    
    [self.hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.dayLabel);
    }];
    [self.minuteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.dayLabel);
    }];
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.dayLabel);
    }];
    
    [colonLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(colonLabel1);
    }];
    
    [colonLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(colonLabel1);
    }];
    
    [self.contentView arrangeSubviewWithSpacingHorizontally:@[self.dayLabel,colonLabel1,self.hourLabel,colonLabel2,self.minuteLabel,colonLabel3,self.secondLabel]];
}

//创建冒号Label
- (UILabel *)createColonLabel {
    UILabel *colonLabel = [UILabel new];
    colonLabel.text = @":";
    colonLabel.backgroundColor = [UIColor whiteColor];
    colonLabel.textColor = [UIColor grayColor];
    colonLabel.textAlignment = NSTextAlignmentCenter;
    return colonLabel;
}

//创建时分秒Label
- (UILabel *)createDayLabel {
    UILabel *dayLabel = [UILabel new];
    dayLabel.textAlignment = NSTextAlignmentCenter;
    dayLabel.backgroundColor = [UIColor whiteColor];
    dayLabel.textColor = [UIColor grayColor];
    dayLabel.font = [UIFont systemFontOfSize:15];
    dayLabel.adjustsFontSizeToFitWidth = YES;
    dayLabel.layer.borderColor = _borderColor.CGColor;
    dayLabel.layer.borderWidth = 1.0;
    dayLabel.layer.cornerRadius = 1.0;
    return dayLabel;
}

-(void)refreshUIDay:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second{
    if (day==0) {
        self.dayLabel.text = @"0"; //天
    }else{
        self.dayLabel.text = [NSString stringWithFormat:@"%ld",(long)day];
    }
    if (hour<10&&hour) {
        self.hourLabel.text = [NSString stringWithFormat:@"0%ld",(long)hour];
    }else{
        self.hourLabel.text = [NSString stringWithFormat:@"%ld",(long)hour];
    }
    if (minute<10) {
        self.minuteLabel.text = [NSString stringWithFormat:@"0%ld",(long)minute];
    }else{
        self.minuteLabel.text = [NSString stringWithFormat:@"%ld",(long)minute];
    }
    if (second<10) {
        self.secondLabel.text = [NSString stringWithFormat:@"0%ld",(long)second];
    }else{
        self.secondLabel.text = [NSString stringWithFormat:@"%ld",(long)second];
    }
}

///此方法用两个时间戳做参数进行倒计时
-(void)startLongLongStartStamp:(long long)strtLL longlongFinishStamp:(long long)finishLL{
    __weak __typeof(self) weakSelf= self;
    [_countDownForLabel countDownWithStratTimeStamp:strtLL finishTimeStamp:finishLL completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        NSLog(@"666");
        [weakSelf refreshUIDay:day hour:hour minute:minute second:second];
    }];
}

-(void)dealloc{
    [_countDownForLabel destoryTimer];
    [_countDownForBtn destoryTimer];
    NSLog(@"%s dealloc",object_getClassName(self));
}

@end
