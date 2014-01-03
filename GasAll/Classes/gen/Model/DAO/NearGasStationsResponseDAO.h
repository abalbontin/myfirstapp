//
//  NearGasStationsResponseDAO.h
//  GasAll
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GasStationDTO.h"
#import "NearGasStationsResponseDTO.h"

@interface NearGasStationsResponseDAO : NSObject

// Get the shared instance and create it if necessary.
+ (NearGasStationsResponseDAO *)sharedInstance;

// Set DTOs values from Dictionary
-(NearGasStationsResponseDTO *) readFromDictionary:(NSDictionary *)dict;

// Creates a DTO array from Dictionary array
-(NSArray *) readFromDictionaryArray:(NSArray *)dictArray;

// Creates a json dictionary from DTO instance
-(NSDictionary *) writeToDictionary:(NearGasStationsResponseDTO *)instance;

@end