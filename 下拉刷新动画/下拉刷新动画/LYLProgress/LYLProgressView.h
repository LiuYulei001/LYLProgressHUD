//
//  LYLProgressView.h
//  LSProgressHUDExample
//
//  Created by Rainy on 2017/1/20.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ProgressType) {
    ProgressTypeForLoading = 1,
    ProgressTypeForProgress,
};

@interface LYLProgressView : UIView

@property(nonatomic,assign)CGFloat currentProgress;
@property(nonatomic,assign)ProgressType type;

-(instancetype)initWithFrame:(CGRect)frame withType:(ProgressType)type OnView:(UIView *)view;
-(void)updateProgress:(CGFloat)progress;
-(void)show;
-(void)hide;
@end
