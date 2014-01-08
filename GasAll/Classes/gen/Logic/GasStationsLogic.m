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
#import "GetNearGasStationsTask.h"

@implementation GasStationsLogic


// Get the shared instance and create it if necessary.
+ (GasStationsLogic *)sharedInstance {
    
    static dispatch_once_t onceQueue;
    static GasStationsLogic *instance = nil;
    
    dispatch_once(&onceQueue, ^{ instance = [[self alloc] init]; });
    return instance;
}

- (void)getNearGasStationsProcessedFromCoordinate:(CLLocationCoordinate2D)coordinate
                                        completed:(void(^)(NSArray *gasStations))completedBlock
                                            error:(void(^)(NSError *error))errorBlock {
    
    NearGasStationsRequestDTO *nearGasStationsRequestDTO = [[NearGasStationsRequestDTO alloc] init];
    nearGasStationsRequestDTO.latitude = [NSNumber numberWithDouble:coordinate.latitude];
    nearGasStationsRequestDTO.longitude = [NSNumber numberWithDouble:coordinate.longitude];
    [GetNearGasStationsTask getNearGasStationsTaskForRequest:nearGasStationsRequestDTO
                                                   completed:^(NSInteger statusCode, NearGasStationsResponseDTO *response) {
                                                       
                                                       if (completedBlock) {
                                                           
                                                           completedBlock([self processedGasStations:response.gasStations]);
                                                           
                                                       }
                                                       
                                                   } error:^(NSError *error) {
                                                       
                                                       if (errorBlock) {
                                                           
                                                           errorBlock(error);
                                                           
                                                       }
                                                       
                                                   }];
    
}

// Metodo que asigna precio y color del annotation a las GasStationDTO que se le pasa como parametro.
// Devuelve un array de GasStationPlusDTO con los nuevos valores calculados.
- (NSArray *)processedGasStations:(NSArray *)gasStations {
    
    // TODO: abalbontin: Implement.
    
    return gasStations;
    
}

@end

 