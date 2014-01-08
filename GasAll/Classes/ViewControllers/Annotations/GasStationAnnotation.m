//
//  GasStationAnnotation.m
//  GasAll
//
//  Created by MBV15 on 03/01/14.
//  Copyright (c) 2014 Mobivery. All rights reserved.
//

#import "GasStationAnnotation.h"
#import "LocalizableConstants.h"
#import "SettingsLogic.h"

@implementation GasStationAnnotation

- (CLLocationCoordinate2D)coordinate {
    
    return CLLocationCoordinate2DMake([self.gasStationPlusDTO.latitude doubleValue], [self.gasStationPlusDTO.longitude doubleValue]);
    
}

- (NSString *)title {

    return [self.gasStationPlusDTO.name capitalizedString];
    
}

- (NSString *)subtitle {
    
    
    if (self.gasStationPlusDTO.currentGasPrice == 0.0) {
        
        return [NSString stringWithFormat:@"%@ %@", kLocaleWithout, [[[SettingsLogic sharedInstance] userGasolineSelected] name]];
        
    } else {
    
        return [NSString stringWithFormat:@"%.3f %@", self.gasStationPlusDTO.currentGasPrice, kLocaleGasolineMeasuredValue];
        
    }
    
}

@end
