//
//  TimeLineView.h
//  TimeLine
//
//  Created by WEIDMANN Kolin on 30/10/2013.
//  Copyright (c) 2013 WEIDMANN Kolin. All rights reserved.
//

#import <UIKit/UIKit.h>

static const int NB_DOTS = 18 ;
static const int VMARGIN = 40 ;

@interface TimeLineView : UIView

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, retain) NSMutableArray *dots;

@end
