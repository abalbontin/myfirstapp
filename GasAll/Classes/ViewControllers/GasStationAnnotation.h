//
//  GasStationAnnotation.h
//  GasAll
//
//  Created by MBV15 on 03/01/14.
//  Copyright (c) 2014 Mobivery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "GasStationDTO.h"

@interface GasStationAnnotation : NSObject <MKAnnotation>

@property(strong, nonatomic) GasStationDTO *gasStationDTO;

@end
