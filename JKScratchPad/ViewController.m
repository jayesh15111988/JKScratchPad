//
//  ViewController.m
//  JKScratchPad
//
//  Created by Jayesh Kawli Backup on 9/6/16.
//  Copyright © 2016 Jayesh Kawli Backup. All rights reserved.
//

#import "ViewController.h"
#define DEG2RAD(angle) ((angle*M_PI)/180.0)

@interface ViewController ()

@end

@implementation ViewController

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat maxRadius = 160;
    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, maxRadius * 2, maxRadius * 2)];
    v.layer.borderColor = [UIColor darkGrayColor].CGColor;
    v.layer.borderWidth = 2.0;
    v.center = CGPointMake(200, 400);
    [self.view addSubview:v];
    CGFloat center = maxRadius;
    
    CAShapeLayer* layer = [self createPieSliceWithRadius:100 startAngle:0 andEndAngle:60 andCenter:CGPointMake(center, center) andColor:UIColorFromRGB(0x2ecc71)];
    
    CAShapeLayer* layer1 = [self createPieSliceWithRadius:60 startAngle:60 andEndAngle:210 andCenter:CGPointMake(center, center) andColor:UIColorFromRGB(0x2980b9)];
    
    CAShapeLayer* layer2 = [self createPieSliceWithRadius:140 startAngle:210 andEndAngle:310 andCenter:CGPointMake(center, center) andColor:UIColorFromRGB(0xe74c3c)];
    
    CAShapeLayer* layer3 = [self createPieSliceWithRadius:160 startAngle:310 andEndAngle:330 andCenter:CGPointMake(center, center) andColor:UIColorFromRGB(0xf39c12)];
    
    CAShapeLayer* layer4 = [self createPieSliceWithRadius:120 startAngle:330 andEndAngle:360 andCenter:CGPointMake(center, center) andColor:UIColorFromRGB(0x2c3e50)];
    
    [v.layer addSublayer:layer];
    [v.layer addSublayer:layer1];
    [v.layer addSublayer:layer2];
    [v.layer addSublayer:layer3];
    [v.layer addSublayer:layer4];
    
    [layer2 addSublayer:[self labelForLayerWithCenter:CGPointMake(center, center) andRadius:140 andStartAngle:210 andEndAngle:310]];
}

- (CATextLayer*)labelForLayerWithCenter:(CGPoint)center andRadius:(CGFloat)radius andStartAngle:(CGFloat)startAngle andEndAngle:(CGFloat)endAngle {
    CATextLayer *label = [[CATextLayer alloc] init];
    label.fontSize = 12;
    label.backgroundColor = [UIColor blackColor].CGColor;
    NSLog(@"%f", cos(DEG2RAD(135)));
    CGFloat val = cos(DEG2RAD(135));
    CGFloat angles = startAngle + (endAngle - startAngle) /2.0;
    CGFloat anglec = cos(DEG2RAD(angles));
    CGFloat angless = sin(DEG2RAD(angles));
    label.frame = CGRectMake(center.x + ((radius/2.0) * anglec) - 10, center.y + ((radius/2.0) * angless) - 10, 20, 20);
    label.contentsScale = [UIScreen mainScreen].scale;
    [label setString:@"Hello"];
    [label setAlignmentMode:kCAAlignmentCenter];
    [label setForegroundColor:[[UIColor whiteColor] CGColor]];
    label.zPosition = 100;
    return label;
}

-(CAShapeLayer *)createPieSliceWithRadius:(CGFloat)radius startAngle:(CGFloat)startAngle andEndAngle:(CGFloat)endAngle andCenter:(CGPoint)center andColor:(UIColor*)color {
    CGPathRef fromPath = [self bezierPathWithCenter:center andRadius:0 andStartAngle:startAngle andEndAngle:endAngle];
    CGPathRef toPath = [self bezierPathWithCenter:center andRadius:radius andStartAngle:startAngle andEndAngle:endAngle];
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.duration = 1.0;
    anim.fromValue = (__bridge id)fromPath;
    anim.toValue = (__bridge id)toPath;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    CAShapeLayer *slice = [CAShapeLayer layer];
    slice.fillColor = color.CGColor;
    slice.strokeColor = [UIColor lightGrayColor].CGColor;
    slice.lineWidth = 1.0;
    slice.path = toPath;
    [slice addAnimation:anim forKey:nil];
    return slice;
}

- (CGPathRef)bezierPathWithCenter:(CGPoint)center andRadius:(CGFloat)radius andStartAngle:(CGFloat)startAngle andEndAngle:(CGFloat)endAngle {
    UIBezierPath *piePath = [UIBezierPath bezierPath];
    [piePath moveToPoint:center];
    
    [piePath addLineToPoint:CGPointMake(center.x + radius * cosf(DEG2RAD(startAngle)), center.y + radius * sinf(DEG2RAD(startAngle)))];
    
    [piePath addArcWithCenter:center radius:radius startAngle:DEG2RAD(startAngle) endAngle:DEG2RAD(endAngle) clockwise:YES];
    
    [piePath closePath];
    return piePath.CGPath;
}


@end
