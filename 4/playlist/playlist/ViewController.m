//
//  ViewController.m
//  playlist
//
//  Created by WEIDMANN Kolin on 14/11/13.
//  Copyright (c) 2013 WEIDMANN Kolin. All rights reserved.
//

#import "ViewController.h"
#import "DataController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize label;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    DataController *data = [[DataController alloc] init];
    
    NSLog(@"NAME=%@", data.personName);
    
    label.text = data.personName;
    
    NSLog(@"FIRST=%hhd", data.firstTime);
    
    if(data.firstTime){
        self.view.layer.borderColor = [UIColor redColor].CGColor;
        self.view.layer.borderWidth = 2.0;
        data.firstTime = NO;
        data.personName = @"Kolin Weidmann";
        [data saveData];
    }else{
        self.view.layer.borderColor = [UIColor greenColor].CGColor;
        self.view.layer.borderWidth = 1.0;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
