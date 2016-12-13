//
//  CountDownViewController.m
//  倒计时
//
//  Created by Maker on 16/7/5.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "CountDownViewController.h"
#import "Masonry.h"
#import "UIView+ArrangeSubview.h"
#import "CountDown.h"
#import "WCountDownView.h"


@interface CountDownViewController ()

@property (strong, nonatomic)  UIView *contentView;
@property (strong, nonatomic)  UIButton *timeBtn;
@property (strong, nonatomic)  CountDown *countDownForBtn;

@property (strong, nonatomic)  CountDown *countDownForLabel;

@property (nonatomic, strong) WCountDownView *wcountDownView; //秒杀倒计时
@end

@implementation CountDownViewController

#pragma mark
#pragma mark viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _countDownForLabel = [[CountDown alloc] init];
    _countDownForBtn = [[CountDown alloc] init];
    
}

/**
 *  获取当天的年月日的字符串
 *  这里测试用
 *  @return 格式为年-月-日
 */
-(NSString *)getyyyymmdd{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd";
    NSString *dayStr = [formatDay stringFromDate:now];
    
    return dayStr;
    
}
///布局UI
-(void)initUI{
    CGFloat label_width = 40;
    CGFloat label_Height = 40;

    self.contentView = [UIView new];
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(4*label_width, label_Height));
        make.center.equalTo(self.view);
    }];

    self.timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.timeBtn.backgroundColor = [UIColor redColor];
    [self.timeBtn setTitle:@"点击获取验证码" forState:UIControlStateNormal];

    [self.timeBtn addTarget:self action:@selector(fetchCoder:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.timeBtn];
    
    [self.timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView.mas_top).offset(-40);
    }];
    
    
    UIButton *nextPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextPageBtn.backgroundColor = [UIColor redColor];
    [nextPageBtn setTitle:@"push到下一页" forState:UIControlStateNormal];
    
    [nextPageBtn addTarget:self action:@selector(nextPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextPageBtn];
    
    [nextPageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.timeBtn);
        make.left.mas_equalTo(self.timeBtn);
        make.bottom.mas_equalTo(self.timeBtn.mas_top).offset(-40);
    }];
    
    
    
    _wcountDownView = [[WCountDownView alloc] initWithFrame:CGRectMake(100, 30, 75, 20)];
    [self.view addSubview:_wcountDownView];
    
}
-(void)nextPage:(UIButton *)sender{
    UIViewController *aVC = [[UIViewController alloc]init];
    aVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:aVC animated:YES];
}
-(void)fetchCoder:(UIButton *)sender{
    //    60s的倒计时
    NSTimeInterval aMinutes = 60;
    
    //    1个小时的倒计时
    //    NSTimeInterval anHour = 60*60;
    
    //     1天的倒计时
    //    NSTimeInterval aDay = 24*60*60;
    [self startWithStartDate:[NSDate date] finishDate:[NSDate dateWithTimeIntervalSinceNow:aMinutes]];
}

//此方法用两个NSDate对象做参数进行倒计时
-(void)startWithStartDate:(NSDate *)strtDate finishDate:(NSDate *)finishDate{
    __weak __typeof(self) weakSelf= self;

    [_countDownForBtn countDownWithStratDate:strtDate finishDate:finishDate completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        NSLog(@"second = %li",second);
        NSInteger totoalSecond =day*24*60*60+hour*60*60 + minute*60+second;
        if (totoalSecond==0) {
            weakSelf.timeBtn.enabled = YES;
            [weakSelf.timeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        }else{
            weakSelf.timeBtn.enabled = NO;
            [weakSelf.timeBtn setTitle:[NSString stringWithFormat:@"%lis后重新获取",totoalSecond] forState:UIControlStateNormal];
        }
        
        }];
}


-(void)dealloc{
    [_countDownForLabel destoryTimer];
    [_countDownForBtn destoryTimer];
    NSLog(@"%s dealloc",object_getClassName(self));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
