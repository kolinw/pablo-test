//
//  TimeMachineViewController.m
//  TimeMachine
//
//  Created by WEIDMANN Kolin on 29/10/2013.
//  Copyright (c) 2013 WEIDMANN Kolin. All rights reserved.
//

#import "TimeMachineViewController.h"


@interface TimeMachineViewController ()

// private property
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation TimeMachineViewController

@synthesize carousel;
@synthesize items;

@synthesize animals, descriptions, wrap;

- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    self.items = [NSMutableArray array];
    for (int i = 0; i < 10; i++)
    {
        [items addObject:@(i)];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"INIT WITH NIB NAME");
        
        //set up carousel data
        wrap = NO;
        self.animals = [NSMutableArray arrayWithObjects:@"Bear.png",
                        @"Zebra.png",
                        @"Tiger.png",
                        @"Goat.png",
                        @"Birds.png",
                        @"Giraffe.png",
                        @"Chimp.png",
                        nil];
        self.descriptions = [NSMutableArray arrayWithObjects:@"Bears Eat: Honey",
                             @"Zebras Eat: Grass",
                             @"Tigers Eat: Meat",
                             @"Goats Eat: Weeds",
                             @"Birds Eat: Seeds",
                             @"Giraffes Eat: Trees",
                             @"Chimps Eat: Bananas",
                             nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize size = self.view.frame.size;
    
    NSLog(@"%f", size.height);
    
    //configure carousel
    carousel.type = iCarouselTypeInvertedTimeMachine;
    //    carousel.decelerationRate = 0;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    //free up memory by releasing subviews
    self.carousel = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    carousel.delegate = nil;
    carousel.dataSource = nil;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //NSLog(@"%i", [items count]);
    //return the total number of items in the carousel
    //return [items count];
    return [animals count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
//    UILabel *label = nil;
    
    //create new view if no view is available for recycling
//    if (view == nil)
//    {
//        //don't do anything specific to the index within
//        //this `if (view == nil) {...}` statement because the view will be
//        //recycled and used with other index values later
//        CGSize size = [UIScreen mainScreen].bounds.size;
//        view = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, size.width-10, size.height-10)];
//        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
//        view.contentMode = UIViewContentModeCenter;
//        view.backgroundColor = [UIColor whiteColor];
//        
//        label = [[UILabel alloc] initWithFrame:view.bounds];
//        label.backgroundColor = [UIColor clearColor];
//        label.textAlignment = UITextAlignmentCenter;
//        label.font = [label.font fontWithSize:50];
//        label.tag = 1;
//        [view addSubview:label];
//    }
//    else
//    {
//        //get a reference to the label in the recycled view
//        label = (UILabel *)[view viewWithTag:1];
//    }
//    
//    //set item label
//    //remember to always set any properties of your carousel item
//    //views outside of the `if (view == nil) {...}` check otherwise
//    //you'll get weird issues with carousel item content appearing
//    //in the wrong place in the carousel
//    label.text = [items[index] stringValue];
//    
//    return view;
    
    
    //create a numbered view
    UIView *cview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[animals objectAtIndex:index]]];
    return cview;
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
        default:
            return value;
    }
}

@end
