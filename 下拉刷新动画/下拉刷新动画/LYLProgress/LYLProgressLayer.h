//
//  LYLProgressLayer.h
//  LSProgressHUDExample
//
//  Created by Rainy on 2017/1/20.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface LYLProgressLayer : CALayer
@property(nonatomic,strong)CAShapeLayer *progressLayer;

-(instancetype)initGraintCircleWithBounds:(CGRect)bounds
                                 Position:(CGPoint)position
                                FromColor:(UIColor *)fromColor
                                  ToColor:(UIColor *)toColor
                                LineWidth:(CGFloat) linewidth;
+(instancetype)layerWithWithBounds:(CGRect)bounds
                          Position:(CGPoint)position
                         FromColor:(UIColor *)fromColor
                           ToColor:(UIColor *)toColor
                         LineWidth:(CGFloat) linewidth;
@end
