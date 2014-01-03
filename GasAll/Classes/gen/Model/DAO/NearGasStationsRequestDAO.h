//
//  NearGasStationsRequestDAO.h
//  GasAll
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearGasStationsRequestDTO.h"

@interface NearGasStationsRequestDAO : NSObject

// Get the shared instance and create it if necessary.
+ (NearGasStationsRequestDAO *)sharedInstance;

// Set DTOs values from Dictionary
-(NearGasStationsRequestDTO *) readFromDictionary:(NSDictionary *)dict;

// Creates a DTO array from Dictionary array
-(NSArray *) readFromDictionaryArray:(NSArray *)dictArray;

// Creates a json dictionary from DTO instance
-(NSDictionary *) writeToDictionary:(NearGasStationsRequestDTO *)instance;

@end