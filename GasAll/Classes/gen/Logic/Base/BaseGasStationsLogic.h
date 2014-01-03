//
//  BaseGasStationsLogic
//  GasAll
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVYDefines.h"
#import "AFHTTPRequestOperation.h"
#import "NearGasStationsRequestDTO.h"
#import "NearGasStationsResponseDTO.h"

// Definimos macro para log
#ifndef _ModelGenLog

#ifdef SERVICE_DEBUG
 #define _ModelGenLog(...) NSLog(__VA_ARGS__)
#else
 #define _ModelGenLog(...) do { } while (0)
#endif

#endif // _ModelGenLog

#define AFNETWORKING_ALLOW_INVALID_SSL_CERTIFICATES 1

@interface BaseGasStationsLogic : NSObject


/**
* Method getNearGasStations: Devuelve las gasolineras que hay en la posicion que se pasa como parametro
* @param nearGasStationsRequestDTO Service request
* @returns NearGasStationsResponseDTO Service response
*/
- (void)getNearGasStations:(NearGasStationsRequestDTO *)nearGasStationsRequestDTO onSuccess:(void(^)(NSInteger responseCode,NearGasStationsResponseDTO *response))onSucces onError:(void(^)(NSError *error))onError;
-(NearGasStationsResponseDTO *) getNearGasStationsDTOFromOperation:(AFHTTPRequestOperation *)operation withError:(NSError **)error;



@end