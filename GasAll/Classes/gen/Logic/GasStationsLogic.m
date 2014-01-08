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
    
    // Orgenamos las gasolineras por precio y las dividimos entre precios bajos, medios y altos con la proporcion 30%, 40% 30%, de
    // esta forma evitamos que una gasolinera que tenga un precio muy bajo o muy alto con respecto al resto de como resultado que hay
    // pocas de un tipo.
    NSString *userGasID = [[[SettingsLogic sharedInstance] userGasolineSelected] gasID];
    
    for (GasStationPlusDTO *gasStationPlusDTO in gasStations) {
        
        for (GasolinePriceDTO *gasolinePriceDTO in gasStationPlusDTO.gasolinesPrice) {
            
            if ([gasolinePriceDTO.gasID isEqualToString:userGasID]) {
                
                gasStationPlusDTO.currentGasPrice = [gasolinePriceDTO.price doubleValue];
                
            }
            
        }
        
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"currentGasPrice" ascending:YES];
    gasStations = [gasStations sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    NSUInteger idx = 0;
    NSUInteger lowPriceLimit = gasStations.count * 0.3;
    NSUInteger averagePriceLimit = gasStations.count * 0.7;
    for (GasStationPlusDTO *gasStationPlusDTO in gasStations) {
        
        if (gasStationPlusDTO.currentGasPrice != 0.0) {

            // TODO: abalbontin: Queda calcular que ocurre cuando el ultimo precio de una categoria es el mismo del primera de la siguiente
            //                   categoria.
            if (idx <= lowPriceLimit) {
                
                gasStationPlusDTO.priceType = GSPriceLow;
                
            } else if (idx <= averagePriceLimit) {
            
                gasStationPlusDTO.priceType = GSPriceAverage;
                
            } else {
                
                gasStationPlusDTO.priceType = GSPriceHigh;
                
            }
        
        } else {
            
            gasStationPlusDTO.priceType = GSPriceWithout;
            
        }
            
        gasStationPlusDTO.annotationImage = [self annotationImageForGasStation:gasStationPlusDTO];
        
        idx++;
        
    }
    
    // TODO: abalbontin: Test.
//    NSLog(@"MAX: %f MIN: %f. Green: %f, Yellow: %f", maxPrice, minPrice, minPrice + ((maxPrice - minPrice) * 1/3), minPrice + ((maxPrice - minPrice) * 2/3));
    
    return gasStations;
    
}

- (UIImage *)annotationImageForGasStation:(GasStationPlusDTO *)gasStationPlusDTO {
    
    // TODO: abalbontin: Es necesario anyadir un tipo de imagen para cuando la gasolinera no tiene el tipo de gasolinea que el usuario
    //                   ha indicado en ajustes.
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
