//
//  GetNearGasStationsTask.m
//  GasAll
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import "GetNearGasStationsTask.h"
#import "GasAllHelper.h"
#import "GasStationsLogic.h"

@implementation GetNearGasStationsTask

+ (void) getNearGasStationsTaskForRequest:(NearGasStationsRequestDTO *)request showLoadingView:(BOOL)showLoadingView completed:(void(^)(NSInteger statusCode,NearGasStationsResponseDTO *response))completedBlock error:(void(^)(NSError *error))errorBlock {

	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		
	UIView *loadingView;
	if ([[GasAllHelper sharedInstance] respondsToSelector:@selector(loadingViewForTasks)]  && showLoadingView) {
		loadingView = [[GasAllHelper sharedInstance] loadingViewForTasks];
	}
				
	if (loadingView) {
		UIWindow* window = [UIApplication sharedApplication].keyWindow;
		[window addSubview:loadingView];
	}


	[[GasStationsLogic sharedInstance] getNearGasStations:request onSuccess:^(NSInteger statusCode,NearGasStationsResponseDTO *response){

		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		if (loadingView) {
			[loadingView removeFromSuperview];
		}
		if(completedBlock){
			completedBlock(statusCode,response);
		}

	} onError:^(NSError *error){

		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		if (loadingView) {
			[loadingView removeFromSuperview];
		}
		if(errorBlock) {
			errorBlock(error);
		}
	}];

}

+ (void) getNearGasStationsTaskForRequest:(NearGasStationsRequestDTO *)request completed:(void(^)(NSInteger statusCode,NearGasStationsResponseDTO *response))completedBlock error:(void(^)(NSError *error))errorBlock {

	[self getNearGasStationsTaskForRequest:request showLoadingView:YES completed:completedBlock error:errorBlock];
}

@end