//
//  GasStations.m
//  GasAll
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import "BaseGasStationsLogic.h"

#import "AFHTTPRequestOperation.h"
#import "MVYDefines.h"
#import "GasAllHelper.h"
#import "NearGasStationsRequestDTO.h"
#import "NearGasStationsResponseDTO.h"
#import "NearGasStationsRequestDAO.h"
#import "NearGasStationsResponseDAO.h"


@implementation BaseGasStationsLogic



/**
* Method getNearGasStations: Devuelve las gasolineras que hay en la posicion que se pasa como parametro
* @param nearGasStationsRequestDTO Service request
* @returns NearGasStationsResponseDTO Service response
*/
- (void)getNearGasStations:(NearGasStationsRequestDTO *)nearGasStationsRequestDTO onSuccess:(void(^)(NSInteger responseCode,NearGasStationsResponseDTO *response))onSuccess onError:(void(^)(NSError *error))onError {

	NSString *url=@"https://dl.dropboxusercontent.com/u/578930/gasall_getNearGasStations.txt";

	if ([[GasAllHelper sharedInstance] respondsToSelector:@selector(preInjectURLParameters:withObject:)]) {
		url=[[GasAllHelper sharedInstance] preInjectURLParameters:url  withObject:nearGasStationsRequestDTO];
	}	
	NSString *stringLatitude=[NSString stringWithFormat:@"%@",nearGasStationsRequestDTO.latitude];
	NSString *stringLongitude=[NSString stringWithFormat:@"%@",nearGasStationsRequestDTO.longitude];

    url = [url stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"${%@}",@"latitude"] withString:stringLatitude];
    url = [url stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"${%@}",@"longitude"] withString:stringLongitude];

	if ([[GasAllHelper sharedInstance] respondsToSelector:@selector(postInjectURLParameters:withObject:)]) {
		url = [[GasAllHelper sharedInstance] postInjectURLParameters:url  withObject:nearGasStationsRequestDTO];
	}

	_ModelGenLog(@"URL: %@", url);

	NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
	[dict setValue:[NSString stringWithFormat:@"%@",nearGasStationsRequestDTO.latitude] forKey:@"latitude"];
	[dict setValue:[NSString stringWithFormat:@"%@",nearGasStationsRequestDTO.longitude] forKey:@"longitude"];
	double time = [[NSDate date] timeIntervalSince1970];
    [dict setValue:[NSNumber numberWithDouble:time] forKey:@"requestTime"];

	if ([[GasAllHelper sharedInstance] respondsToSelector:@selector(escapeUrl:)]) {
		url = [[GasAllHelper sharedInstance] escapeUrl:url];
	} else {
		url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	}
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];

	NSMutableArray * content = [NSMutableArray array];
	for(NSString * key in dict) {

  		[content addObject: [NSString stringWithFormat: @"%@=%@", key, dict[key]]];
    }
	NSString * body = [content componentsJoinedByString: @"&"];
	NSData * bodyData = [body dataUsingEncoding: NSUTF8StringEncoding];
	[request setHTTPBody:bodyData];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPMethod:@"POST"];
	
	request = [[GasAllHelper sharedInstance] manageRequest:request];
	
	AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
  	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

		NSError *error;
		NearGasStationsResponseDTO *dto=[self getNearGasStationsDTOFromOperation:operation withError:&error];

    	if (!error) {
	        if (onSuccess) {
	            onSuccess(operation.response.statusCode,dto);
	        }      	  
	  	} else {
			if (onError) {
				onError(error);
			}    	      
		}    
		
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {

	    NearGasStationsResponseDTO *dto=[self getNearGasStationsDTOFromOperation:operation withError:nil];
		if(dto)
		{
	        if (onSuccess) {
	            onSuccess(operation.response.statusCode,dto);
	        }
		}
		else if (onError) {
			onError(error);
		}
	}];

	[operation start];
}

-(NearGasStationsResponseDTO *) getNearGasStationsDTOFromOperation:(AFHTTPRequestOperation *)operation withError:(NSError **)error
{
        NSData *data = operation.responseData;

		if ([[GasAllHelper sharedInstance] respondsToSelector:@selector(preprocessResponse:)]) {
			NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
			stringData =[[GasAllHelper sharedInstance] preprocessResponse:stringData];
			data = [stringData dataUsingEncoding:NSUTF8StringEncoding];
		}

		NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:error];

		json=[[GasAllHelper sharedInstance] preprocessResponseAsDictionary:json];

        NearGasStationsResponseDTO *dto=nil;
         if(json)
         {
			 _ModelGenLog(@"JSON: %@", json);
            dto = [[NearGasStationsResponseDAO sharedInstance] readFromDictionary:json];
         }
         return dto;
}


@end

 