//
//  BaseGasStations.m
//  GasAll
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import "GasStationsLogic.h"

#import "MVYDefines.h"
#import "BaseGasStationsLogic.h"
#import "NearGasStationsRequestDTO.h"
#import "NearGasStationsResponseDTO.h"


@implementation GasStationsLogic


// Get the shared instance and create it if necessary.
+ (GasStationsLogic *)sharedInstance {
    
    static dispatch_once_t onceQueue;
    static GasStationsLogic *instance = nil;
    
    dispatch_once(&onceQueue, ^{ instance = [[self alloc] init]; });
    return instance;
}

@end

 