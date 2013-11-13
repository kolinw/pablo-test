//
//  TimeLineViewController.m
//  TimeLine
//
//  Created by WEIDMANN Kolin on 30/10/2013.
//  Copyright (c) 2013 WEIDMANN Kolin. All rights reserved.
//

#import "TimeLineViewController.h"
#import "TimeLineView.h"

@interface TimeLineViewController ()

@end

@implementation TimeLineViewController

@synthesize timeLineView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        timeLineView = [[TimeLineView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-20, 0, 20, self.view.bounds.size.height)];
        //        timeLineView.layer.borderColor = [UIColor whiteColor].CGColor;
        //        timeLineView.layer.borderWidth = 1.0;
        timeLineView.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:timeLineView];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Set up the shape of the circle
    int radius = 100;
    CAShapeLayer *circle = [CAShapeLayer layer];
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    // Center the shape in self.view
    circle.position = CGPointMake(CGRectGetMidX(self.view.frame)-radius,
                                  CGRectGetMidY(self.view.frame)-radius);
    
    // Configure the apperence of the circle
    circle.fillColor = [UIColor whiteColor].CGColor;
    circle.lineWidth = 0;
    
    // Add to parent layer
    //[self.view.layer addSublayer:circle];
    
    
    
    //    // COLOR ANIMATION
    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    //    animation.duration = 1.0;
    //    animation.toValue = (__bridge id)[UIColor colorWithHue:0 saturation:.1 brightness:.1 alpha:.1].CGColor;
    //
    //    [animation setFillMode:kCAFillModeForwards];
    //    [animation setRemovedOnCompletion:NO];
    //
    //    [circle addAnimation:animation forKey:animation.keyPath];
    // END COLOR ANIMATION
    
    
    // SCALE ANIMATION
    //    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //    animation2.fromValue = [NSNumber numberWithFloat:1.00];
    //    animation2.toValue = [NSNumber numberWithFloat:1.50];
    //    animation2.duration = 0.20f;
    //
    //    [animation2 setFillMode:kCAFillModeForwards];
    //    [animation2 setRemovedOnCompletion:NO];
    //
    //    [circle addAnimation:animation2 forKey:@"drag"];
    // END SCALE ANIMATION
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unlockNext:(id)sender {
    NSLog(@"UNLOCK IT MOTHAF");
    [timeLineView unlockNextButton];
}
@end
