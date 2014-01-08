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

@property (nonatomic) GSPriceType priceType;            // Indica si el precio es bajo, medio o alto.
@property (strong, nonatomic) UIImage *annotationImage; // Imagen a usar para el annotation (con el logo y color del tipo de precio)
@property (nonatomic) CGFloat currentGasPrice;          // Precio del tipo de gasolina seleccionado en ajustes. 0.0 si no tiene dicho tipo.

- (id)initWithGasStationDTO:(GasStationDTO *)gasStationDTO;

@end
