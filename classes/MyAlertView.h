//
//  MyAlertView.h
//  demo
//
//  Created by ypL on 15/9/1.
//  Copyright (c) 2015年 hohistar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAlertView : UIView

@property (nonatomic,retain) UILabel *msgLabel;
@property (nonatomic,retain) UIFont *messageFont;

@property (nonatomic,assign) BOOL   seriesAlert;

/**
 *  @两个按钮纯文本显示（block回调方式）
 */
-(id)initWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSString *)otherButtonTitles,... NS_REQUIRES_NIL_TERMINATION;

/**
 *  显示弹出框
 */
-(void)showWithCompletion:(void (^)(NSInteger selectIndex))completeBlock;

-(void)showInView:(UIView *)baseView completion:(void (^)(NSInteger selectIndex))completeBlock;

@end
