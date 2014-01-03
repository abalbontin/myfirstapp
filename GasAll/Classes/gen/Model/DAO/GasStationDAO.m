//
//  .m
//  ${projectName}
//  Version: ${version}
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import "GasStationDTO.h"
#import "GasStationDAO.h"

@implementation GasStationDAO


// Get the shared instance and create it if necessary.
+ (GasStationDAO *)sharedInstance {
    
    static dispatch_once_t onceQueue;
    static GasStationDAO *instance = nil;
    
    dispatch_once(&onceQueue, ^{ instance = [[self alloc] init]; });
    return instance;
}

-(NSDictionary *) writeToDictionary:(GasStationDTO *)instance
{
NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];	
		
			dict[@"id"] = instance.id;
			dict[@"name"] = instance.name;
			dict[@"G95"] = instance.price95;
			dict[@"G98"] = instance.price98;
			dict[@"GOA"] = instance.priceGOA;
			dict[@"NGO"] = instance.priceNGO;
			dict[@"GPR"] = instance.priceGPR;
			dict[@"latitude"] = instance.latitude;
			dict[@"longitude"] = instance.longitude;
			dict[@"distance"] = instance.distance;
			dict[@"promoted"] = instance.promoted.boolValue ? @"true": @"false";
			dict[@"promotionText"] = instance.promotionText;
			dict[@"promotionImage"] = instance.promotionImage;
			dict[@"promotionCode"] = instance.promotionCode;
			dict[@"promotionTextExtra"] = instance.promotionTextExtra;
		
	

	return dict;
}

-(GasStationDTO *) readFromDictionary:(NSDictionary *)dict
{
	GasStationDTO *instance=[[GasStationDTO alloc]init];
	if(![dict isKindOfClass:[NSNull class]])
	    {

    if (dict[@"id"] && ![dict[@"id"] isKindOfClass:[NSNull class]]) {
	if([dict[@"id"] isKindOfClass:[NSString class]])
	{
		instance.id=dict[@"id"];
	}
	else
	{
		instance.id=[NSString stringWithFormat:@"%@",dict[@"id"]];
	}
        }
    if (dict[@"name"] && ![dict[@"name"] isKindOfClass:[NSNull class]]) {
	if([dict[@"name"] isKindOfClass:[NSString class]])
	{
		instance.name=dict[@"name"];
	}
	else
	{
		instance.name=[NSString stringWithFormat:@"%@",dict[@"name"]];
	}
        }
    if (dict[@"G95"] && ![dict[@"G95"] isKindOfClass:[NSNull class]]) {
		instance.price95 = dict[@"G95"];
        }
    if (dict[@"G98"] && ![dict[@"G98"] isKindOfClass:[NSNull class]]) {
		instance.price98 = dict[@"G98"];
        }
    if (dict[@"GOA"] && ![dict[@"GOA"] isKindOfClass:[NSNull class]]) {
		instance.priceGOA = dict[@"GOA"];
        }
    if (dict[@"NGO"] && ![dict[@"NGO"] isKindOfClass:[NSNull class]]) {
		instance.priceNGO = dict[@"NGO"];
        }
    if (dict[@"GPR"] && ![dict[@"GPR"] isKindOfClass:[NSNull class]]) {
		instance.priceGPR = dict[@"GPR"];
        }
    if (dict[@"latitude"] && ![dict[@"latitude"] isKindOfClass:[NSNull class]]) {
		instance.latitude = dict[@"latitude"];
        }
    if (dict[@"longitude"] && ![dict[@"longitude"] isKindOfClass:[NSNull class]]) {
		instance.longitude = dict[@"longitude"];
        }
    if (dict[@"distance"] && ![dict[@"distance"] isKindOfClass:[NSNull class]]) {
		instance.distance = dict[@"distance"];
        }
    if (dict[@"promoted"] && ![dict[@"promoted"] isKindOfClass:[NSNull class]]) {
		instance.promoted = dict[@"promoted"];
        }
    if (dict[@"promotionText"] && ![dict[@"promotionText"] isKindOfClass:[NSNull class]]) {
	if([dict[@"promotionText"] isKindOfClass:[NSString class]])
	{
		instance.promotionText=dict[@"promotionText"];
	}
	else
	{
		instance.promotionText=[NSString stringWithFormat:@"%@",dict[@"promotionText"]];
	}
        }
    if (dict[@"promotionImage"] && ![dict[@"promotionImage"] isKindOfClass:[NSNull class]]) {
	if([dict[@"promotionImage"] isKindOfClass:[NSString class]])
	{
		instance.promotionImage=dict[@"promotionImage"];
	}
	else
	{
		instance.promotionImage=[NSString stringWithFormat:@"%@",dict[@"promotionImage"]];
	}
        }
    if (dict[@"promotionCode"] && ![dict[@"promotionCode"] isKindOfClass:[NSNull class]]) {
	if([dict[@"promotionCode"] isKindOfClass:[NSString class]])
	{
		instance.promotionCode=dict[@"promotionCode"];
	}
	else
	{
		instance.promotionCode=[NSString stringWithFormat:@"%@",dict[@"promotionCode"]];
	}
        }
    if (dict[@"promotionTextExtra"] && ![dict[@"promotionTextExtra"] isKindOfClass:[NSNull class]]) {
	if([dict[@"promotionTextExtra"] isKindOfClass:[NSString class]])
	{
		instance.promotionTextExtra=dict[@"promotionTextExtra"];
	}
	else
	{
		instance.promotionTextExtra=[NSString stringWithFormat:@"%@",dict[@"promotionTextExtra"]];
	}
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
 
