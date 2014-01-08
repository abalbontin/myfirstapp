//
//  GasStationPlusDTO.h
//  GasAll
//
//  Created by MBV15 on 08/01/14.
//  Copyright (c) 2014 Mobivery. All rights reserved.
//

#import "GasStationDTO.h"

typedef NS_ENUM(NSUInteger, GSPriceType) {
    GSPriceLow,     // Green.
    GSPriceAverage, // Yellow.
    GSPriceHigh,    // Red.
    GSPriceWithout  // Si la gasolinera no tiene el tipo de gasolina que el usuario tiene configurado en ajustes.
};

@interface GasStationPlusDTO : GasStationDTO

@property (nonatomic) GSPriceType priceType;
@property (strong, nonatomic) UIImage *annotationImage;

- (id)initWithGasStationDTO:(GasStationDTO *)gasStationDTO;

@end
