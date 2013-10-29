//
//  TimeMachineViewController.h
//  TimeMachine
//
//  Created by WEIDMANN Kolin on 29/10/2013.
//  Copyright (c) 2013 WEIDMANN Kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface TimeMachineViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic, strong) IBOutlet iCarousel *carousel;

@end
