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
    return [NSString stringWithFormat:@"Precio: %.2f", [self.gasStationDTO.price95 doubleValue]];
    
}

@end
