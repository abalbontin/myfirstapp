//
//  GasStationDTO.h
//  GasAll
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GasStationDTO : NSObject <NSCopying, NSMutableCopying, NSCoding>


@property (nonatomic, strong) NSString *id;	///<  - Field name on service:id.
@property (nonatomic, strong) NSString *name;	///<  - Field name on service:name.
@property (nonatomic, strong) NSNumber *price95;	///<  - Field name on service:G95.
@property (nonatomic, strong) NSNumber *price98;	///<  - Field name on service:G98.
@property (nonatomic, strong) NSNumber *priceGOA;	///<  - Field name on service:GOA.
@property (nonatomic, strong) NSNumber *priceNGO;	///<  - Field name on service:NGO.
@property (nonatomic, strong) NSNumber *priceGPR;	///<  - Field name on service:GPR.
@property (nonatomic, strong) NSNumber *latitude;	///<  - Field name on service:latitude.
@property (nonatomic, strong) NSNumber *longitude;	///<  - Field name on service:longitude.
@property (nonatomic, strong) NSNumber *distance;	///<  - Field name on service:distance.
@property (nonatomic, strong) NSNumber *promoted;	///<  - Field name on service:promoted.
@property (nonatomic, strong) NSString *promotionText;	///<  - Field name on service:promotionText.
@property (nonatomic, strong) NSString *promotionImage;	///<  - Field name on service:promotionImage.
@property (nonatomic, strong) NSString *promotionCode;	///<  - Field name on service:promotionCode.
@property (nonatomic, strong) NSString *promotionTextExtra;	///<  - Field name on service:promotionTextExtra.


@end