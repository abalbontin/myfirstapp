//
//  GasStationsLogic.h
//  GasAll
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVYDefines.h"
#import "BaseGasStationsLogic.h"
#import "NearGasStationsRequestDTO.h"
#import "NearGasStationsResponseDTO.h"
#import <CoreLocation/CoreLocation.h>

@interface GasStationsLogic : BaseGasStationsLogic
  // Get the shared instance and create it if necessary.
+ (GasStationsLogic *)sharedInstance;

- (void)getNearGasStationsProcessedFromCoordinate:(CLLocationCoordinate2D)coordinate
                                        completed:(void(^)(NSArray *gasStations))completedBlock
                                            error:(void(^)(NSError *error))errorBlock;

// Metodo que asigna a cada GasStationPlusDTO que se pasa como parametro los valores extras correspondiente segun la gasolinea seleccionada
// por el usuario en ajustes.
- (NSArray *)processedGasStations:(NSArray *)gasStations;

@end