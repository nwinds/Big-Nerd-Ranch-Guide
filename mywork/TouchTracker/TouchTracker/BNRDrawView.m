//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by jyl on 15/7/17.
//  Copyright (c) 2015年 zmy. All rights reserved.
//

#import "BNRDrawView.h"
#import "BNRLine.h"
@interface BNRDrawView ()

#pragma mark -Lines
//@property (nonatomic, strong) BNRLine *currentLine;
@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;


@end

@implementation BNRDrawView

#pragma mark -Drawing

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        
        // Enable multiple touch
        self.multipleTouchEnabled = YES;
    }
    
    return self;
}

// Q: Is it nessesary setting color and type EVERY TIME?
// In OpenGL we needn't(stack)
- (void)strokeLine:(BNRLine *)line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] set];
    for (BNRLine *line in self.finishedLines) {
        [self strokeLine:line];
    }
    
    [[UIColor redColor] set];
    for (NSValue *key in self.linesInProgress) {
        [self strokeLine:self.linesInProgress[key]];
    }

}

#pragma mark -Turing touches into lines

// Create BNRLine object
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Debug info
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // Support multiple touch
    for (UITouch *tch in touches) {
        CGPoint location = [tch locationInView:self];
        
        BNRLine *line = [[BNRLine alloc] init];
        line.begin = location;
        line.end = location;
        
        NSValue *key = [NSValue valueWithNonretainedObject:tch];
        self.linesInProgress[key] = line;
    }
    
    [self setNeedsDisplay];
}

// Fetch currentLine's end
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Debug info
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // Support multiple touch
    for (UITouch *tch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:tch];
        BNRLine *line = self.linesInProgress[key];
        
        line.end = [tch locationInView:self];
    }
    
    [self setNeedsDisplay];
}

// Add currentLine into finishedLines
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Debug info
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // Support multiple touch
    for (UITouch *tch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:tch];
        BNRLine *line = self.linesInProgress[key];
        
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }
    
    [self setNeedsDisplay];
}


@end
