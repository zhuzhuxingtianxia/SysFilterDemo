//
//  StackFilterController.h
//  FilterDemo
//
//  Created by Jion on 2017/4/6.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, StackFilterType) {
    StackFilterType1,
    StackFilterType2,
    StackFilterType3,
};

typedef NS_OPTIONS(NSUInteger, SuperFilterType) {
    SuperFilterType1 = 1 << 0,
    SuperFilterType2 = 1 << 1,
    SuperFilterType3 = 1 << 2,
};
@interface StackFilterController : UIViewController
//是否使用实时图像处理
@property(nonatomic,assign)BOOL isEAGL;

@end
