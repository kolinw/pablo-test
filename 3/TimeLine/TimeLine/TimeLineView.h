//
//  TimeLineView.h
//  TimeLine
//
//  Created by WEIDMANN Kolin on 30/10/2013.
//  Copyright (c) 2013 WEIDMANN Kolin. All rights reserved.
//

#import <UIKit/UIKit.h>

static const int MAX_NB_DOTS = 18 ;
static const int UNLOCKED_LEVEL = 10;
static const int VMARGIN = 40;


@protocol TimeLineViewDelegate <NSObject>
@required
- (void)stepChanged:(NSInteger)stepId;
@end

@class TimeLineButton;
@interface TimeLineView : UIView
{
    id<TimeLineViewDelegate> delegate;
}

@property (nonatomic, retain) id delegate;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, retain) NSMutableArray *dots;
@property (nonatomic, retain) NSMutableArray *stack;
@property (nonatomic, retain) TimeLineButton *activeDot;

- (void)stepChanged:(NSInteger)stepId;

-(BOOL)unlockNextButton;

@end
