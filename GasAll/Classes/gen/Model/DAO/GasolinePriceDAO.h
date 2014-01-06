//
//  GasolinePriceDAO.h
//  GasAll
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GasolinePriceDTO.h"

@interface GasolinePriceDAO : NSObject

// Get the shared instance and create it if necessary.
+ (GasolinePriceDAO *)sharedInstance;

// Set DTOs values from Dictionary
-(GasolinePriceDTO *) readFromDictionary:(NSDictionary *)dict;

// Creates a DTO array from Dictionary array
-(NSArray *) readFromDictionaryArray:(NSArray *)dictArray;

// Creates a json dictionary from DTO instance
-(NSDictionary *) writeToDictionary:(GasolinePriceDTO *)instance;

@end