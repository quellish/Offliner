//
//  AppDelegate.m
//  Offliner
//
//  Created by Dan Zinngrabe on 8/30/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "OfflinerApplicationDelegate.h"

@implementation OfflinerApplicationDelegate

#ifndef MBYTE
#define MBYTE(x)   ((x) << 20)
#endif

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSURLCache  *urlCache   = nil;
    
    urlCache = [[NSURLCache alloc] initWithMemoryCapacity:MBYTE(1) diskCapacity:MBYTE(10) diskPath:[self URLCachePath]];
    [NSURLCache setSharedURLCache:urlCache];
    
    return YES;
}

#pragma mark Error handling

- (void) application:(UIApplication *)application presentError:(NSError *)error {
    
}

#pragma mark - Paths

- (NSString *) URLCachePath {
	return @"URLCache";
}

@end
