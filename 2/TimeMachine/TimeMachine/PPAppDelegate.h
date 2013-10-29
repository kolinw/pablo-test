//
//  PPAppDelegate.h
//  TimeMachine
//
//  Created by WEIDMANN Kolin on 29/10/2013.
//  Copyright (c) 2013 WEIDMANN Kolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeMachineViewController.h"

@interface PPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) IBOutlet TimeMachineViewController *timeMachine;

@end
