//
//  iCarouselExampleViewController.m
//  iCarouselExample
//
//  Created by Nick Lockwood on 03/04/2011.
//  Copyright 2011 Charcoal Design. All rights reserved.
//

#import "iCarouselExampleViewController.h"


@interface iCarouselExampleViewController ()

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic) NSInteger *currentStep;

@end


@implementation iCarouselExampleViewController

@synthesize carousel;
@synthesize currentStep;
@synthesize items;
@synthesize btn;

- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    self.items = [NSMutableArray array];
    for (int i = 0; i < 100; i++)
    {
        [items addObject:@(i)];
    }
}

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    //this is true even if your project is using ARC, unless
    //you are targeting iOS 5 as a minimum deployment target
    carousel.delegate = nil;
    carousel.dataSource = nil;
    
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize size = self.view.frame.size;
    
    NSLog(@"%f", size.height);
    
    //configure carousel
    carousel.type = iCarouselTypeInvertedTimeMachine;
    carousel.bounces = NO;
    
    currentStep = 0;
//    carousel.decelerationRate = 0;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    //free up memory by releasing subviews
    self.carousel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        CGSize size = [UIScreen mainScreen].bounds.size;
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        view.backgroundColor = [UIColor whiteColor];
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
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
    label.text = [items[index] stringValue];
    

    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselOptionFadeMin:
            return -0.2;
        case iCarouselOptionFadeMax:
            return 0.2;
        case iCarouselOptionFadeRange:
            return 2.0;
        case iCarouselOptionTilt:
            return 0;
        case iCarouselOptionSpacing:
            return 2;
        case iCarouselOptionWrap:
            return NO;
        default:
            return value;
    }
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)localCarousel {
    NSLog(@"END SCROLL AT %ld %i", (long)localCarousel.currentItemIndex, (int)currentStep);
}

- (void)endChangeSlider{
    NSLog(@"%s", "TOUCH UP SLIDER");
    UIView *currentView = [carousel itemViewAtIndex:currentStep ];
    // TODO : comprendre pourquoi el recyclage des vues change le backgroundColor de place ...
    currentView.backgroundColor = [UIColor blackColor];
}

#pragma mark -
#pragma mark UI events methods

- (IBAction)onValueChanged:(UISlider *)sender {
    
    NSInteger newStep = (NSInteger)(sender.value);

    if(newStep != (int)currentStep) {
        NSLog(@"SCROLL FROM %lu", (unsigned long)currentStep);
        NSLog(@"TO %lu", (unsigned long)newStep);
        [carousel scrollToItemAtIndex:newStep duration:0.3];
        currentStep = newStep;
    }
}

- (IBAction)onTouchUp:(id)sender {
    [self endChangeSlider];
}

- (IBAction)onTouchUpOut:(id)sender {
    [self endChangeSlider];
}

- (IBAction)onTouch5:(id)sender {
    [carousel scrollToItemAtIndex:5 duration:1];
    NSLog(@"%s", "GO TO 5");
}


@end
