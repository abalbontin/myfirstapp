//
//  GasAllHelper.h
//  GasAll
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GasAllHelper : NSObject

// Get the shared instance and create it if necessary.
+ (GasAllHelper *)sharedInstance;
- (NSString *) preInjectURLParameters:(NSString *)url withObject:(NSObject *)obj;
- (NSString *) postInjectURLParameters:(NSString *)url withObject:(NSObject *)obj;
- (NSString *) escapeUrl:(NSString *)url;
- (NSMutableURLRequest *)manageRequest:(NSMutableURLRequest *)request;
- (NSString *) preprocessResponse:(NSString *)responseString;
- (NSDictionary *) preprocessResponseAsDictionary:(NSDictionary *)responseDict;
- (UIView *) loadingViewForTasks;
@end