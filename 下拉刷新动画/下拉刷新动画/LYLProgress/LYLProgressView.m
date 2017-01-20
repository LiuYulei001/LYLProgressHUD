//
//  LYLProgressView.m
//  LSProgressHUDExample
//
//  Created by Rainy on 2017/1/20.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import "LYLProgressView.h"
#import "LYLProgressLayer.h"


@interface LYLProgressView ()

@property(nonatomic, strong) LYLProgressLayer *myLayer;
@property(nonatomic,strong)CABasicAnimation* rotationAnimation;

@property(nonatomic,strong)UIView *OnView;

@end

@implementation LYLProgressView
-(instancetype)initWithFrame:(CGRect)frame withType:(ProgressType)type OnView:(UIView *)view
{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupViewsWithType:type OnView:view];
    }
    
    return self;
}
- (void)setupViewsWithType:(ProgressType)type OnView:(UIView *)view {
    
    
    view.frame = self.bounds;
    view.layer.cornerRadius = self.frame.size.width/2;
    view.layer.masksToBounds = YES;
    [self addSubview:view];
    
    
    self.type = type;
    self.OnView = view;
}

- (void)setAnimation {
    
    [self.myLayer removeFromSuperlayer];
    UIColor *fromColor = self.type == 1 ? [UIColor colorWithWhite:1.000 alpha:0] : [UIColor colorWithRed:255 / 255.0 green:159 / 255.0 blue:23 / 255.0 alpha:1.000];
    
    self.myLayer = [[LYLProgressLayer alloc]
                        initGraintCircleWithBounds:CGRectMake(0, 0, self.bounds.size.width + 3.5, self.bounds.size.height + 3.5)
                        Position:CGPointMake(0, 0) FromColor:fromColor ToColor:[UIColor colorWithRed:255 / 255.0 green:159 / 255.0 blue:23 / 255.0 alpha:1.000]
                        LineWidth:3.0];
    
    
    [self.OnView.layer addSublayer:self.myLayer];
    
    self.myLayer.progressLayer.strokeStart = self.type == 1 ? 0.015 : 0;
    self.myLayer.progressLayer.strokeEnd = self.type == 1 ? 0.985 : 0;
    self.myLayer.position = self.OnView.center;
    if (self.type == 1) {
        
        [self.myLayer removeAllAnimations];
        if (!self.rotationAnimation) {
            
            self.rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            self.rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI /6 ];
            self.rotationAnimation.duration = 0.08;
            self.rotationAnimation.cumulative = YES;
            self.rotationAnimation.repeatCount = CGFLOAT_MAX;
        }
        
        [self.myLayer addAnimation:self.rotationAnimation forKey:@"ss"];
    }
}
-(void)updateProgress:(CGFloat)progress
{
    if (self.type != 1) {
        [CATransaction begin];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [CATransaction setAnimationDuration:0.01];
        self.myLayer.progressLayer.strokeEnd = progress;
        [CATransaction commit];
        self.alpha = progress;
        self.currentProgress = progress;
    }
}
-(void)show
{
    return  [self setAnimation];
}
-(void)onlyHideProgress
{
    [self.myLayer removeFromSuperlayer];
}
-(void)hide
{
    [UIView animateWithDuration:0.1 animations:^{
        
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
    }];
}
-(void)setType:(ProgressType)type
{
    _type = type;
    [self show];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
