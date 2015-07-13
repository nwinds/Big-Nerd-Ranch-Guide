//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by John Gallagher on 1/6/14.
//  Copyright (c) 2014 John Gallagher. All rights reserved.
//

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // All BNRHypnosisViews start with a clear background color
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;

    
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center
                        radius:currentRadius
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    path.lineWidth = 10;
    // Set color
    [[UIColor colorWithRed:0.10 green:0.0 blue:1.0 alpha:0.50] setStroke];
    [path stroke];
    
    // Core Graphic
//    CGContextRef currentContext = UIGraphicsGetCurrentContext();
//
//    CGContextSetRGBStrokeColor(currentContext, 1, 0, 0, 1);
//    CGMutablePathRef path = CGPathCreateMutable();
//    
//    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
//    CGPathMoveToPoint(path, NULL, a.x, a.y);
//    CGPathAddLineToPoint(path, NULL, b.x, b.y);
//    CGPathAddPath(currentContext, path);
    
//    CGContextStrokePath(currentContext);
//    CGPathRelease(path);
    
    CGRect logoFrame = CGRectMake(center.x/2, center.y/2, bounds.size.width/2, bounds.size.height/2);
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    [logoImage drawInRect:logoFrame];
}

@end
