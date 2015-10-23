//
//  ViewController.m
//  demo
//
//  Created by ypL on 15/9/1.
//  Copyright (c) 2015年 hohistar. All rights reserved.
//

#import "ViewController.h"
#import "MyAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setFrame:CGRectMake(100, 100, 100, 50)];
    [btn setTitle:@"show" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)showAlert:(id)sender
{
    MyAlertView *dialog = [[MyAlertView alloc]initWithTitle:@"" message:@"" buttonTitles:@"取消",@"确定", nil];
    dialog.frame = CGRectMake(0, 0, 320, 568);
    [dialog showWithCompletion:^(NSInteger selectIndex) {
        NSLog(@"action selected %ld",selectIndex);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
