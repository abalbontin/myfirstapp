//
//  GasStationAnnotation.m
//  GasAll
//
//  Created by MBV15 on 03/01/14.
//  Copyright (c) 2014 Mobivery. All rights reserved.
//

#import "GasStationAnnotation.h"

@implementation GasStationAnnotation

- (CLLocationCoordinate2D)coordinate {
    
    return CLLocationCoordinate2DMake([self.gasStationDTO.latitude doubleValue], [self.gasStationDTO.longitude doubleValue]);
    
}

- (NSString *)title {

    return self.gasStationDTO.name;
    
}

- (NSString *)subtitle {
    
    // TODO: abalbontin: Implement correct subtitle.
    GasolinePriceDTO *gasolinePriceDTO = [self.gasStationDTO.gasolinePrice objectAtIndex:0];
    return [NSString stringWithFormat:@"Precio: %.3f", [gasolinePriceDTO.price doubleValue]];
    
}

@end
