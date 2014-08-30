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
    
    // Important: Configure a URL cache.
    // If you are using NSURLSession, you can do this as part of the session configuration and have separate caches.
    [NSURLCache setSharedURLCache:[self newURLCache]];
    
    return YES;
}

#pragma mark URL Cache

- (NSURLCache *)newURLCache {
    NSURLCache  *result   = nil;
    
    // Configure the URL cache with 1mb of in memory cache, 10mb of on disk cache, and in our custom directory
    // If you do not do this, the default URL cache will not have on-disk storage.
    result = [[NSURLCache alloc] initWithMemoryCapacity:MBYTE(1) diskCapacity:MBYTE(10) diskPath:[self URLCachePath]];
    
    return result;
}

- (NSString *) URLCachePath {
    // Foundation will put this in Library/Caches/bundle ID/ by default.
	return @"URLCache";
}

#pragma mark Error handling placeholder

- (void) application:(UIApplication *)application presentError:(NSError *)error {
    
}

@end
