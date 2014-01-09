//
//  GasStationDTO.h
//  GasAll
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GasolinePriceDTO.h"


@interface GasStationDTO : NSObject <NSCopying, NSMutableCopying, NSCoding>


@property (nonatomic, strong) NSString *gasStationID;	///<  - Field name on service:gasStationID.
@property (nonatomic, strong) NSString *name;	///<  - Field name on service:name.
@property (nonatomic, strong) NSArray *gasolinesPrice;	///<  - Field name on service:gasolinesPrice.
@property (nonatomic, strong) NSNumber *latitude;	///<  - Field name on service:latitude.
@property (nonatomic, strong) NSNumber *longitude;	///<  - Field name on service:longitude.
@property (nonatomic, strong) NSNumber *distance;	///<  - Field name on service:distance.
@property (nonatomic, strong) NSNumber *promoted;	///<  - Field name on service:promoted.
@property (nonatomic, strong) NSString *promotionText;	///<  - Field name on service:promotionText.
@property (nonatomic, strong) NSString *promotionImage;	///<  - Field name on service:promotionImage.
@property (nonatomic, strong) NSString *promotionCode;	///<  - Field name on service:promotionCode.
@property (nonatomic, strong) NSString *promotionTextExtra;	///<  - Field name on service:promotionTextExtra.


@end