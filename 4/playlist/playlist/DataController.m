//
//  DataController.m
//  playlist
//
//  Created by WEIDMANN Kolin on 14/11/13.
//  Copyright (c) 2013 WEIDMANN Kolin. All rights reserved.
//

#import "DataController.h"

@implementation DataController

@synthesize personName, firstTime;

- (id) init {
    
    self = [super init];
    if (self) {
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSString *plistPath;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  NSUserDomainMask, YES) objectAtIndex:0];
        plistPath = [rootPath stringByAppendingPathComponent:@"Data.plist"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            NSLog(@"copying database to users documents");
            plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
        }
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                              propertyListFromData:plistXML
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              format:&format
                                              errorDescription:&errorDesc];
        if (!temp) {
            NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
        }
        
        self.personName = [temp objectForKey:@"Name"];
        self.firstTime = [[temp objectForKey:@"FirstTime"] boolValue];
        
    }
    return self;
}

- (void)applicationDidEnterBackground {
    NSLog(@"background");
}

//- (void)applicationWillTerminate:(UIApplication *)sender
- (void)saveData
{
    NSLog(@"Will save");
    NSString *error;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Data.plist"];
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects:
                               [NSArray arrayWithObjects: personName, [NSNumber numberWithBool:firstTime] , nil]
                                                          forKeys:[NSArray arrayWithObjects: @"Name", @"FirstTime", nil]];
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
    }
    else {
        NSLog(@"%@", error);
    }
    NSLog(@"Saved");
}

@end
