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

@interface GasStationsLogic : BaseGasStationsLogic
  // Get the shared instance and create it if necessary.
+ (GasStationsLogic *)sharedInstance;


@end