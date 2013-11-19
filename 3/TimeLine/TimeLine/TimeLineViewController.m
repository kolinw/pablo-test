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

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic) NSInteger *currentStep;

@end

@implementation TimeLineViewController

@synthesize timeLineView;
@synthesize carousel, currentStep;

- (id)init
{
    if ((self = [super init])) {
        self.items = [NSMutableArray array];
        for (int i = 0; i < 1000; i++)
        {
            [self.items addObject:@(i)];
        }
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    
    // CAROUSEL
    carousel = [[iCarousel alloc] initWithFrame:self.view.bounds];
    carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    carousel.type = iCarouselTypeInvertedTimeMachine;
    carousel.bounces = NO;
    carousel.scrollEnabled = NO;
    carousel.delegate = self;
    carousel.dataSource = self;
    
    //    DEBUG
    carousel.layer.borderColor = [UIColor whiteColor].CGColor;
    carousel.layer.borderWidth = 1.0;
    
    [self.view addSubview:carousel];
    // END CAROUSEL
    
    // TIMELINE
    timeLineView = [[TimeLineView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-20, 0, 20, self.view.bounds.size.height)];
    //        timeLineView.layer.borderColor = [UIColor whiteColor].CGColor;
    //        timeLineView.layer.borderWidth = 1.0;
    timeLineView.backgroundColor = [UIColor whiteColor];
    [timeLineView setDelegate:self];
    
    [self.view addSubview:timeLineView];
    // END TIMELINE
    
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unlockNext:(id)sender {
    [timeLineView unlockNextButton];
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [self.items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [_items[index] stringValue];
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselOptionFadeMin:
            return -0.2f;
        case iCarouselOptionFadeMax:
            return 0.2f;
        case iCarouselOptionFadeRange:
            return .8f;
        case iCarouselOptionTilt:
            return 0;
        case iCarouselOptionSpacing:
            return 2;
        case iCarouselOptionWrap:
            return NO;
        case iCarouselOptionVisibleItems:
            return 2;
        default:
            return value;
    }
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)localCarousel
{
    NSLog(@"END SCROLL AT %ld %i", (long)self.carousel.currentItemIndex, (int)currentStep);
}

- (void)endChangeSlider{
    NSLog(@"%s", "TOUCH UP SLIDER");
    UIView *currentView = [self.carousel itemViewAtIndex:*(currentStep) ];
    // TODO : comprendre pourquoi el recyclage des vues change le backgroundColor de place ...
    currentView.backgroundColor = [UIColor blackColor];
}

-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"SELECT %ld", (long)index);
}

#pragma mark -
#pragma mark TimeLine Methods

-(void)stepChanged:(NSInteger)stepId
{
    NSLog(@"INTO DElEGATE WITH %i", stepId);
    [carousel scrollToItemAtIndex:stepId animated:YES];
}
@end
