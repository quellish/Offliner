//
//  ViewController.m
//  Offliner
//
//  Created by Dan Zinngrabe on 8/30/14.
//  Copyright (c) 2014 Dan Zinngrabe. All rights reserved.
//

#import "OfflinerViewController.h"

@interface OfflinerViewController ()
@property   (nonatomic, assign, getter = isOffline) BOOL    offline;
@property   (nonatomic, weak)   IBOutlet    UILabel *textLabel;
@end

@implementation OfflinerViewController
@synthesize offline;
@synthesize textLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (IBAction)switchValueChanged:(id)sender {
    if ([sender respondsToSelector:@selector(isOn)]){
        UISwitch    *offlineSwitch = (UISwitch *)sender;
        [self setOffline:[offlineSwitch isOn]];
    } else {
        // Assert
    }
}

- (IBAction)fetchButtonReleased:(id)sender {
    
    [[self textLabel] setText:nil];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self dataWithRequest:[self request] completion:^(NSURLResponse *response, NSData *data, NSError *error){
        if (response != nil){
            NSString    *responseText   = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                [[self textLabel] setText:responseText];
            }];
        } else {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                [self presentError:error];
            }];
        }
    }];
}

#pragma mark Network

- (NSURL *)URL  {
    return [NSURL URLWithString:@"http://s3.amazonaws.com/notremote/People.json"];
}

- (NSURLRequest *) request {
    NSURLRequest    *result = nil;
    
    if ([self isOffline] != YES){
        // Use the protocol cache policy. This is the default.
        result = [[NSURLRequest alloc] initWithURL:[self URL] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10L];
    } else {
        // If it's in the cache, use it, otherwise do not attempt to load.
        result = [[NSURLRequest alloc] initWithURL:[self URL] cachePolicy:NSURLRequestReturnCacheDataDontLoad timeoutInterval:10L];
    }
    
    return result;
}

- (void) dataWithRequest:(NSURLRequest *)request completion:(void (^)(NSURLResponse*, NSData*, NSError*))completion{
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new] completionHandler:completion];
}

#pragma mark Error handling

- (void) presentError:(NSError *)error {
    UIAlertView *alertView  = nil;
    
    alertView = [[UIAlertView alloc] initWithTitle:[error localizedDescription] message:[error localizedFailureReason] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

@end
