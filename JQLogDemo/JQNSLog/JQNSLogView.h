//
//  JQNSLogView.h
//  testDemo
//
//  Created by zhongkang on 2020/3/21.
//  Copyright © 2020 zhongkang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

NS_ASSUME_NONNULL_BEGIN

@interface JQNSLogView : UIView

/// 允许移动
@property(assign,nonatomic) BOOL isMove;


@end

NS_ASSUME_NONNULL_END
