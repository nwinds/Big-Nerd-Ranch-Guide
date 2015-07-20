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

@property (nonatomic, weak) BNRLine *selectedLine;

//#pragma mark -

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
        
        // Double tap gesture
        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        // Set gesture as double tap
        doubleTapRecognizer.numberOfTapsRequired = 2;
        // To remove red point response while touching
        // By avoiding sending signal to UIView before recognizing the gesture
        doubleTapRecognizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:doubleTapRecognizer];
        
        // Multiple gesture recognizer
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tapRecognizer.delaysTouchesBegan = YES;
        // To destinguish tap and double tap
        [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self addGestureRecognizer:tapRecognizer];
        
        // Long press recognizer: begin =>(judge) => remain => end
        // Initially consider long press as > 0.5 secs
        UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc]
                                                         initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:pressRecognizer];
    }
    
    return self;
}


// Q: Is it nessesary setting color and type EVERY TIME?
// In OpenGL we needn't (stack)
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
    
    // Draw selected lines in green
    if (self.selectedLine) {
        [[UIColor greenColor] set];
        [self strokeLine:self.selectedLine];
    }

}

- (void)deleteLine:(id)sender
{
    [self.finishedLines removeObject:self.selectedLine];
    [self setNeedsDisplay];
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

// Cancel if app break
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Debug info
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // Support multiple touch
    for (UITouch *tch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:tch];
        [self.linesInProgress removeObjectForKey:key];
    }
    
    [self setNeedsDisplay];
}

#pragma mark -Line locating

- (BNRLine *)lineAtPoint:(CGPoint)p
{
    // Find out BNRLine most close to point p
    for (BNRLine *l in self.finishedLines) {
        CGPoint start = l.begin;
        CGPoint end = l.end;
        
        // Check out points
        for (float t = 0.0; t <= 1.0; t += 0.05) {
            float x = start.x + t * (end.x - start.x);
            float y = start.y + t * (end.y - start.y);
            
            // If distance within 20, return BNRLine object
            if (hypot(x - p.x, y - p.y) < 20.0) {
                return l;
            }
            
        }
    }
    
    return nil;
}

#pragma mark -Gesture handle

- (void)doubleTap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized Double Tap");
    
    [self.linesInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
    [self setNeedsDisplay];
}

// First, locate gesture in view; second, set selectedLine with the BNRLine
- (void)tap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognized tap");
    
    CGPoint point = [gr locationInView:self];
    self.selectedLine = [self lineAtPoint:point];
    
    if (self.selectedLine) {
        // Set UIView as UIMenuItem's message target
        [self becomeFirstResponder];
        
        // Fetch UIMenuController object
        UIMenuController *menu = [UIMenuController sharedMenuController];
        
        // Create new UIMenueItem object
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems = @[deleteItem];
        
        // Set show area and set it as visible
        [menu setTargetRect:CGRectMake(point.x, point.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];
    } else {
        // If no line selected, then hide UIMenuController object
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
    
    
    [self setNeedsDisplay];
}


- (void)longPress:(UIGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan) {
            NSLog(@"Recognized long press: begin");
        CGPoint point = [gr locationInView:self];
        self.selectedLine = [self lineAtPoint:point];
        
        if (self.selectedLine) {
            [self.linesInProgress removeAllObjects];
        }
    } else if (gr.state == UIGestureRecognizerStateEnded) {
        NSLog(@"Recognized long press: end");
        self.selectedLine = nil;
    }
    
    [self setNeedsDisplay];
}

#pragma mark -Set first resonder
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
