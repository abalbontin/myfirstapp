//
//  .m
//  ${projectName}
//  Version: ${version}
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import "NearGasStationsRequestDTO.h"
#import "NearGasStationsRequestDAO.h"

@implementation NearGasStationsRequestDAO


// Get the shared instance and create it if necessary.
+ (NearGasStationsRequestDAO *)sharedInstance {
    
    static dispatch_once_t onceQueue;
    static NearGasStationsRequestDAO *instance = nil;
    
    dispatch_once(&onceQueue, ^{ instance = [[self alloc] init]; });
    return instance;
}

-(NSDictionary *) writeToDictionary:(NearGasStationsRequestDTO *)instance
{
NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];	
		
			dict[@"latitude"] = instance.latitude;
			dict[@"longitude"] = instance.longitude;
		
	

	return dict;
}

-(NearGasStationsRequestDTO *) readFromDictionary:(NSDictionary *)dict
{
	NearGasStationsRequestDTO *instance=[[NearGasStationsRequestDTO alloc]init];
	if(![dict isKindOfClass:[NSNull class]])
	    {

    if (dict[@"latitude"] && ![dict[@"latitude"] isKindOfClass:[NSNull class]]) {
		instance.latitude = dict[@"latitude"];
        }
    if (dict[@"longitude"] && ![dict[@"longitude"] isKindOfClass:[NSNull class]]) {
		instance.longitude = dict[@"longitude"];
        }

  

	}
	return instance;
}


// Establece valores a partir de un NSArray
-(NSArray *) readFromDictionaryArray:(NSArray *)dictArray
{
	NSMutableArray *mutableArray=[[NSMutableArray alloc]init];
	for(NSDictionary *dict in dictArray)
	{
		[mutableArray addObject:[self readFromDictionary:dict]];
	}
	return mutableArray;
}
@end
 
