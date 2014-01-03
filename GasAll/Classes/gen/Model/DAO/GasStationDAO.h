//
//  GasStationDAO.h
//  GasAll
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GasStationDTO.h"

@interface GasStationDAO : NSObject

// Get the shared instance and create it if necessary.
+ (GasStationDAO *)sharedInstance;

// Set DTOs values from Dictionary
-(GasStationDTO *) readFromDictionary:(NSDictionary *)dict;

// Creates a DTO array from Dictionary array
-(NSArray *) readFromDictionaryArray:(NSArray *)dictArray;

// Creates a json dictionary from DTO instance
-(NSDictionary *) writeToDictionary:(GasStationDTO *)instance;

@end