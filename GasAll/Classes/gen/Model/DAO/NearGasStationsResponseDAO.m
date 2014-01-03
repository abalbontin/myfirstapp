//
//  .m
//  ${projectName}
//  Version: ${version}
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import "NearGasStationsResponseDTO.h"
#import "GasStationDTO.h"
#import "GasStationDAO.h"
#import "NearGasStationsResponseDAO.h"

@implementation NearGasStationsResponseDAO


// Get the shared instance and create it if necessary.
+ (NearGasStationsResponseDAO *)sharedInstance {
    
    static dispatch_once_t onceQueue;
    static NearGasStationsResponseDAO *instance = nil;
    
    dispatch_once(&onceQueue, ^{ instance = [[self alloc] init]; });
    return instance;
}

-(NSDictionary *) writeToDictionary:(NearGasStationsResponseDTO *)instance
{
NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];	
		
		
	

	NSMutableArray *arraygasStations=[[NSMutableArray alloc]init];
	for(GasStationDTO *typeItem in instance.gasStations)
	{
		NSDictionary *dictgasStations=[[GasStationDAO sharedInstance] writeToDictionary:typeItem];
		[arraygasStations addObject:dictgasStations];
	}
	dict[@"gasStations"] = arraygasStations;

	return dict;
}

-(NearGasStationsResponseDTO *) readFromDictionary:(NSDictionary *)dict
{
	NearGasStationsResponseDTO *instance=[[NearGasStationsResponseDTO alloc]init];
	if(![dict isKindOfClass:[NSNull class]])
	    {
    instance.gasStations=[[NSMutableArray alloc]init];


  

	NSDictionary *gasStationsItem = nil;
	if(![dict[@"gasStations"] isKindOfClass:[NSNull class]])
	{
		gasStationsItem=dict[@"gasStations"];
	}
	
	if([gasStationsItem isKindOfClass:[NSArray class]])
	{
		NSArray *gasStationsArray=dict[@"gasStations"];
		NSMutableArray *gasStationsMutableArray=[[NSMutableArray alloc]init];
		for(NSDictionary *data in gasStationsArray)
		{
			GasStationDTO *item=[[GasStationDAO sharedInstance] readFromDictionary:data];
			[gasStationsMutableArray addObject:item];
		}
		instance.gasStations=gasStationsMutableArray;
	}
	else if (gasStationsItem)
	{
		NSMutableArray *gasStationsMutableArray=[[NSMutableArray alloc]init];
		GasStationDTO *item=[[GasStationDAO sharedInstance] readFromDictionary:gasStationsItem];
		[gasStationsMutableArray addObject:item];
		instance.gasStations=gasStationsMutableArray;
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
 
