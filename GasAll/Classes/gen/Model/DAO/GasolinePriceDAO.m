//
//  .m
//  ${projectName}
//  Version: ${version}
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import "GasolinePriceDTO.h"
#import "GasolinePriceDAO.h"

@implementation GasolinePriceDAO


// Get the shared instance and create it if necessary.
+ (GasolinePriceDAO *)sharedInstance {
    
    static dispatch_once_t onceQueue;
    static GasolinePriceDAO *instance = nil;
    
    dispatch_once(&onceQueue, ^{ instance = [[self alloc] init]; });
    return instance;
}

-(NSDictionary *) writeToDictionary:(GasolinePriceDTO *)instance
{
NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];	
		
			dict[@"gasID"] = instance.gasID;
			dict[@"price"] = instance.price;
		
	

	return dict;
}

-(GasolinePriceDTO *) readFromDictionary:(NSDictionary *)dict
{
	GasolinePriceDTO *instance=[[GasolinePriceDTO alloc]init];
	if(![dict isKindOfClass:[NSNull class]])
	    {

    if (dict[@"gasID"] && ![dict[@"gasID"] isKindOfClass:[NSNull class]]) {
	if([dict[@"gasID"] isKindOfClass:[NSString class]])
	{
		instance.gasID=dict[@"gasID"];
	}
	else
	{
		instance.gasID=[NSString stringWithFormat:@"%@",dict[@"gasID"]];
	}
        }
    if (dict[@"price"] && ![dict[@"price"] isKindOfClass:[NSNull class]]) {
		instance.price = dict[@"price"];
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
 
