//
//  DataController.h
//  playlist
//
//  Created by WEIDMANN Kolin on 14/11/13.
//  Copyright (c) 2013 WEIDMANN Kolin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataController : NSObject {
    NSString *personName;
    BOOL firstTime;
}

@property (copy, nonatomic) NSString *personName;
@property BOOL firstTime;

- (void)saveData;

@end
