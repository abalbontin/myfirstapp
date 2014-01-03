//
//  NearGasStationsRequestDTO.h
//  GasAll
//  Version: 3.0
//
//  Created by Mobivery
//  Copyright (c) 2012 Mobivery. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NearGasStationsRequestDTO : NSObject <NSCopying, NSMutableCopying, NSCoding>


@property (nonatomic, strong) NSNumber *latitude;	///<  - Field name on service:latitude.
@property (nonatomic, strong) NSNumber *longitude;	///<  - Field name on service:longitude.


@end