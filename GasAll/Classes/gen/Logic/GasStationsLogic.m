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
#import "GasStationPlusDTO.h"
#import "SettingsLogic.h"
#import "GasolinePriceDTO.h"

@interface GasStationsLogic ()

- (UIImage *)annotationImageForGasStation:(GasStationPlusDTO *)gasStationPlusDTO;

@end

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
                                                           
                                                           NSMutableArray *gasStationsPlus = [NSMutableArray arrayWithCapacity:
                                                                                              response.gasStations.count];
                                                           
                                                           for (GasStationDTO *gasStationDTO in response.gasStations) {
                                                               
                                                               GasStationPlusDTO *gasStationPlusDTO = [[GasStationPlusDTO alloc]
                                                                                                       initWithGasStationDTO:gasStationDTO];
                                                               
                                                               [gasStationsPlus addObject:gasStationPlusDTO];
                                                               
                                                           }
                                                           
                                                           completedBlock([self processedGasStations:gasStationsPlus]);
                                                           
                                                       }
                                                       
                                                   } error:^(NSError *error) {
                                                       
                                                       if (errorBlock) {
                                                           
                                                           errorBlock(error);
                                                           
                                                       }
                                                       
                                                   }];
    
}

// Metodo que asigna a cada GasStationPlusDTO que se pasa como parametro los valores extras correspondiente segun la gasolinea seleccionada
// por el usuario en ajustes.
- (NSArray *)processedGasStations:(NSArray *)gasStations {
    
    CGFloat maxPrice = 0.0;
    CGFloat minPrice = DBL_MAX;
    NSString *userGasID = [[[SettingsLogic sharedInstance] userGasolineSelected] gasID];
    
    for (GasStationPlusDTO *gasStationPlusDTO in gasStations) {
        
        for (GasolinePriceDTO *gasolinePriceDTO in gasStationPlusDTO.gasolinesPrice) {
            
            if ([gasolinePriceDTO.gasID isEqualToString:userGasID]) {
            
                if (maxPrice < [gasolinePriceDTO.price doubleValue]) {
                    
                    maxPrice = [gasolinePriceDTO.price doubleValue];
                    
                }
                
                if (minPrice > [gasolinePriceDTO.price doubleValue]) {
                    
                    minPrice = [gasolinePriceDTO.price doubleValue];
                    
                }
                
                gasStationPlusDTO.currentGasPrice = [gasolinePriceDTO.price doubleValue];
                
                NSLog(@"Precio: %f", gasStationPlusDTO.currentGasPrice);
                
            }
            
        }
        
    }
    
    for (GasStationPlusDTO *gasStationPlusDTO in gasStations) {
        
        if (gasStationPlusDTO.currentGasPrice < minPrice + ((maxPrice - minPrice) * 1/3)) {
            
            gasStationPlusDTO.priceType = GSPriceLow;
            
        } else if (gasStationPlusDTO.currentGasPrice < minPrice + ((maxPrice - minPrice) * 2/3)) {
            
            gasStationPlusDTO.priceType = GSPriceAverage;
            
        } else {
            
            gasStationPlusDTO.priceType = GSPriceHigh;
            
        }
        
        gasStationPlusDTO.annotationImage = [self annotationImageForGasStation:gasStationPlusDTO];
    
    }
    
    // TODO: abalbontin: Test.
    NSLog(@"MAX: %f MIN: %f. Green: %f, Yellow: %f", maxPrice, minPrice, minPrice + ((maxPrice - minPrice) * 1/3), minPrice + ((maxPrice - minPrice) * 2/3));
    
    return gasStations;
    
}

- (UIImage *)annotationImageForGasStation:(GasStationPlusDTO *)gasStationPlusDTO {
    
    NSString *priceType;
    switch (gasStationPlusDTO.priceType) {
        case GSPriceLow:
            priceType = @"green";
            break;
            
        case GSPriceAverage:
            priceType = @"yellow";
            break;
            
        default:
            priceType = @"red";
            break;
    }
    
    UIImage *annotationImage = [UIImage imageNamed:[NSString stringWithFormat:@"map_annotation_%@_%@",
                                                    [gasStationPlusDTO.name lowercaseString], priceType]];
    
    if (annotationImage == nil) {
        
        annotationImage = [UIImage imageNamed:[NSString stringWithFormat:@"map_annotation_generic_%@", priceType]];
        
    }
    
    return annotationImage;
    
}

@end
