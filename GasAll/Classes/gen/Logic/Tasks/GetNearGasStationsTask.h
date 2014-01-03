//
//  GetNearGasStationsTask.h
//  GasAll
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearGasStationsRequestDTO.h"
#import "NearGasStationsResponseDTO.h"
#import "GasStationsLogic.h"


@interface GetNearGasStationsTask : NSObject

+ (void) getNearGasStationsTaskForRequest:(NearGasStationsRequestDTO *)request completed:(void(^)(NSInteger statusCode,NearGasStationsResponseDTO *response))completedBlock error:(void(^)(NSError *error))errorBlock;

+ (void) getNearGasStationsTaskForRequest:(NearGasStationsRequestDTO *)request showLoadingView:(BOOL)showLoadingView completed:(void(^)(NSInteger statusCode,NearGasStationsResponseDTO *response))completedBlock error:(void(^)(NSError *error))errorBlock;

@end