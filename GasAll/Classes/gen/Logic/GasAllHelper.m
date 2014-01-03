//
//  GasAllHelper.m
//  GasAll
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import "GasAllHelper.h"
#import <QuartzCore/QuartzCore.h>

@implementation GasAllHelper


// Get the shared instance and create it if necessary.
+ (GasAllHelper *)sharedInstance {
    
    static dispatch_once_t onceQueue;
    static GasAllHelper *instance = nil;
    
    dispatch_once(&onceQueue, ^{ instance = [[self alloc] init]; });
    return instance;
}

- (NSString *)preInjectURLParameters:(NSString *)url withObject:(NSObject *)object {
	return url;
}

- (NSString *)postInjectURLParameters:(NSString *)url withObject:(NSObject *)object {
	return url;
}

- (NSString *)escapeUrl:(NSString *)url {
	return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSMutableURLRequest *)manageRequest:(NSMutableURLRequest *)request {	
	return request;
}

- (NSString *)preprocessResponse:(NSString *)responseString {
	return responseString;
}

- (NSDictionary *) preprocessResponseAsDictionary:(NSDictionary *)responseDict {
	return responseDict;
}

- (UIView *) loadingViewForTasks {

	// Una vista de carga por defecto
	CGRect screenRect = [[UIScreen mainScreen] bounds];
	CGFloat screenWidth = screenRect.size.width;
	CGFloat screenHeight = screenRect.size.height;
    
    UIView *loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [loadingView setBackgroundColor:[UIColor clearColor]];
    
    CGSize centerViewSize = CGSizeMake(100, 100);
    
    UIView *centerView = [[UIView alloc] initWithFrame:
                          CGRectMake(screenWidth/2 - centerViewSize.width/2, 
                                     screenHeight/2 - centerViewSize.height/2, 
                                     centerViewSize.width, 
                                     centerViewSize.height)];
    
    [centerView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    [centerView.layer setCornerRadius:5];
    [centerView.layer setMasksToBounds:YES];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator setFrame:CGRectMake(screenWidth/2 - activityIndicator.frame.size.width/2,       // X
                                           screenHeight/2 - activityIndicator.frame.size.height/2,     // Y
                                           activityIndicator.frame.size.width, activityIndicator.frame.size.height)];
    [loadingView addSubview:centerView];
    [loadingView addSubview:activityIndicator];    
    [activityIndicator startAnimating];
    
    return loadingView;
}

@end