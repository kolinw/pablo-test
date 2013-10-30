//
//  TimeLineButton.m
//  TimeLine
//
//  Created by Kolin Weidmann on 30/10/13.
//  Copyright (c) 2013 WEIDMANN Kolin. All rights reserved.
//

#import "TimeLineButton.h"

@implementation TimeLineButton

@synthesize btn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.bounds = CGRectMake(0, 0, 20, 20);
        self.clipsToBounds = YES;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    // Set up the shape of the circle
    int radius = 5;
    btn = [CAShapeLayer layer];
    
    
    // Make a circular shape
    btn.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    // Center the shape
    btn.position = CGPointMake(0, 0);
    NSLog(@"%s", "TIMELINEBUTTON DRAWRECT");
    
    btn.anchorPoint = CGPointMake(radius, radius);
    
    // Configure the apperence of the circle
    btn.fillColor = [UIColor grayColor].CGColor;
    btn.lineWidth = 0;
    
    // Add to parent layer
    [self.layer addSublayer:btn];

}




@end
