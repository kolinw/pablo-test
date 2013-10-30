//
//  TimeLineView.m
//  TimeLine
//
//  Created by WEIDMANN Kolin on 30/10/2013.
//  Copyright (c) 2013 WEIDMANN Kolin. All rights reserved.
//

#import "TimeLineView.h"
#import "TimeLineButton.h"

@implementation TimeLineView

@synthesize width;
@synthesize height;
@synthesize dots;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    
    return self;
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        TimeLineButton *step1 = [[TimeLineButton alloc] initWithFrame:CGRectMake(0,0,100,100)];
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [button setTitle:@"Show View" forState:UIControlStateNormal];
//        button.frame = CGRectMake(0, 0, 160.0, 40.0);
        //[self addSubview:step1];
        
        dots = [[NSMutableArray alloc] init];
    }
    
    
    
    
    return self;
    
}

-(void) drawRect: (CGRect) rect
{
    self.width = self.bounds.size.width;
    self.height = self.bounds.size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *greyColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    
    // draw line
    CGPoint startPoint = CGPointMake(self.width/2, 0);
    CGPoint endPoint = CGPointMake(self.width/2, self.height);
    draw1PxStroke(context, startPoint, endPoint, greyColor.CGColor);
    
    // draw step
    [self drawSteps];
    
    //[self animateHoverStepWithId:0];
    
}

-(void) animateHoverStepWithId:(int) stepNb
{
    // COLOR ANIM
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    animation.duration = 1.0;
    animation.toValue = (__bridge id)[UIColor colorWithHue:0 saturation:.1 brightness:.1 alpha:.1].CGColor;
    
    [animation setFillMode:kCAFillModeForwards];
    [animation setRemovedOnCompletion:NO];
    //[[self.layer.sublayers objectAtIndex:stepNb] addAnimation:animation forKey:animation.keyPath];
    
    // SCALE ANIM
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.toValue = [NSNumber numberWithFloat:3.0];
    animation2.duration = 0.20f;
    
    [animation2 setFillMode:kCAFillModeForwards];
    [animation2 setRemovedOnCompletion:NO];
    [[self.layer.sublayers objectAtIndex:stepNb] addAnimation:animation2 forKey:animation2.keyPath];
    
    // TRANSLATE CONTRE SCALE
//    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"position"];
//    animation3.duration = 0.2f;
//    
//    animation3.toValue = [NSValue valueWithCGPoint:CGPointMake((self.frame.size.width/2), (self.frame.size.height/2))];
//    
//    [[self.layer.sublayers objectAtIndex:stepNb] addAnimation:animation3 forKey:animation3.keyPath];
}

-(void) animateActiveStepWithId:(int) stepNb
{
    // COLOR ANIM
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    animation.duration = 1.0;
    animation.toValue = (__bridge id)[UIColor blackColor].CGColor;
    
    [animation setFillMode:kCAFillModeForwards];
    [animation setRemovedOnCompletion:NO];
    [[self.layer.sublayers objectAtIndex:stepNb] addAnimation:animation forKey:animation.keyPath];
    
    // SCALE ANIM
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.toValue = [NSNumber numberWithFloat:2.0];
    animation2.duration = 0.20f;
    
    [animation2 setFillMode:kCAFillModeForwards];
    [animation2 setRemovedOnCompletion:NO];
    [[self.layer.sublayers objectAtIndex:stepNb] addAnimation:animation2 forKey:animation2.keyPath];

}

-(void) drawSteps
{
    for(int i = 1; i <= 2; i = i + 1)
    {
        
        // Set up the shape of the circle
        int radius = 5;
        CAShapeLayer *circle = [CAShapeLayer layer];
        
        [dots addObject:circle];
        
        // Make a circular shape
        circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                                 cornerRadius:radius].CGPath;
        // Center the shape
        circle.position = CGPointMake(self.width/2-radius+0.5, 50*i);
        NSLog(@"%d", 50*i);
        
        circle.anchorPoint = CGPointMake(0, 0);
        
        // Configure the apperence of the circle
        circle.fillColor = [UIColor whiteColor].CGColor;
        circle.lineWidth = 0;
        
        // Add to parent layer
        [self.layer addSublayer:circle];
        
    }

}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CAShapeLayer *closest = [self findClosestDotFromTouch:touches];
    NSInteger idClosest = [dots indexOfObject:closest];
    
    [self animateHoverStepWithId:idClosest];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CAShapeLayer *closest = [self findClosestDotFromTouch:touches];
    NSInteger idClosest = [dots indexOfObject:closest];
    
    [self animateHoverStepWithId:idClosest];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CAShapeLayer *closest = [self findClosestDotFromTouch:touches];
    NSInteger idClosest = [dots indexOfObject:closest];
    
    [self animateActiveStepWithId:idClosest];
}

- (CAShapeLayer *) findClosestDotFromTouch:(NSSet *)touches
{
    NSArray *touchesArray = [touches allObjects];
    UITouch *touch = (UITouch *)[touchesArray objectAtIndex:0];
    CGPoint point = [touch locationInView:nil];
    
    NSInteger min = 1000;
    CAShapeLayer *closest;
    
    for (CAShapeLayer *dot in dots)
    {
        NSLog(@"%f", dot.position.y-point.y);
        NSInteger dist = abs(point.y-dot.position.y);
        if( dist < min){
            min = dist;
            closest = dot;
        }
    }
    
    return closest;

}

void draw1PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color)
{
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, startPoint.x + 0.5, startPoint.y + 0.5);
    CGContextAddLineToPoint(context, endPoint.x + 0.5, endPoint.y + 0.5);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

@end
