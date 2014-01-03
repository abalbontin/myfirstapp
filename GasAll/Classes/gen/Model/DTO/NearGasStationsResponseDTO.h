//
//  NearGasStationsResponseDTO.h
//  GasAll
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GasStationDTO.h"


@interface NearGasStationsResponseDTO : NSObject <NSCopying, NSMutableCopying, NSCoding>


@property (nonatomic, strong) NSArray *gasStations;	///<  - Field name on service:gasStations.


@end