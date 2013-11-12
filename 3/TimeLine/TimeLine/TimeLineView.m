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
    
    [self animateHoverStepWithId:1];
    
}

-(void) animateHoverStepWithId:(int) stepNb
{
    // COLOR ANIM
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    animation.duration = 1.0;
    animation.toValue = (__bridge id)[UIColor whiteColor].CGColor;
    
    [animation setFillMode:kCAFillModeForwards];
    [animation setRemovedOnCompletion:NO];
    //[[self.layer.sublayers objectAtIndex:stepNb] addAnimation:animation forKey:animation.keyPath];
    
    // SCALE ANIM
//    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    animation2.toValue = [NSNumber numberWithFloat:3.0];
//    animation2.duration = 0.20f;
//    
//    [animation2 setFillMode:kCAFillModeForwards];
//    [animation2 setRemovedOnCompletion:NO];
//    [[self.layer.sublayers objectAtIndex:stepNb] addAnimation:animation2 forKey:animation2.keyPath];
    
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
    
}

-(void) drawSteps
{
    for(int i = 0; i <= 7; i = i + 1)
    {
        
        int radius = 5;
        TimeLineButton *step = [[TimeLineButton alloc] initWithFrame:CGRectMake(self.width/2-2*radius+0.5,VMARGIN+((self.height-VMARGIN)/NB_DOTS)*i,20,20)];

        [dots addObject:step];
        
        [self addSubview:step];
        
    }

}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    
    // activate current dot and do not persist state
    TimeLineButton *activeBtn = [self findActiveSubviewOnPoint:p];
    if(activeBtn){
        [self updateButtonsWithActive:activeBtn andDragging:YES];
        self.activeDot = activeBtn;
    }
    

    //NSLog(@"TOUCH MOVED %f, %f", p.x, p.y);

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    
    // activate current dot and persist state
    TimeLineButton *activeBtn = [self findActiveSubviewOnPoint:p];
    if(activeBtn){
        [self updateButtonsWithActive:activeBtn andDragging:NO];
        self.activeDot = activeBtn;
    }
    

    //NSLog(@"TOUCH BEGAN");
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"TOUCH ENDED ON %@", self.activeDot);
    
    // activate last active dot and persist state
    [self updateButtonsWithActive:self.activeDot andDragging:NO];
}

-(TimeLineButton *)findActiveSubviewOnPoint:(CGPoint)p
{
    for (TimeLineButton *subview in self.subviews)
    {
        if (CGRectContainsPoint(subview.frame, p) )
        {
            // Found the subview the user touched if not already activated
            if(self.activeDot != subview){
                return subview;
            }else{
                NSLog(@"ALREADY ACTIVE");
            }
        }
    }
    return nil;
}

-(void)updateButtonsWithActive:(TimeLineButton *)activeBtn andDragging:(BOOL)dragging
{
    if(!dragging){
        for(TimeLineButton *button in dots){
            if(activeBtn != button){
                [button desactivateButton];
                
                //button.layer.borderColor = [UIColor blackColor].CGColor;

            }
        }
    }
    [activeBtn activateButtonAndKeepState:!dragging];
    self.activeDot = activeBtn;
    
//    self.activeDot.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.activeDot.layer.borderWidth = 1.0;
    
    NSInteger goToStep = [dots indexOfObject:activeBtn];

    NSLog(@"ACTIVE INDEX + %lu", (unsigned long)goToStep );
    
    // MAKE THE CALL TO UPDATE CAROUSEL
}

//- (CAShapeLayer *) findClosestDotFromTouch:(NSSet *)touches
//{
//    NSArray *touchesArray = [touches allObjects];
//    UITouch *touch = (UITouch *)[touchesArray objectAtIndex:0];
//    CGPoint point = [touch locationInView:self];
//    
//    NSInteger min = 1000;
//    CAShapeLayer *closest;
//    
//    for (CAShapeLayer *dot in dots)
//    {
//        NSLog(@"%f", dot.position.y-point.y);
//        NSInteger dist = abs(point.y-dot.position.y);
//        if( dist < min){
//            min = dist;
//            closest = dot;
//        }
//    }
//    
//    return closest;
//
//}

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
