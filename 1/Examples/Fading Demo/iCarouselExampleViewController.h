//
//  iCarouselExampleViewController.h
//  iCarouselExample
//
//  Created by Nick Lockwood on 03/04/2011.
//  Copyright 2011 Charcoal Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"


@interface iCarouselExampleViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btn;
- (IBAction)onValueChanged:(UISlider *)sender;
- (IBAction)onTouchUp:(id)sender;
- (IBAction)onTouchUpOut:(id)sender;

- (IBAction)onTouch5:(id)sender;

@end
