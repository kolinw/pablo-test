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
@synthesize active;
@synthesize transitionning;

- (id)initWithFrame:(CGRect)frame andStateActive:(BOOL)state
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.bounds = CGRectMake(0, 0, 20, 20);
        self.clipsToBounds = YES;
        // disable touch on button, handled by parent view
        self.userInteractionEnabled = NO;
        self.active = state;
        self.transitionning = NO;
        
        //DEBUG
//        self.layer.borderColor = [UIColor whiteColor].CGColor;
//        self.layer.borderWidth = 1.0;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    // Set up the shape of the circle
    int radius = (self.active) ? 5 : 3;
    btn = [CAShapeLayer layer];
    
    
    // Make a circular shape
    btn.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake((self.bounds.size.width-radius)/2, (self.bounds.size.height-radius)/2, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    // Center the shape
    btn.position = CGPointMake(-radius/2, -radius/2);
    
    btn.anchorPoint = CGPointMake(radius/2, radius/2);
    
    // Configure the apperence of the circle
    btn.fillColor = [UIColor grayColor].CGColor;
    btn.lineWidth = 0;
    
    // Add to parent layer
    [self.layer addSublayer:btn];
}

- (void)activateButtonAndKeepState:(BOOL)keepState
{

    self.btn.fillColor = [UIColor blackColor].CGColor;
    
//    if(!self.active && !self.transitionning){
//        
//        self.active = YES;
//        [CATransaction begin];
//        [CATransaction setAnimationDuration:1.0]; {
//            [CATransaction setCompletionBlock:^{
//                //NSLog(@"END ACTIVE");
//                self.transitionning = NO;
//                
//                if(!keepState){
//                    [self desactivateButton];
//                }
//            }];
//            
//            self.transitionning = YES;
//            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
//            
//            animation.toValue = (__bridge id)[UIColor blackColor].CGColor;
//            
//            [animation setFillMode:kCAFillModeForwards];
//            [animation setRemovedOnCompletion:NO];
//            [[self.layer.sublayers objectAtIndex:0] addAnimation:animation forKey:animation.keyPath];
//        } [CATransaction commit];
//        
//    }else{
//        NSLog(@"ALREADY ACTIVE OR TRANSITIONNING");
//    }
}

- (void)desactivateButton
{

    self.btn.fillColor = [UIColor grayColor].CGColor;
    
//    if(!self.transitionning){
//         
//        [CATransaction begin];
//        [CATransaction setAnimationDuration:1.0]; {
//            [CATransaction setCompletionBlock:^{
//                self.active = NO;
//                //NSLog(@"END DESACTIVE");
//                //self.transitionning = NO;
//            }];
//            
//            //self.transitionning = YES;
//            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
//            animation.toValue = (__bridge id)[UIColor grayColor].CGColor;
//            
//            [animation setFillMode:kCAFillModeForwards];
//            [animation setRemovedOnCompletion:NO];
//            [[self.layer.sublayers objectAtIndex:0] addAnimation:animation forKey:animation.keyPath];
//        } [CATransaction commit];
//    }else{
//        NSLog(@"ALREADY TRANSITIONNING");
//    }
}



@end
