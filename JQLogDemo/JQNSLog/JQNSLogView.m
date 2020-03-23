//
//  JQNSLogView.m
//  testDemo
//
//  Created by zhongkang on 2020/3/21.
//  Copyright © 2020 zhongkang. All rights reserved.
//

#import "JQNSLogView.h"


@interface JQNSLogView ()

//日志显示View
@property(weak,nonatomic) UITextView * textView;
//日志View
@property(weak,nonatomic) UIView * logView;

@end


@implementation JQNSLogView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.isMove = YES;
        UIButton * toViewBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        [self addSubview:toViewBtn];

        [toViewBtn setBackgroundColor:[UIColor redColor]];
         toViewBtn.alpha = 0.5;
        [toViewBtn setTitle:@"查看日志" forState:UIControlStateNormal];
        [toViewBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [toViewBtn addTarget:self action:@selector(setUpdateWorkLog) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
    
}




////设置打印日志
-(void)setUpdateWorkLog{
    self.isMove = NO;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIView * logView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.logView = logView;
    [self addSubview:logView];
    UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 150)];
    [textView setEditable:NO];
    [logView addSubview:textView];
    self.textView = textView;
    [self readWorkLog];

    //刷新日志
    UIButton * refreshBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 120, 80, 30)];
    [logView addSubview:refreshBtn];
    [refreshBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [refreshBtn setTitle:@"刷新日志" forState:UIControlStateNormal];
    [refreshBtn setBackgroundColor:[UIColor blueColor]];
    [refreshBtn addTarget:self action:@selector(readWorkLog) forControlEvents:UIControlEventTouchUpInside];

    
    //清空打印日志
    UIButton * cleanBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, SCREEN_HEIGHT - 120, 80, 30)];
      [logView addSubview:cleanBtn];
      [cleanBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
      [cleanBtn setTitle:@"清空日志" forState:UIControlStateNormal];
    [cleanBtn setBackgroundColor:[UIColor colorWithRed:0 green:100 blue:0 alpha:1.0]];
    [cleanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [cleanBtn addTarget:self action:@selector(cleanNSLog) forControlEvents:UIControlEventTouchUpInside];
    
    
    //关闭日志
    UIButton * closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(200, SCREEN_HEIGHT - 120, 80, 30)];
      [logView addSubview:closeBtn];
      [closeBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
      [closeBtn setTitle:@"关闭日志" forState:UIControlStateNormal];
      [closeBtn setBackgroundColor:[UIColor redColor]];
      [closeBtn addTarget:self action:@selector(closeLogShow) forControlEvents:UIControlEventTouchUpInside];

}

//关闭日志显示
-(void)closeLogShow{
    self.frame = CGRectMake(0, SCREEN_HEIGHT - 100, 60, 30);
    self.isMove = YES;
    [self.logView removeFromSuperview];
    self.logView = nil;

}

//读取日志
-(void)readWorkLog{
    NSLog(@"刷新打印日志");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
          NSString *documentDirectory = [paths objectAtIndex:0];
          NSDateFormatter *format=[[NSDateFormatter alloc] init];
          [format setDateFormat:@"yyyy-MM-dd"];
          NSString *fileName = [NSString stringWithFormat:@"%@.log",[format stringFromDate:[NSDate date]]]; // 注意不是NSData!
          NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
       NSString * str = [[NSString alloc]initWithContentsOfFile:logFilePath encoding:NSUTF8StringEncoding error:nil];
    self.textView.text = [NSString stringWithFormat:@"日志 %@",str];

}


/// 清空打印日志
-(void)cleanNSLog{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
      NSString *documentDirectory = [paths objectAtIndex:0];
      
      NSDateFormatter *format=[[NSDateFormatter alloc] init];
      [format setDateFormat:@"yyyy-MM-dd"];
      NSString *fileName = [NSString stringWithFormat:@"%@.log",[format stringFromDate:[NSDate date]]]; // 注意不是NSData!
      NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
      
      //删除之前的日志
      NSFileManager* fileManager = [NSFileManager defaultManager];
      [fileManager removeItemAtPath:logFilePath error:nil];
    
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
    
    NSLog(@"清空日志");
    [self readWorkLog];


}

@end
