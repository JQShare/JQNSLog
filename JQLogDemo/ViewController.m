//
//  ViewController.m
//  JQLogDemo
//
//  Created by zhongkang on 2020/3/23.
//  Copyright © 2020 zhongkang. All rights reserved.
//

#import "ViewController.h"

#import "JQNSLogView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"测试打印日志");
    // Do any additional setup after loading the view.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    JQNSLogView * jqToView = [[JQNSLogView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100, 60, 30)];
    [self.view addSubview:jqToView];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [jqToView addGestureRecognizer:panGesture];
    
    
}



//查看日志按钮移动
- (void)panAction:(UIPanGestureRecognizer *)recognizer {
    JQNSLogView * logView = (JQNSLogView *)recognizer.view;
    if (logView.isMove == NO) {
        return;
    }
    
    CGPoint translationPoint = [recognizer translationInView:self.view];
    CGPoint center = recognizer.view.center;
    CGFloat centerX = center.x + translationPoint.x;
    CGFloat centerY = center.y + translationPoint.y;
    if (center.x + translationPoint.x < 50) {
        centerX = 50;
    }else if (center.x + translationPoint.x > (SCREEN_WIDTH - 50)) {
        centerX = SCREEN_WIDTH - 50;
    }
    
    if (center.y + translationPoint.y  < (40 )) {
        centerY = 40 ;
    }else if (center.y + translationPoint.y > (SCREEN_HEIGHT  - 40)){
        centerY = SCREEN_HEIGHT - 40;
    }
    recognizer.view.center = CGPointMake(centerX, centerY);

    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled
) {
        if (centerX > SCREEN_WIDTH/2) {
            [UIView animateWithDuration:0.2 animations:^{
                recognizer.view.center = CGPointMake(SCREEN_WIDTH - 30, centerY);
                [recognizer setTranslation:CGPointZero inView:self.view];
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                recognizer.view.center = CGPointMake(
                                                     30, centerY);
                [recognizer setTranslation:CGPointZero inView:self.view];
            }];
        }
    }
}

@end
