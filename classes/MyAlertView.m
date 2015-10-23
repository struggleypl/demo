//
//  MyAlertView.m
//  demo
//
//  Created by ypL on 15/9/1.
//  Copyright (c) 2015年 hohistar. All rights reserved.
//

#import "MyAlertView.h"

#define kBaseTag 1000
#define kContentViewWidth 260.0f
#define kButtonHeight 45.0f
#define kMarginLeftRight 9.0f
#define kMarginTopButtom 22.0f

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MyAlertView ()
{
    UIView *contentView;
    UIButton *cancelBtn;
    UIImage *titleImage;
    UITextView *titleLabel;
}

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,retain) NSMutableArray *buttonTitleList;
@property (nonatomic,copy) void (^dialogViewCompleteHandle)(NSInteger);
@end

@implementation MyAlertView

-(id)initWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        }];
        
        self.userInteractionEnabled = YES;
        self.title = title;
        
        self.message = message;
        
        va_list args;
        va_start(args, otherButtonTitles);
        _buttonTitleList = [[NSMutableArray alloc] initWithCapacity:10];
        for (NSString *str = otherButtonTitles; str != nil; str = va_arg(args,NSString*))
        {
            [_buttonTitleList addObject:str];
        }
        va_end(args);
        
        [self setup];
    }
    
    return self;
}

/**
 *  view初始化
 */
-(void)setup
{
    if (contentView != nil) {
        [contentView removeFromSuperview];
    }
    //内容视图
    contentView = [[UIView alloc]initWithFrame:CGRectMake(40, (568-160)/2, 320-80, 160)];
    contentView.clipsToBounds = YES;
    contentView.backgroundColor = [UIColor whiteColor];
    [contentView.layer setCornerRadius:5.0f];
    [self addSubview:contentView];
    
    //标题
    titleLabel = [[UITextView alloc]initWithFrame:CGRectMake(8, 8, CGRectGetWidth(contentView.frame)-16, 80)];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"标题";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = UIColorFromRGB(0x333333);
    [contentView addSubview:titleLabel];
    
    //横线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(contentView.frame)-36, CGRectGetWidth(contentView.frame), 1)];
    line1.backgroundColor = UIColorFromRGB(0xdadbdd);
    [contentView addSubview:line1];
    
    for (int i = 0; i < _buttonTitleList.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(5+i*(CGRectGetWidth(contentView.frame)-10)/2, CGRectGetHeight(contentView.frame)-35, (CGRectGetWidth(contentView.frame)-10)/2, 35);
        btn.translatesAutoresizingMaskIntoConstraints = NO;
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [btn setTitle:[_buttonTitleList objectAtIndex:i] forState:UIControlStateNormal];
        [btn.layer setMasksToBounds:YES];
        if(i > 0 && i == _buttonTitleList.count - 1)
            [btn setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateNormal];
        else
            [btn setTitleColor:UIColorFromRGB(0xb51d23) forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:kBaseTag + i];
        [contentView addSubview:btn];
        
        //分割线
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(5+(CGRectGetWidth(contentView.frame)-10)/2, CGRectGetHeight(contentView.frame)-35, 1, 35)];
        lineView1.backgroundColor = UIColorFromRGB(0xdadbdd);
        [contentView addSubview:lineView1];
        
    }
    
}

-(void)setMessageFont:(UIFont *)messageFont
{
    if(_messageFont != messageFont)
    {
        _messageFont = messageFont;
        
        _msgLabel.font = _messageFont;
    }
}

/**
 *  点击按钮事件
 *
 *  @param sender OK按钮
 */
-(void)buttonAction:(UIButton *)sender
{
    NSInteger selIndex = sender.tag - kBaseTag;
    if(_dialogViewCompleteHandle)
    {
        _dialogViewCompleteHandle(selIndex);
    }
    [self closeView];
}

-(void)showInView:(UIView *)baseView completion:(void (^)(NSInteger))completeBlock
{
    self.dialogViewCompleteHandle = completeBlock;
    
    if(!_seriesAlert)
    {
        for (UIView *subView in baseView.subviews) {
            if([subView isKindOfClass:[MyAlertView class]])
            {
                return;
            }
        }
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [baseView addSubview:self];
    
    
//    contentView.alpha = 0;
//    contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
//    [UIView animateWithDuration:0.3f animations:^{
//        contentView.alpha = 1.0;
//        contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
//    }];
    
    contentView.transform = CGAffineTransformIdentity;
    
    [UIView animateKeyframesWithDuration:0.6 delay:0 options:0 animations: ^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{
            
            contentView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            
        }];
        
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations: ^{
            
            contentView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            
        }];
        
        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations: ^{
            
            contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
        }];
        
    } completion:nil];
}

/**
 *  显示弹出框
 */
-(void)showWithCompletion:(void (^)(NSInteger))completeBlock
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self showInView:keyWindow completion:completeBlock];
}

/**
 *  关闭视图
 */
-(void)closeView
{
    [UIView animateWithDuration:0.3f animations:^{
        contentView.alpha = 0;
        contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
