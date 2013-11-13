//
//  TimeLineViewController.h
//  TimeLine
//
//  Created by WEIDMANN Kolin on 30/10/2013.
//  Copyright (c) 2013 WEIDMANN Kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@class TimeLineView;

@interface TimeLineViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) TimeLineView *timeLineView;
@property (nonatomic, strong) iCarousel *carousel;


- (IBAction)unlockNext:(id)sender;
@end
