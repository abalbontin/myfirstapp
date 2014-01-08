//
//  .m
//  ${projectName}
//  Version: ${version}
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import "GasStationDTO.h"
#import "GasolinePriceDTO.h"
#import "GasolinePriceDAO.h"
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
		
			dict[@"id"] = instance.gasStationID;
			dict[@"name"] = instance.name;
			dict[@"latitude"] = instance.latitude;
			dict[@"longitude"] = instance.longitude;
			dict[@"distance"] = instance.distance;
			dict[@"promoted"] = instance.promoted.boolValue ? @"true": @"false";
			dict[@"promotionText"] = instance.promotionText;
			dict[@"promotionImage"] = instance.promotionImage;
			dict[@"promotionCode"] = instance.promotionCode;
			dict[@"promotionTextExtra"] = instance.promotionTextExtra;
		
	

	NSMutableArray *arraygasolinePrice=[[NSMutableArray alloc]init];
	for(GasolinePriceDTO *typeItem in instance.gasolinePrice)
	{
		NSDictionary *dictgasolinePrice=[[GasolinePriceDAO sharedInstance] writeToDictionary:typeItem];
		[arraygasolinePrice addObject:dictgasolinePrice];
	}
	dict[@"gasolinePrice"] = arraygasolinePrice;

	return dict;
}

-(GasStationDTO *) readFromDictionary:(NSDictionary *)dict
{
	GasStationDTO *instance=[[GasStationDTO alloc]init];
	if(![dict isKindOfClass:[NSNull class]])
	    {
    instance.gasolinePrice=[[NSMutableArray alloc]init];

    if (dict[@"id"] && ![dict[@"id"] isKindOfClass:[NSNull class]]) {
	if([dict[@"id"] isKindOfClass:[NSString class]])
	{
		instance.gasStationID=dict[@"id"];
	}
	else
	{
		instance.gasStationID=[NSString stringWithFormat:@"%@",dict[@"id"]];
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

  

	NSDictionary *gasolinePriceItem = nil;
	if(![dict[@"gasolinePrice"] isKindOfClass:[NSNull class]])
	{
		gasolinePriceItem=dict[@"gasolinePrice"];
	}
	
	if([gasolinePriceItem isKindOfClass:[NSArray class]])
	{
		NSArray *gasolinePriceArray=dict[@"gasolinePrice"];
		NSMutableArray *gasolinePriceMutableArray=[[NSMutableArray alloc]init];
		for(NSDictionary *data in gasolinePriceArray)
		{
			GasolinePriceDTO *item=[[GasolinePriceDAO sharedInstance] readFromDictionary:data];
			[gasolinePriceMutableArray addObject:item];
		}
		instance.gasolinePrice=gasolinePriceMutableArray;
	}
	else if (gasolinePriceItem)
	{
		NSMutableArray *gasolinePriceMutableArray=[[NSMutableArray alloc]init];
		GasolinePriceDTO *item=[[GasolinePriceDAO sharedInstance] readFromDictionary:gasolinePriceItem];
		[gasolinePriceMutableArray addObject:item];
		instance.gasolinePrice=gasolinePriceMutableArray;
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
 
