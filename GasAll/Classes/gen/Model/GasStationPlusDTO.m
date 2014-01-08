//
//  GasStationPlusDTO.m
//  GasAll
//
//  Created by MBV15 on 08/01/14.
//  Copyright (c) 2014 Mobivery. All rights reserved.
//

#import "GasStationPlusDTO.h"

@implementation GasStationPlusDTO

- (id)initWithGasStationDTO:(GasStationDTO *)gasStationDTO {
    self = [super init];
    if (self) {
        // Custom initialization
        
        self.gasStationID = gasStationDTO.gasStationID;
        self.name = gasStationDTO.name;
        self.gasolinesPrice = gasStationDTO.gasolinesPrice;
        self.latitude = gasStationDTO.latitude;
        self.longitude = gasStationDTO.longitude;
        self.distance = gasStationDTO.distance;
        self.promoted = gasStationDTO.promoted;
        self.promotionText = gasStationDTO.promotionText;
        self.promotionImage = gasStationDTO.promotionImage;
        self.promotionCode = gasStationDTO.promotionCode;
        self.promotionTextExtra = gasStationDTO.promotionTextExtra;
        
        _priceType = GSPriceWithout;
        _annotationImage = nil;
        _currentGasPrice = 0.0;
        
    }
    return self;
}

@end
