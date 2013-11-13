//
//  TimeLineViewController.h
//  TimeLine
//
//  Created by WEIDMANN Kolin on 30/10/2013.
//  Copyright (c) 2013 WEIDMANN Kolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TimeLineView;
@interface TimeLineViewController : UIViewController
@property (nonatomic, retain) TimeLineView *timeLineView;

- (IBAction)unlockNext:(id)sender;
@end
